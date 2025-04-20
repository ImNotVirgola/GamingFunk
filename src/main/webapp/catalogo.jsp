<%@ page import="javax.servlet.http.*" %> 
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <%
        // Reindirizza alla servlet /catalogo se la pagina è stata richiamata direttamente
        if (request.getAttribute("fromServlet") == null) {
            response.sendRedirect(request.getContextPath() + "/catalogo");
            return;
        } else {
            request.setAttribute("formServlet", null);
        }
    %>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Catalogo GamingFunk</title>
    <link href="${pageContext.request.contextPath}/css/catalogo.css" rel="stylesheet" type="text/css">
</head>
<body>
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
            <%
                // Verifica se l'utente è loggato
                if (session.getAttribute("utente") != null) {
                    String fotoProfilo = (String) session.getAttribute("fotoProfilo");
            %>
            <div class="profile-actions">
                <a href="profilo.jsp">
                    <img src="${pageContext.request.contextPath}<%= fotoProfilo != null ? fotoProfilo : "images/default/profile.png" %>" alt="Foto Profilo" class="profile-pic">
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
        <h1>🎭 Catalogo GamingFunk 🎨</h1>
        <div class="search-bar">
            <input type="text" id="search-input" placeholder="Cerca nel catalogo..." oninput="filtraProdotti()">
            <button class="btn-search">Cerca</button>
            <!-- Pulsante per mostrare/nascondere i filtri -->
            <button class="btn-filtri" onclick="toggleFiltri()">Filtra</button>
            <%
                // Verifica se l'utente è admin
                if (session != null && session.getAttribute("ruolo") != null && session.getAttribute("ruolo").equals("admin")) {
            %>
            <button class="btn-add-product-circle" onclick="window.location.href='aggiungi-prodotto.jsp'">
                +
            </button>
            <%
                }
            %>
        </div>
        <!-- Menu dei filtri -->
        <div id="menu-filtri" style="display: none; margin-top: 20px;">
            <label for="filtro-categoria">Categoria:</label>
            <select id="filtro-categoria" onchange="cambiaPaginaConFiltro()">
                <option value="tutti" <%= "tutti".equals(request.getParameter("categoria")) ? "selected" : "" %>>Tutte</option>
                <%
                    // Recupera le categorie dalla request (assumendo che siano state passate dal server)
                    java.util.List<?> categorie = (java.util.List<?>) request.getAttribute("categorie");
                    if (categorie != null) {
                        for (Object categoriaObj : categorie) {
                            Object categoria = categoriaObj;
                            String nomeCategoria = (String) categoria.getClass().getMethod("getNomeCategoria").invoke(categoria);
                %>
                <option value="<%= nomeCategoria %>" <%= nomeCategoria.equals(request.getParameter("categoria")) ? "selected" : "" %>><%= nomeCategoria %></option>
                <%
                        }
                    }
                %>
            </select>
        </div>
        <div class="catalogo" id="catalogo-container">
            <%
                // Recupera la lista di prodotti dalla request
                java.util.List<?> prodotti = (java.util.List<?>) request.getAttribute("prodotti");
                if (prodotti != null) {
                    int counter = 1; // Contatore per generare ID univoci
                    for (Object prodottoObj : prodotti) {
                        Object prodotto = prodottoObj;
                        String nome = (String) prodotto.getClass().getMethod("getNome").invoke(prodotto);
                        double prezzo = (double) prodotto.getClass().getMethod("getPrezzo").invoke(prodotto);
                        String pathImmagine = (String) prodotto.getClass().getMethod("getPathImmagine").invoke(prodotto);
            %>
                        <div class="prodotto" id="prod<%= counter %>" data-nome="<%= nome.toLowerCase() %>">
                            <img src="<%= pathImmagine %>" alt="<%= nome %>">
                            <h2><%= nome %></h2>
                            <p>Descrizione del prodotto...</p>
                            <p class="prezzo">€ <%= prezzo %></p>
                            <%
                                // Verifica se l'utente è loggato
                                if (session.getAttribute("utente") != null) {
                            %>
                            <form action="aggiungi-al-carrello" method="post" style="display: inline;">
                                <input type="hidden" name="nome" value="<%= nome %>">
                                <input type="hidden" name="prezzo" value="<%= prezzo %>">
                                <button type="submit" class="btn aggiungi-carrello">Aggiungi al carrello</button>
                            </form>
                            <%
                                } else {
                            %>
                            <button class="btn aggiungi-carrello" onclick="mostraPopup()">Aggiungi al carrello</button>
                            <%
                                }
                            %>
                        </div>
            <%
                        counter++;
                    }
                }
            %>
        </div>
    </div>
    <!-- Popup Container -->
    <div id="popup-container" style="display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); background: #222222; color: white; padding: 20px; border-radius: 10px; box-shadow: 5px 5px 10px rgba(0, 0, 0, 0.5); z-index: 1000;">
        <p>Devi effettuare il login per aggiungere prodotti al carrello!</p>
        <button onclick="nascondiPopup()" style="background-color: #FF007F; color: white; border: none; padding: 10px; border-radius: 5px; cursor: pointer;">Chiudi</button>
    </div>
    <div id="overlay" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.5); z-index: 999;"></div>
    <script type="text/javascript">	
        // Funzione per mostrare/nascondere il menu dei filtri
        function toggleFiltri() {
            const menuFiltri = document.getElementById('menu-filtri');
            if (menuFiltri.style.display === 'none' || menuFiltri.style.display === '') {
                menuFiltri.style.display = 'block';
            } else {
                menuFiltri.style.display = 'none';
            }
        }

        // Funzione per applicare i filtri cambiando pagina con il parametro di query "categoria"
        function cambiaPaginaConFiltro() {
            const selectElement = document.getElementById("filtro-categoria");
            const categoriaId = selectElement.value;
            let url = window.location.pathname; // Ottieni il percorso corrente
            if (categoriaId) {
                url += "?categoria=" + encodeURIComponent(categoriaId);
            }
            window.location.href = url;
        }

        // Funzione per mostrare il popup
        function mostraPopup() {
            document.getElementById('popup-container').style.display = 'block';
            document.getElementById('overlay').style.display = 'block';
        }

        // Funzione per nascondere il popup
        function nascondiPopup() {
            document.getElementById('popup-container').style.display = 'none';
            document.getElementById('overlay').style.display = 'none';
        }

        // Funzione per filtrare i prodotti in base alla ricerca
        function filtraProdotti() {
            const input = document.getElementById('search-input');
            const filter = input.value.toLowerCase();
            const catalogo = document.getElementById('catalogo-container');
            const prodotti = catalogo.getElementsByClassName('prodotto');

            for (let i = 0; i < prodotti.length; i++) {
                const nomeProdotto = prodotti[i].getAttribute('data-nome');
                if (nomeProdotto.includes(filter)) {
                    prodotti[i].style.display = '';
                } else {
                    prodotti[i].style.display = 'none';
                }
            }
        }
    </script>
</body>
</html>