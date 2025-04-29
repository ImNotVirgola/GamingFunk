<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="it.unisa.model.CategoriaDAOImpl" %>
<%@ page import="java.util.List" %>
<%@ page import="it.unisa.model.Categoria" %>
<%
    CategoriaDAOImpl categoriaDAO = new CategoriaDAOImpl();
    List<Categoria> categorie = categoriaDAO.getAll();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Nuovo Prodotto</title>
    <link rel="stylesheet" href="css/admin.css">
</head>
<body>
<h1>Aggiungi Nuovo Prodotto</h1>
<form action="aggiungiProdotto" method="post">
    Nome: <input type="text" name="nome" required><br>
    Categoria: <select name="categoria" required>
        <% for (Categoria c : categorie) { %>
            <option value="<%= c.getIdCategoria() %>"><%= c.getNomeCategoria() %></option>
        <% } %>
    </select><br>
    Prezzo: <input type="number" name="prezzo" step="0.01" required><br>
    Quantità: <input type="number" name="quantita" required><br>
    <input type="submit" value="Aggiungi">
</form>
<a href="gestioneProdotti.jsp">Torna alla gestione prodotti</a>
</body>
</html>
