<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="it.unisa.model.*" %>
<%@ page import="javax.servlet.http.*, java.util.*, java.text.DecimalFormat" %>
<%
    Utente utente1 = (Utente) session.getAttribute("utente");
    if (utente1 == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    OrdineDAOImpl ordineDAO = new OrdineDAOImpl();
    OrdineProdottoDAOImpl ordineProdottoDAO = new OrdineProdottoDAOImpl();
    List<Ordine> ordini = ordineDAO.getOrdiniByUtenteId(utente1.getIdUtente());
    DecimalFormat df = new DecimalFormat("#.00");
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Storico Ordini</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/catalogo.css">
</head>
<body>
<%@ include file="fragments/header.jspf" %>
<div class="container">
    <h1>📦 I miei ordini</h1>

    <%
        if (ordini == null || ordini.isEmpty()) {
    %>
        <p>Non hai ancora effettuato ordini.</p>
    <%
        } else {
    %>
    <div class="catalogo">
        <%
            for (Ordine ordine : ordini) {
                List<Map<String, Object>> prodotti = ordineProdottoDAO.getProdottiDettagliatiByOrdineId(ordine.getIdOrdine());
        %>
            <div class="prodotto" style="width: 300px;">
                <h2>Ordine #<%= ordine.getIdOrdine() %></h2>
                <p><strong>Totale:</strong> € <%= df.format(ordine.getTotale()) %></p>
                <ul style="text-align: left;">
                    <% for (Map<String, Object> prodotto : prodotti) { %>
                        <li>
                            <strong>Prodotto:</strong> <%= prodotto.get("nome") %><br>
                            <strong>Quantità:</strong> <%= prodotto.get("quantita") %><br>
                            <strong>Prezzo unitario:</strong> € <%= df.format(prodotto.get("prezzo_unitario")) %>
                        </li>
                    <% } %>
                </ul>

                <!-- Pulsante per la stampa della fattura -->
                <form method="get" action="fattura.jsp" target="_blank" style="margin-top: 10px;">
                    <input type="hidden" name="idOrdine" value="<%= ordine.getIdOrdine() %>">
                    <button type="submit" class="btn">🧾 Stampa Fattura</button>
                </form>
            </div>
        <%
            }
        %>
    </div>
    <%
        }
    %>
</div>
</body>
</html>
