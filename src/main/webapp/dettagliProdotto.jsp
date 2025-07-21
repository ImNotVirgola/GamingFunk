<%@ page import="it.unisa.model.Prodotto" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.*" %>
<%
    Prodotto prodotto = (Prodotto) request.getAttribute("prodotto");
    if (prodotto == null) {
        response.sendRedirect("catalogo.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title><%= prodotto.getNome() %> | GamingFunk</title>
    <link href="css/dettagliProdotto.css" rel="stylesheet" type="text/css">
</head>
<body>
<%@ include file="fragments/header.jspf" %>

<div class="prodotto-container">
    <div class="img-box">
        <img src="<%= prodotto.getPathImmagine() %>" alt="<%= prodotto.getNome() %>">
    </div>

    <div class="info-box">
        <h1><%= prodotto.getNome() %></h1>
        <p class="prezzo">€ <%= String.format("%.2f", prodotto.getPrezzo()) %></p>

        <p class="disponibilita">
            Disponibilità:
            <% if (prodotto.getQuantitaDisponibile() > 0) { %>
                <span class="disponibile">Disponibile</span>
                (<%= prodotto.getQuantitaDisponibile() %> pezzi disponibili)
            <% } else { %>
                <span class="non-disponibile">Non disponibile</span>
            <% } %>
        </p>

        <p class="descrizione"><%= prodotto.getDescrizione() %></p>

        <% if (prodotto.getQuantitaDisponibile() > 0) { %>
        <form action="aggiungi-al-carrello" method="post">
            <input type="hidden" name="id" value="<%= prodotto.getIdProdotto() %>">
            <input type="hidden" name="nome" value="<%= prodotto.getNome() %>">
            <input type="hidden" name="prezzo" value="<%= prodotto.getPrezzo() %>">

            <label for="quantita">Quantità:</label>
            <input type="number" id="quantita" name="quantita" value="1" min="1"
                   max="<%= prodotto.getQuantitaDisponibile() %>" required>

            <button class="btn-acquista" type="submit">🛒 Aggiungi al carrello</button>
        </form>
        <% } %>

        <% 
           if (isAdmin) { %>
            <div class="admin-actions">
                <button onclick="location.href='modInsProdotto.jsp?id=<%= prodotto.getIdProdotto() %>'">Modifica</button>
                <button onclick="if(confirm('Confermi eliminazione?')) location.href='eliminaProdotto?id=<%= prodotto.getIdProdotto() %>'">Elimina</button>
            </div>
        <% } %>
    </div>
</div>

<%@ include file="fragments/footer.jspf" %>
</body>
</html>
