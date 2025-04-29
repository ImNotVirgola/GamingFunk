<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="it.unisa.model.Prodotto" %>
<%@ page import="it.unisa.model.ProdottoDAOImpl" %>
<%
    ProdottoDAOImpl prodottoDAO = new ProdottoDAOImpl();
    List<Prodotto> prodotti = prodottoDAO.getAll();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Gestione Prodotti</title>
    <link rel="stylesheet" href="css/admin.css">
</head>
<body>
<h1>Gestione Prodotti</h1>
<a href="nuovoProdotto.jsp">Aggiungi nuovo prodotto</a>
<table border="1">
    <thead>
    <tr>
        <th>ID</th>
        <th>Nome</th>
        <th>Categoria</th>
        <th>Prezzo</th>
        <th>Quantità</th>
        <th>Azioni</th>
    </tr>
    </thead>
    <tbody>
    <% for (Prodotto p : prodotti) { %>
        <tr>
            <td><%= p.getIdProdotto() %></td>
            <td><%= p.getNome() %></td>
            <td><%= p.getIdCategoria() %></td>
            <td><%= p.getPrezzo() %> €</td>
            <td><%= p.getQuantitaDisponibile() %></td>
            <td>
                <a href="modificaProdotto.jsp?id=<%= p.getIdProdotto() %>">Modifica</a> |
                <a href="eliminaProdotto?id=<%= p.getIdProdotto() %>" onclick="return confirm('Sei sicuro di voler eliminare questo prodotto?');">Elimina</a>
            </td>
        </tr>
    <% } %>
    </tbody>
</table>
</body>
</html>
