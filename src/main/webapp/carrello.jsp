<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Carrello - GamingFunk</title>
	<link href="css/catalogo.css" rel="stylesheet" type="text/css">
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
	            // Recupera la sessione corrente
	            if (session != null && session.getAttribute("utente") != null) {
	                String fotoProfilo = (String) session.getAttribute("fotoProfilo");
	        %>
	                <a href="profilo.jsp"><img src="<%= fotoProfilo %>" alt="Foto Profilo" class="profile-pic"></a>
	                <form action="logout" method="post" style="display: inline;">
	                    <button type="submit" class="btn-logout">Logout</button>
	                </form>
	        <%
	            } else {
	                // Utente non connesso: mostra i pulsanti Login e Registrazione
	        %>
	                <button class="btn-login" onclick="window.location.href='login.jsp'">Login</button>
	                <button class="btn-register" onclick="window.location.href='register.jsp'">Registrazione</button>
	        <%
	            }
	        %>
	    </div>
	</nav>

	<div class="container">
		<h1>🛒 Il tuo carrello</h1>
		<div class="carrello">
			<ul id="lista-carrello">
				<!-- Gli articoli verranno aggiunti qui dinamicamente -->
			</ul>
			<p id="totale">Totale: 0.00</p>
			<button id="svuota-carrello" class="btn">Svuota Carrello</button>
		</div>
	</div>

	<script>
		document.addEventListener("DOMContentLoaded", function () {
			// Recupera il carrello dalla sessione
			var carrello = JSON.parse(sessionStorage.getItem("carrello")) || [];

			// Funzione per aggiornare il carrello
			function aggiornaCarrello() {
				const listaCarrello = document.getElementById("lista-carrello");
				const totale = document.getElementById("totale");
				listaCarrello.innerHTML = "";
				let totalePrezzo = 0;
				carrello.forEach((item, index) => {
					let li = document.createElement("li");
					li.innerHTML = `${item.nome} - ${item.prezzo} <button onclick="rimuoviDalCarrello(${index})">â</button>`;
					listaCarrello.appendChild(li);
					totalePrezzo += parseFloat(item.prezzo.replace("â¬", ""));
				});
				totale.textContent = `Totale: ${totalePrezzo.toFixed(2)}`;
				sessionStorage.setItem("carrello", JSON.stringify(carrello));
			}

			// Funzione per rimuovere un articolo dal carrello
			window.rimuoviDalCarrello = function (index) {
				carrello.splice(index, 1);
				aggiornaCarrello();
			};

			// Evento per svuotare il carrello
			document.getElementById("svuota-carrello").addEventListener("click", function () {
				carrello = [];
				aggiornaCarrello();
			});

			// Aggiorna il carrello all'avvio
			aggiornaCarrello();
		});
	</script>

</body>

</html>