<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - GamingFunk</title>
    <link href="css/login.css" rel="stylesheet" type="text/css">
</head>
<body>
    <!-- Navbar -->
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
        </div>
    </nav>

    <!-- Contenitore principale -->
    <div class="container">
        <h1>🔑 Accesso</h1>

        <!-- Messaggio di errore -->
        <%
            // Verifica se ci sono messaggi di errore passati tramite request o session
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) {
        %>
                <div class="error-message">
                    <%= errorMessage %>
                </div>
        <%
            }
        %>

        <!-- Form di login -->
        <form class="login-form" action="login" method="post">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>

            <br>
            Non sei registrato?
            <br>
            <a href="register.jsp">Registrati Qui!!!</a>

            <button type="submit" class="btn">Login</button>
        </form>
    </div>
</body>
</html>