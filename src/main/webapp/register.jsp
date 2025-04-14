<%@ page import="javax.servlet.http.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrazione - GamingFunk</title>
    <link href="css/register.css" rel="stylesheet" type="text/css">
</head>
<body>
    <!-- Navbar -->
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
	    </div>
	</nav>

    <!-- Contenitore principale -->
    <div class="container">
        <h1>📝 Registrazione</h1>
        
        <!-- Form di registrazione -->
        <form class="register-form" action="register" method="post">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>

            <label for="confirmPassword">Conferma Password:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required>

			<!-- Link al login -->
	        <div class="link">
	            Hai già un account? <a href="${pageContext.request.contextPath}/login.jsp">Accedi qui</a>.
	        </div>
        
            <button type="submit" class="btn">Registrati</button>
        </form>
    </div>
</body>
</html>