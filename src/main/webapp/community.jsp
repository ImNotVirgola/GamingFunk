<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Community - GamingFunk</title>
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
            <%
                // Verifica se l'utente è loggato
                if (session.getAttribute("utente") != null) {
                    String fotoProfilo = (String) session.getAttribute("fotoProfilo");
                    if (fotoProfilo == null || fotoProfilo.isEmpty()) {
                    	fotoProfilo = "images/default/profile.png";
                    }
            %>
            <div class="profile-actions">
                <a href="profilo.jsp">
                    <img src="${pageContext.request.contextPath}/<%= fotoProfilo %>" alt="Foto Profilo" class="profile-pic">
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
        <h1>Community</h1>
        <a href="CommunityServlet?action=nuova" class="btn-new">Crea nuova community</a>
        <div class="community-list">
            <%-- Qui verrà inserita la lista delle community tramite backend --%>
            <jsp:include page="/CommunityServlet" />
        </div>
    </div>
</body>
</html>
