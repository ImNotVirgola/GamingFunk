<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nuova Discussione - GamingFunk</title>
    <link href="${pageContext.request.contextPath}/css/community.css" rel="stylesheet" type="text/css">
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
    <div class="container">
        <h1>Nuova Discussione</h1>
        <form action="DiscussioneServlet" method="post">
            <input type="hidden" name="action" value="creaDiscussione">
            <input type="hidden" name="forumId" value="${param.forumId}">
            <label for="titolo">Titolo:</label>
            <input type="text" id="titolo" name="titolo" required>
            <label for="contenuto">Contenuto:</label>
            <textarea id="contenuto" name="contenuto" required></textarea>
            <button type="submit" class="btn-new">Crea Discussione</button>
        </form>
    </div>
</body>
</html>
