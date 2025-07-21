<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Carrello - GamingFunk</title>
    <link href="css/carrello.css" rel="stylesheet" type="text/css">
</head>

<body>

<%@ include file="fragments/header.jspf" %>

<main>
	<div class="container">
	    <h1>🛒 Il tuo carrello</h1>
	
	    <%
	        String errorMsg = (String) request.getAttribute("errorMessage");
	        List<String> dettagliErrori = (List<String>) request.getAttribute("dettagliErrori");
	    %>
	
	    <% if (errorMsg != null && dettagliErrori != null && !dettagliErrori.isEmpty()) { %>
	        <div class="errore-carrello">
	            <h3><%= errorMsg %></h3>
	            <ul>
	                <% for (String dettaglio : dettagliErrori) { %>
	                    <li><%= dettaglio %></li>
	                <% } %>
	            </ul>
	        </div>
	    <% } %>
	
	    <div class="carrello">
	        <ul id="lista-carrello">
	            <%
	                @SuppressWarnings("unchecked")
	                java.util.List<Map<String, Object>> carrello = (java.util.List<Map<String, Object>>) session.getAttribute("carrello");
	
	                double totalePrezzo = 0;
	
	                if (carrello == null || carrello.isEmpty()) {
	            %>
	                <li>Il tuo carrello è vuoto.</li>
	            <%
	                } else {
	                    for (int i = 0; i < carrello.size(); i++) {
	                        Map<String, Object> item = carrello.get(i);
	                        String nome = (String) item.get("nome");
	                        double prezzo = Double.parseDouble(item.get("prezzo").toString());
	
	                        Object quantitaObj = item.get("quantità");
	                        int quantita = 1;
	
	                        if (quantitaObj instanceof Integer) {
	                            quantita = (Integer) quantitaObj;
	                        } else if (quantitaObj != null) {
	                            try {
	                                quantita = Integer.parseInt(quantitaObj.toString());
	                            } catch (NumberFormatException e) {
	                                quantita = 1;
	                            }
	                        }
	
	                        double subtotale = prezzo * quantita;
	                        totalePrezzo += subtotale;
	            %>
	                <li>
	                    <strong><%= nome %></strong> – €<%= String.format("%.2f", prezzo) %> x <%= quantita %> = 
	                    €<%= String.format("%.2f", subtotale) %>
	
	                    <!-- Aumenta quantità -->
	                    <form action="modifica-quantita-carrello" method="post" style="display: inline;">
	                        <input type="hidden" name="indice" value="<%= i %>">
	                        <input type="hidden" name="azione" value="aumenta">
	                        <button type="submit">+</button>
	                    </form>
	
	                    <!-- Diminuisci quantità -->
	                    <form action="modifica-quantita-carrello" method="post" style="display: inline;">
	                        <input type="hidden" name="indice" value="<%= i %>">
	                        <input type="hidden" name="azione" value="diminuisci">
	                        <button type="submit">−</button>
	                    </form>
	
	                    <!-- Rimuovi -->
	                    <form action="rimuovi-dal-carrello" method="post" style="display: inline;">
	                        <input type="hidden" name="indice" value="<%= i %>">
	                        <button type="submit" class="btn">Rimuovi</button>
	                    </form>
	                </li>
	            <%
	                    }
	                }
	            %>
	        </ul>
	
	        <% if (carrello != null && !carrello.isEmpty()) { %>
	            <p><strong>Totale: €<%= String.format("%.2f", totalePrezzo) %></strong></p>
	
	            <form action="svuota-carrello" method="post" style="display: inline;">
	                <button type="submit" class="btn-svuota-carrello">Svuota Carrello</button>
	            </form>
	
	            <% if (session.getAttribute("utente") != null) { %>
	                <form action="acquista" method="post" style="display: inline;">
	                    <button type="submit" class="btn-acquista">Acquista Ora</button>
	                </form>
	            <% } %>
	        <% } %>
	    </div>
	</div>


<script>
    // Nasconde automaticamente il messaggio di errore dopo 5 secondi
    setTimeout(() => {
        const alertBox = document.querySelector(".errore-carrello");
        if (alertBox) {
            alertBox.style.transition = "opacity 1s ease-out";
            alertBox.style.opacity = "0";
            setTimeout(() => alertBox.remove(), 1000); // Rimuove del tutto dopo dissolvenza
        }
    }, 5000);
</script>
</main>
<%@ include file = "fragments/footer.jspf" %>
</body>
</html>
