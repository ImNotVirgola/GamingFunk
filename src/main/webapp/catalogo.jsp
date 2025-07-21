<%@ page import="javax.servlet.http.*" %> 
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Catalogo GamingFunk</title>
    <link href="${pageContext.request.contextPath}/css/catalogo.css" rel="stylesheet" type="text/css">
</head>
<body>
    <%@ include file = "fragments/header.jspf"%>
    <main>
    	<div class="container">
	        <h1>🎭 Catalogo GamingFunk 🎨</h1>
	
	        <div class="search-bar">
	            <input type="text" id="searchInput" placeholder="Cerca nel catalogo..." 
	                   onkeyup="fetchSuggestions()" onfocus="showHistory()" autocomplete="off">
	            <div id="suggestions" class="suggestion-box"></div>
	            <button class="btn-filtri" onclick="toggleFiltri()">Filtra</button>
	            <% if (isAdmin) { %>
	                <button class="btn-add-product-circle" onclick="window.location.href='modInsProdotto.jsp'">+</button>
				<% } %>
	        </div>
	
	        <div id="menu-filtri" style="display: none; margin-top: 20px;">
	            <label for="filtro-categoria">Categoria:</label>
	            <select id="filtro-categoria" onchange="cambiaPaginaConFiltro()">
	                <option value="tutti" <%= "tutti".equals(request.getParameter("categoria")) ? "selected" : "" %>>Tutte</option>
	                <%
	                    java.util.List<?> categorie = (java.util.List<?>) request.getAttribute("categorie");
	                    if (categorie != null) {
	                        for (Object cat : categorie) {
	                            String nomeCategoria = (String) cat.getClass().getMethod("getNomeCategoria").invoke(cat);
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
	                java.util.List<?> prodotti = (java.util.List<?>) request.getAttribute("prodotti");
		            if (prodotti == null) {
		                response.sendRedirect(request.getContextPath() + "/catalogo");
		                return;
		            }
	                if (prodotti != null) {
	                    int counter = 1;
	                    for (Object prodotto : prodotti) {
	                        String nome = (String) prodotto.getClass().getMethod("getNome").invoke(prodotto);
	                        double prezzo = (double) prodotto.getClass().getMethod("getPrezzo").invoke(prodotto);
	                        String pathImmagine = (String) prodotto.getClass().getMethod("getPathImmagine").invoke(prodotto);
	                        int id = (int) prodotto.getClass().getMethod("getIdProdotto").invoke(prodotto);
	                        int attivo = (int) prodotto.getClass().getMethod("getAttivo").invoke(prodotto);
	                        if(attivo == 1) {
	            %>
	            <div class="prodotto" id="prod<%= counter %>" data-nome="<%= nome.toLowerCase() %>">
				    <% if (isAdmin) { %>
				    <div class="menu-wrapper">
				        <button class="menu-toggle" onclick="toggleMenu(this)">⋮</button>
				        <div class="menu-dropdown-custom">
				            <ul>
				                <li onclick="modificaProdotto(<%= id %>)">Modifica</li>
				                <li onclick="eliminaProdotto(<%= id %>)">Elimina</li>
				            </ul>
				        </div>
				    </div>
				    <% } %>
				    
				    <!-- Resto del contenuto prodotto -->
				    <img src="<%= request.getContextPath() + "/" + pathImmagine %>" alt="<%= nome %>">

				    <h2>
					  <a href="visualizzaProdotto?id=<%= id %>" class="link-nome-prodotto">
					    <%= nome %>
					  </a>
					</h2>
	
				    <p class="prezzo">€ <%= String.format("%.2f", prezzo) %></p>
				    <form action="aggiungi-al-carrello" method="post" onsubmit="return mostraConferma(this);">

				        <input type="hidden" name="id" value="<%= id %>">
				        <input type="hidden" name="nome" value="<%= nome %>">
				        <input type="hidden" name="prezzo" value="<%= prezzo %>">
				        <button type="submit" class="btn aggiungi-carrello">Aggiungi al carrello</button>
				    </form>
				</div>
	
	
	            <%
	                        }
	                        counter++;
	                    }
	                }
	            %>
	        </div>
	    </div>
	
	    <!-- Popup login obbligatorio -->
	    <div id="popup-container" style="display: none;">
	        <p>Devi effettuare il login per aggiungere prodotti al carrello!</p>
	        <button onclick="nascondiPopup()">Chiudi</button>
	    </div>
	    <div id="overlay" style="display: none;"></div>
	
	    <script>
	        function toggleFiltri() {
	            const menu = document.getElementById('menu-filtri');
	            menu.style.display = (menu.style.display === 'block') ? 'none' : 'block';
	        }
	
	        function cambiaPaginaConFiltro() {
	            const categoria = document.getElementById("filtro-categoria").value;
	            const url = window.location.pathname + "?categoria=" + encodeURIComponent(categoria);
	            window.location.href = url;
	        }
	
	        function mostraPopup() {
	            document.getElementById('popup-container').style.display = 'block';
	            document.getElementById('overlay').style.display = 'block';
	        }
	
	        function nascondiPopup() {
	            document.getElementById('popup-container').style.display = 'none';
	            document.getElementById('overlay').style.display = 'none';
	        }
	        
	        function toggleMenu(button) {
	            // Chiude altri menu aperti
	            document.querySelectorAll(".menu-dropdown-custom").forEach(menu => {
	                if (menu !== button.nextElementSibling) {
	                    menu.style.display = "none";
	                }
	            });
	
	            const menu = button.nextElementSibling;
	            menu.style.display = (menu.style.display === "block") ? "none" : "block";
	        }
	
	        // Chiude menu cliccando fuori
	        document.addEventListener("click", function (e) {
	            if (!e.target.matches(".menu-toggle")) {
	                document.querySelectorAll(".menu-dropdown-custom").forEach(menu => {
	                    menu.style.display = "none";
	                });
	            }
	        });
	
	        // Funzioni di esempio
	        function modificaProdotto(id) {
	            window.location.href = "modInsProdotto.jsp?id=" + id;
	        }
	
	        function eliminaProdotto(id) {
	            if (confirm("Sei sicuro di voler eliminare questo prodotto?")) {
	                window.location.href = "eliminaProdotto?id=" + id;
	            }
	        }
			
	        function mostraConferma(form) {
	            const popup = document.getElementById("popup-carrello");
	            popup.style.display = "block";

	            setTimeout(() => {
	                popup.style.display = "none";
	                form.submit(); // invia il form dopo 1 secondo
	            }, 1000);

	            return false; // blocca il submit immediato
	        }


	
	    </script>
		<%@ include file = "fragments/footer.jspf"%>
	    <!-- JavaScript per i suggerimenti -->
    <script src="${pageContext.request.contextPath}/js/catalogo.js"></script>
    <div class="popup-container" id="popup-carrello" style="display: none;">
	    <div class="popup">
	        🛒 Prodotto aggiunto al carrello!
	    </div>
	</div>
    
    </main>
</body>
</html>