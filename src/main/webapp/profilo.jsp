<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profilo Utente - GamingFunk</title>
    <link href="${pageContext.request.contextPath}/css/profilo.css" rel="stylesheet" type="text/css">
</head>
<body>
    <!-- Navbar -->
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
                    if (fotoProfilo == null || fotoProfilo.isEmpty()) {
                        fotoProfilo = "images/default/profile.png";
                    }
            %>
            <div class="profile-actions">
                <span class="user-name-navbar"><%
                    String nome = (String) session.getAttribute("nome");
                    if (nome != null && !nome.isEmpty()) {
                        out.print(nome);
                    }
                %></span>
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

    <!-- Contenitore principale -->
    <div class="container">
        <h1>Profilo Utente</h1>

        <%
            // Verifica se l'utente è connesso
            if (session == null || session.getAttribute("utente") == null) {
                response.sendRedirect("login.jsp"); // Reindirizza se l'utente non è connesso
            } else {
                // Recupera i dati dell'utente dalla sessione
                String nome = (String) session.getAttribute("nome");
                String cognome = (String) session.getAttribute("cognome");
                String email = (String) session.getAttribute("email");
                String indirizzo = (String) session.getAttribute("indirizzo");
                String citta = (String) session.getAttribute("citta");
                String provincia = (String) session.getAttribute("provincia");
                String cap = (String) session.getAttribute("cap");
                String password = (String) session.getAttribute("password");
                String fotoProfilo = (String) session.getAttribute("fotoProfilo");

                // Fallback per utenti senza foto profilo
                if (fotoProfilo == null || fotoProfilo.isEmpty()) {
                    fotoProfilo = "images/default/profile.png";
                }
        %>

        <!-- Foto Profilo -->
        <div class="profile-picture">
            <img src="${pageContext.request.contextPath}/<%= fotoProfilo %>" alt="Foto Profilo" class="profile-pic-large">
        </div>

        <!-- Visualizzazione dei dati dell'utente -->
        <div class="user-info">
            <p><b>Email:</b> <%= email %></p>
            <p><b>Nome:</b> <%= nome %></p>
            <p><b>Cognome:</b> <%= cognome %></p>
            <p><b>Indirizzo:</b> <%= indirizzo != null ? indirizzo : "Non specificato" %></p>
            <p><b>Città:</b> <%= citta != null ? citta : "Non specificata" %></p>
            <p><b>Provincia:</b> <%= provincia != null ? provincia : "Non specificata" %></p>
            <p><b>CAP:</b> <%= cap != null ? cap : "Non specificato" %></p>
        
	        <!-- Pulsante per modificare i dati -->
	        <button id="edit-profile-btn" class="btn-save">Modifica Dati</button>
        </div>

        <!-- Form per la modifica dei dati -->
        <div id="edit-form" class="edit-form" style="display: none;">
            <h2>Modifica Dati</h2>
            <form action="updateProfile" method="post" enctype="multipart/form-data">
                <label for="nome">Nome:</label>
                <input type="text" id="nome" name="nome" value="<%= nome %>" required>

                <label for="cognome">Cognome:</label>
                <input type="text" id="cognome" name="cognome" value="<%= cognome %>" required>

                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="<%= email %>" required>

                <label for="indirizzo">Indirizzo:</label>
                <input type="text" id="indirizzo" name="indirizzo" value="<%= indirizzo != null ? indirizzo : "" %>">

                <label for="citta">Città:</label>
                <input type="text" id="citta" name="citta" value="<%= citta != null ? citta : "" %>">

                <label for="provincia">Provincia:</label>
                <input type="text" id="provincia" name="provincia" value="<%= provincia != null ? provincia : "" %>">

                <label for="cap">CAP:</label>
                <input type="text" id="cap" name="cap" value="<%= cap != null ? cap : "" %>">

                <label for="password">Password:</label>
                <input type="password" id="password" name="password" placeholder="Lascia vuoto per mantenere la password attuale">

                <label for="immagine">Carica immagine profilo:</label>
                <input type="file" id="immagine" name="immagine" accept="image/*">

                <button type="submit" class="btn-save">Salva Modifiche</button>
            </form>
        </div>
        <%
            }
        %>
    </div>

    <script>
        // Funzione per mostrare/nascondere il form di modifica
        function toggleEditForm() {
            var editForm = document.getElementById("edit-form");
            if (editForm.style.display === "none" || editForm.style.display === "") {
                editForm.style.display = "block"; // Mostra il form
            } else {
                editForm.style.display = "none"; // Nascondi il form
            }
        }

        // Aggiungi un listener al pulsante "Modifica Dati"
        document.getElementById("edit-profile-btn").addEventListener("click", toggleEditForm);
    </script>
</body>
</html>