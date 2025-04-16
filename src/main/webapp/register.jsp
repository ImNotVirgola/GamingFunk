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
        <div class="navbar-right"></div>
    </nav>

    <!-- Contenitore principale -->
    <div class="container">
        <h1>📝 Registrazione</h1>

        <!-- Messaggio di errore (visibile solo se presente) -->
        <%
            session = request.getSession(false);
            if (session != null) {
                String errorMessage = (String) session.getAttribute("errorMessage");
                if (errorMessage != null && !errorMessage.isEmpty()) {
        %>
        <div class="error-message">
            <%= errorMessage %>
        </div>
        <%
                    session.removeAttribute("errorMessage"); // Rimuovi il messaggio dopo averlo visualizzato
                }
            }
        %>

        <!-- Form di registrazione -->
        <form class="register-form" action="register" method="post">
            <!-- Layout a due colonne -->
            <div class="form-grid">
                <!-- Colonna Sinistra -->
                <div class="form-column">
                    <div class="form-group">
                        <label for="nome">Nome:</label>
                        <input type="text" id="nome" name="nome" required>
                    </div>
                    <div class="form-group">
                        <label for="cognome">Cognome:</label>
                        <input type="text" id="cognome" name="cognome" required>
                    </div>
                    <div class="form-group">
                        <label for="email">Email:</label>
                        <input type="email" id="email" name="email" required>
                    </div>
                    <div class="form-group">
                        <label for="password">Password:</label>
                        <input type="password" id="password" name="password" required>
                    </div>
                    <div class="form-group">
                        <label for="confirmPassword">Conferma Password:</label>
                        <input type="password" id="confirmPassword" name="confirmPassword" required>
                    </div>
                </div>

                <!-- Colonna Destra -->
                <div class="form-column">
                    <div class="form-group">
                        <label for="indirizzo">Indirizzo:</label>
                        <input type="text" id="indirizzo" name="indirizzo">
                    </div>
                    <div class="form-group">
                        <label for="citta">Città:</label>
                        <input type="text" id="citta" name="citta">
                    </div>
                    <div class="form-group">
                        <label for="provincia">Provincia:</label>
                        <input type="text" id="provincia" name="provincia">
                    </div>
                    <div class="form-group">
                        <label for="cap">CAP:</label>
                        <input type="text" id="cap" name="cap">
                    </div>
                </div>
            </div>

            <!-- Link al login e pulsante di invio -->
            <div class="form-footer">
                <div class="link">
                    Hai già un account? <a href="${pageContext.request.contextPath}/login.jsp">Accedi qui</a>.
                </div>
                <button type="submit" class="btn">Registrati</button>
            </div>
        </form>
    </div>
</body>
</html>