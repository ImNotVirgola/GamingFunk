<%@ page import="javax.servlet.http.*" %> 
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <%
        if (request.getAttribute("fromServlet") == null) {
            // Logica da eseguire solo se la pagina è stata richiamata direttamente
            response.sendRedirect(request.getContextPath() + "/catalogo");
            return;
        } else {
            request.setAttribute("formServlet", null);
        }
    %>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Catalogo GamingFunk</title>
    <link href="${pageContext.request.contextPath}/css/catalogo.css" rel="stylesheet" type="text/css">
</head>
<body>
    <nav class="navbar">
        <div class="navbar-left">
            <img src="path/to/logo.png" alt="Logo" class="logo">
        </div>
        <div class="navbar-center">
            <a href="catalogo.jsp">Catalogo</a>
            <a href="community.jsp">Community</a>
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
                    <img src="<%= fotoProfilo != null ? fotoProfilo : "images/default/profile.png" %>" alt="Foto Profilo" class="profile-pic">
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
        <h1>🎭 Catalogo GamingFunk 🎨</h1>
        <div class="search-bar">
            <input type="text" placeholder="Cerca nel catalogo...">
            <button class="btn-search">Cerca</button>
            <%
                // Verifica se l'utente è admin
                if (session != null && session.getAttribute("ruolo") != null && session.getAttribute("ruolo").equals("admin")) {
            %>
            <button class="btn-add-product-circle" onclick="window.location.href='aggiungi-prodotto.jsp'">
                +
            </button>
            <%
                }
            %>
        </div>
        <div class="catalogo">
            <%
                // Recupera la lista di prodotti dalla request
                java.util.List<?> prodotti = (java.util.List<?>) request.getAttribute("prodotti");
                if (prodotti != null) {
                    int counter = 1; // Contatore per generare ID univoci
                    for (Object prodottoObj : prodotti) {
                        // Assumi che ogni prodotto sia un oggetto con getter per nome, prezzo e pathImmagine
                        Object prodotto = prodottoObj;
                        String nome = (String) prodotto.getClass().getMethod("getNome").invoke(prodotto);
                        double prezzo = (double) prodotto.getClass().getMethod("getPrezzo").invoke(prodotto);
                        String pathImmagine = (String) prodotto.getClass().getMethod("getPathImmagine").invoke(prodotto);
            %>
                        <div class="prodotto" id="prod<%= counter %>">
                            <img src="<%= pathImmagine %>" alt="<%= nome %>">
                            <h2><%= nome %></h2>
                            <p>Descrizione del prodotto...</p>
                            <p class="prezzo">€ <%= prezzo %></p>
                            <form action="aggiungi-al-carrello" method="post" style="display: inline;">
                                <input type="hidden" name="nome" value="<%= nome %>">
                                <input type="hidden" name="prezzo" value="<%= prezzo %>">
                                <button type="submit" class="btn aggiungi-carrello">Aggiungi al carrello</button>
                            </form>
                        </div>
            <%
                        counter++;
                    }
                }
            %>
        </div>
    </div>
    <script type="text/javascript">
        document.addEventListener("DOMContentLoaded", function () {
            // Funzione per creare un popup
            function creaPopup(messaggio) {
                const container = document.querySelector('.popup-container') || creaPopupContainer();

                const popup = document.createElement('div');
                popup.className = 'popup';
                popup.textContent = messaggio;

                container.appendChild(popup);

                setTimeout(() => {
                    popup.remove();
                }, 3000);

                if (container.children.length > 3) {
                    setTimeout(() => {
                        container.removeChild(container.firstChild);
                    }, 500);
                }
            }

            // Funzione per creare il contenitore dei popup se non esiste
            function creaPopupContainer() {
                const container = document.createElement('div');
                container.className = 'popup-container';
                document.body.appendChild(container);
                return container;
            }
        });
    </script>
</body>
</html>