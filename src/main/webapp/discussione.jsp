<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Discussione - GamingFunk</title>
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
                <a href="profilo.jsp">
                    <img src="${pageContext.request.contextPath}<%= session.getAttribute("fotoProfilo") != null ? session.getAttribute("fotoProfilo") : "images/default/profile.png" %>" alt="Foto Profilo" class="profile-pic">
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
        <h1>Discussione</h1>
        <div class="discussion-detail">
            <%-- Qui verrà inserito il dettaglio della discussione tramite backend --%>
            <jsp:include page="DiscussioneServlet" />
        </div>
        <a href="DiscussioneServlet?action=nuovoPost&discussioneId=${param.discussioneId}" class="btn-new">Rispondi</a>
    </div>
</body>
</html>
