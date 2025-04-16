<%@ page import="javax.servlet.http.*" %> 
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it">
<head>
	<%
	    if (request.getAttribute("fromServlet") == null) {
	        // Logica da eseguire solo se la pagina è stata richiamata direttamente
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
            <img src="path/to/logo.png" alt="Logo" class="logo">
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
    <div class="container">
        <h1>🎭 Catalogo GamingFunk 🎨</h1>
        <div class="search-bar">
		    <input type="text" placeholder="Cerca nel catalogo...">
		    <button class="btn-search">Cerca</button>
		    <%
		        // Verifica se l'utente è loggato e ha il ruolo admin
		        HttpSession sessione = request.getSession(false);
		        if (sessione != null && sessione.getAttribute("utente") != null && "admin".equals(sessione.getAttribute("ruolo"))) {
		    %>
		    <button class="btn-add-product-circle" onclick="window.location.href='aggiungi-prodotto.jsp'">
		        +
		    </button>
		    <%
		        }
		    %>
		</div>
       <div class="catalogo">
		    <%
		        // Recupera la lista di prodotti dalla request
		        java.util.List<?> prodotti = (java.util.List<?>) request.getAttribute("prodotti");
		        if (prodotti != null) {
		            int counter = 1; // Contatore per generare ID univoci
		            for (Object prodottoObj : prodotti) {
		                // Assumi che ogni prodotto sia un oggetto con getter per nome, prezzo e pathImmagine
		                Object prodotto = prodottoObj;
		                String nome = (String) prodotto.getClass().getMethod("getNome").invoke(prodotto);
		                double prezzo = (double) prodotto.getClass().getMethod("getPrezzo").invoke(prodotto);
		                String pathImmagine = (String) prodotto.getClass().getMethod("getPathImmagine").invoke(prodotto);
		    %>
		                <div class="prodotto" id="prod<%= counter %>">
		                    <img src="<%= pathImmagine %>" alt="<%= nome %>">
		                    <h2><%= nome %></h2>
		                    <p>Descrizione del prodotto...</p>
		                    <p class="prezzo">€ <%= prezzo %></p>
		                    <button 
		                        class="btn aggiungi-carrello" 
		                        data-nome="<%= nome %>" 
		                        data-prezzo="<%= prezzo %>"
		                    >
		                        Aggiungi al carrello
		                    </button>
		                </div>
		    <%
		                counter++;
		            }
		        }
		    %>
		</div>
    </div>
    <script type="text/javascript">
    document.addEventListener("DOMContentLoaded", function () {
        // Funzione per recuperare il carrello dalla sessione tramite AJAX
        async function getCarrello() {
            try {
                const response = await fetch('carrello-servlet?action=get', {
                    method: 'GET',
                    headers: {
                        'Content-Type': 'application/json'
                    }
                });
                const data = await response.json();
                return data.carrello || [];
            } catch (error) {
                console.error("Errore durante il recupero del carrello:", error);
                return [];
            }
        }

        // Funzione per aggiornare il carrello nella sessione tramite AJAX
        async function updateCarrello(carrello) {
            try {
                await fetch('carrello-servlet?action=update', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ carrello })
                });
            } catch (error) {
                console.error("Errore durante l'aggiornamento del carrello:", error);
            }
        }

        // Recupera il carrello dalla sessione
        let carrello = [];

        async function initCarrello() {
            carrello = await getCarrello();
            aggiornaCarrello();
        }

        // Funzione per aggiornare il carrello
        function aggiornaCarrello() {
            const listaCarrello = document.getElementById("lista-carrello");
            const totale = document.getElementById("totale");

            // Pulisce la lista corrente
            if (listaCarrello) {
                listaCarrello.innerHTML = "";
            }

            // Calcola il totale e genera gli elementi della lista
            let totalePrezzo = 0;
            carrello.forEach((item, index) => {
                if (listaCarrello) {
                    let li = document.createElement("li");
                    li.innerHTML = `
                        ${item.nome} - €${item.prezzo.toFixed(2)} x ${item.quantità}
                        <button onclick="rimuoviDalCarrello(${index})">Rimuovi</button>
                    `;
                    listaCarrello.appendChild(li);
                }

                totalePrezzo += item.prezzo * item.quantità;
            });

            if (totale) {
                totale.textContent = `Totale: €${totalePrezzo.toFixed(2)}`;
            }

            // Salva il carrello aggiornato nella sessione
            updateCarrello(carrello);
        }

        // Funzione per rimuovere un articolo dal carrello
        window.rimuoviDalCarrello = function (index) {
            carrello.splice(index, 1);
            aggiornaCarrello();
        };

        // Evento per svuotare il carrello
        const svuotaCarrelloButton = document.getElementById("svuota-carrello");
        if (svuotaCarrelloButton) {
            svuotaCarrelloButton.addEventListener("click", function () {
                carrello = [];
                aggiornaCarrello();
            });
        }

        // Aggiungi evento click ai pulsanti "Aggiungi al carrello"
        document.querySelectorAll('.aggiungi-carrello').forEach(function (btn) {
            btn.addEventListener('click', function () {
                // Trova il contenitore del prodotto (elemento padre)
                const prodottoElement = this.closest('.prodotto');

                // Recupera il nome del prodotto dall'elemento <h2>
                const nomeElement = prodottoElement.querySelector('h2');
                const nome = nomeElement ? nomeElement.textContent.trim() : 'Prodotto Sconosciuto';

                // Recupera il prezzo del prodotto dall'elemento .prezzo
                const prezzoElement = prodottoElement.querySelector('.prezzo');
                const prezzoText = prezzoElement ? prezzoElement.textContent.trim() : '€ 0';
                const prezzo = parseFloat(prezzoText.replace(/[^0-9.-]/g, ''));

                // Debugging: verifica i dati estratti
                console.log("Prodotto selezionato: Nome=" + nome + ", Prezzo= " + prezzo);

                if (!nome || isNaN(prezzo)) {
                    console.error("Errore: Dati del prodotto non validi.");
                    return;
                }

                // Aggiungi l'articolo al carrello
                const prodottoEsistente = carrello.find(item => item.nome === nome);
                if (prodottoEsistente) {
                    prodottoEsistente.quantità += 1;
                } else {
                    carrello.push({ "nome": nome, "prezzo": prezzo, "quantità": 1 });
                }

                // Aggiorna il carrello
                aggiornaCarrello();

                // Crea un popup di conferma
                creaPopup(nome + ' aggiunto al carrello');
            });
        });

        // Inizializza il carrello all'avvio
        initCarrello();
    });

    // Funzione per creare un popup
    function creaPopup(messaggio) {
        const container = document.querySelector('.popup-container') || creaPopupContainer();

        const popup = document.createElement('div');
        popup.className = 'popup';
        popup.textContent = messaggio;

        container.appendChild(popup);

        setTimeout(() => {
            popup.remove();
        }, 3000);

        if (container.children.length > 3) {
            setTimeout(() => {
                container.removeChild(container.firstChild);
            }, 500);
        }
    }

    // Funzione per creare il contenitore dei popup se non esiste
    function creaPopupContainer() {
        const container = document.createElement('div');
        container.className = 'popup-container';
        document.body.appendChild(container);
        return container;
    }
    </script>
</body>
</html>