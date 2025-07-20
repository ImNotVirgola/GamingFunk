<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, it.unisa.model.Ordine" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <title>I tuoi ordini - GamingFunk</title>
    <link rel="stylesheet" href="css/ordini.css">
</head>
<body>
    <h1>I tuoi ordini</h1>
    <%
        List<Ordine> ordini = (List<Ordine>) request.getAttribute("ordini");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        if (ordini == null || ordini.isEmpty()) {
    %>
        <p>Non hai ancora effettuato ordini.</p>
    <%
        } else {
            for (Ordine o : ordini) {
    %>
        <div class="ordine">
            <p><strong>ID Ordine:</strong> <%= o.getIdOrdine() %></p>
            <p><strong>Totale:</strong> €<%= o.getTotale() %></p>
            <p><strong>Stato:</strong> <%= o.getStato() %></p>
        </div>
        <hr>
    <%
            }
        }
    %>
    <a href="profilo.jsp">Torna al profilo</a>
</body>
</html>
