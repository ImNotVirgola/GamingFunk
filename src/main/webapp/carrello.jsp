<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="it">
	<head>
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <title>Carrello - GamingFunk</title>
	    <link href="css/carrello.css" rel="stylesheet" type="text/css">
	</head>
	
	<body>
	    <nav class="navbar">
	        <div class="navbar-left">
	            <img src="images/logo/logo.png" alt="Logo" class="logo">
	        </div>
	        <div class="navbar-center">
	            <a href="catalogo.jsp">Catalogo</a>
	            <a href="CommunityServlet">Community</a>
	            <a href="blog.jsp">Blog</a>
	            <a href="carrello.jsp">Carrello</a>
	        </div>
	        <div class="navbar-right">
	            <%
	                // Verifica se l'utente è loggato
	                if (session.getAttribute("utente") != null) {
	                    String fotoProfilo = (String) session.getAttribute("fotoProfilo");
	            %>
	            <div class="profile-actions">
	                <a href="profilo.jsp">
                    	<img src="${pageContext.request.contextPath}/<%= fotoProfilo != null ? fotoProfilo : "images/default/profile.png" %>" alt="Foto Profilo" class="profile-pic">
	                </a>
	                <form action="logout" method="post" style="display: inline;">
	                    <button type="submit" class="btn-logout">Logout</button>
	                </form>
	            </div>
	            <%
	                } else {
	            %>
	            <div class="auth-buttons">
	                <button class="btn-login" onclick="window.location.href='login.jsp'">Login</button>
	                <button class="btn-register" onclick="window.location.href='register.jsp'">Registrazione</button>
	            </div>
	            <%
	                }
	            %>
	        </div>
	    </nav>
	
	    <div class="container">
	        <h1>🛒 Il tuo carrello</h1>
	        <div class="carrello">
	            <ul id="lista-carrello">
	                <%
	                    // Recupera il carrello dalla sessione
	                    @SuppressWarnings("unchecked")
	                    java.util.List<Map<String, Object>> carrello = (java.util.List<Map<String, Object>>) session.getAttribute("carrello");
	
	                    double totalePrezzo = 0;
	
	                    if (carrello == null || carrello.isEmpty()) {
	                %>
	                        <li>Il tuo carrello è vuoto.</li>
	                <%
	                    } else {
	                        for (Map<String, Object> item : carrello) {
	                            String nome = (String) item.get("nome");
	                            double prezzo = Double.parseDouble(item.get("prezzo").toString());
	                            int quantita = Integer.parseInt(item.get("quantità").toString());
	
	                            totalePrezzo += prezzo * quantita;
	                %>
	                            <li>
	                                <%= nome %> - €<%= String.format("%.2f", prezzo) %> x <%= quantita %>
	                                <form action="rimuovi-dal-carrello" method="post" style="display: inline;">
	                                    <input type="hidden" name="indice" value="<%= carrello.indexOf(item) %>">
	                                    <button type="submit" class="btn">Rimuovi</button>
	                                </form>
	                            </li>
	                <%
	                        }
	                    }
	                %>
	            </ul>
	            <p>Totale: €<%= String.format("%.2f", totalePrezzo) %></p>
	            <form action="svuota-carrello" method="post" style="display: inline;">
	                <button type="submit" class="btn-svuota-carrello">Svuota Carrello</button>
	            </form>
	        </div>
	    </div>
	</body>
</html>