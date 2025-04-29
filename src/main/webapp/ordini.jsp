<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="it.unisa.model.OrdineDAOImpl" %>
<%@ page import="it.unisa.model.Ordine" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%
    String filtroCliente = request.getParameter("cliente");
    String dataDa = request.getParameter("dataDa");
    String dataA = request.getParameter("dataA");
    OrdineDAOImpl ordineDAO = new OrdineDAOImpl();
    List<Ordine> ordini;
    if (filtroCliente != null && !filtroCliente.isEmpty()) {
        ordini = ordineDAO.getByCliente(filtroCliente);
    } else if (dataDa != null && dataA != null && !dataDa.isEmpty() && !dataA.isEmpty()) {
        ordini = ordineDAO.getByDataRange(dataDa, dataA);
    } else {
        ordini = ordineDAO.getAll();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Gestione Ordini</title>
    <link rel="stylesheet" href="css/admin.css">
</head>
<body>
<h1>Gestione Ordini</h1>
<form method="get" action="ordini.jsp">
    Filtra per cliente: <input type="text" name="cliente">
    Dal: <input type="date" name="dataDa">
    Al: <input type="date" name="dataA">
    <input type="submit" value="Filtra">
</form>
<table border="1">
    <thead>
    <tr>
        <th>ID</th>
        <th>Cliente</th>
        <th>Data</th>
        <th>Totale</th>
    </tr>
    </thead>
    <tbody>
    <% SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
       for (Ordine o : ordini) { %>
        <tr>
            <td><%= o.getIdOrdine() %></td>
            <td><%= o.getIdUtente() %></td>
            <td><%= sdf.format(o.getDataOrdine()) %></td>
            <td><%= o.getTotale() %> €</td>
        </tr>
    <% } %>
    </tbody>
</table>
<a href="catalogo.jsp">Torna al catalogo</a>
</body>
</html>
