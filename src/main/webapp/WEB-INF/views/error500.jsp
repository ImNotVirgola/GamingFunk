 <%@ page contentType="text/html;charset=UTF-8" language="java" %>
 <html>
 <head>
     <title>Internal Server Error</title>
     <link rel="stylesheet" type="text/css" href="css/error.css">
 </head>
 <body>
	<nav class="navbar">
        <div class="navbar-left">
            <img src="images/logo/logo.png" alt="Logo" class="logo">
        </div>
        <div class="navbar-center">
            <a href="catalogo.jsp">Catalogo</a>
            <a href="community.jsp" class="active">Community</a>
            <a href="blog.jsp">Blog</a>
            <a href="carrello.jsp">Carrello</a>
        </div>
        <div class="navbar-right">
            <% if (session.getAttribute("utente") != null) { %>
            <div class="profile-actions">
                <span class="user-name-navbar"><%
                    String nome = (String) session.getAttribute("nome");
                    if (nome != null && !nome.isEmpty()) {
                        out.print(nome);
                    }
                %></span>
                <a href="profilo.jsp">
                    <img src="${pageContext.request.contextPath}/<%= session.getAttribute("fotoProfilo") != null ? session.getAttribute("fotoProfilo") : "images/default/profile.png" %>" alt="Foto Profilo" class="profile-pic">
                </a>
                <form action="logout" method="post" style="display: inline;">
                    <button type="submit" class="btn-logout">Logout</button>
                </form>
            </div>
            <% } else { %>
            <div class="auth-buttons">
                <button class="btn-login" onclick="window.location.href='login.jsp'">Login</button>
                <button class="btn-register" onclick="window.location.href='register.jsp'">Registrazione</button>
            </div>
            <% } %>
        </div>
    </nav>
     <h1>Error 500: Internal Server Error</h1>
     <p>Sorry, something went wrong on our end. Please try again later.</p>
 </body>
