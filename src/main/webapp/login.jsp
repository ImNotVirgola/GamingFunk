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

        <!-- Messaggi di successo o errore -->
        <%
            if (session != null) {
                // Messaggio di successo (es. registrazione riuscita)
                String successMessage = (String) session.getAttribute("successMessage");
                if (successMessage != null) {
        %>
                    <div class="success-message">
                        <%= successMessage %>
                    </div>
        <%
                    session.removeAttribute("successMessage");
                }

                // Messaggio di errore (es. credenziali errate)
                String errorMessage = (String) session.getAttribute("errorMessage");
                if (errorMessage != null) {
        %>
                    <div class="error-message">
                        <%= errorMessage %>
                    </div>
        <%
                    session.removeAttribute("errorMessage");
                }
            }
        %>

        <!-- Form di login -->
        <form class="login-form" action="login" method="post">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" placeholder = "Es. prova@example.it" required>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" placeholder = "Inserisci la tua password" required>

            <br>
            Non sei registrato?
            <br>
            <a href="register.jsp">Registrati Qui!!!</a>

            <button type="submit" class="btn">Login</button>
        </form>
    </div>
</body>
</html>
