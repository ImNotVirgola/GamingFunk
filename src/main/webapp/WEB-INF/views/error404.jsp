<%@ page contentType="text/html;charset=UTF-8" language="java" %>
 <html>
 <head>
     <title>Page Not Found</title>
    <link rel="stylesheet" type="text/css" href="css/catalogo.css">
 </head>
 <body>
 	<nav class="navbar">
    	<div class="navbar-left">
            <img src="images/logo/logo.png" alt="Logo" class="logo">
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
     <h1>Error 404: Page Not Found</h1>
     <p>Sorry, the page you are looking for does not exist.</p>
 </body>
 </html>
