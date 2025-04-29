<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="it.unisa.model.ProdottoDAOImpl" %>
<%@ page import="it.unisa.model.CategoriaDAOImpl" %>
<%@ page import="it.unisa.model.Prodotto" %>
<%@ page import="it.unisa.model.Categoria" %>
<%@ page import="java.util.List" %>
<%
    String idStr = request.getParameter("id");
    int id = Integer.parseInt(idStr);
    ProdottoDAOImpl prodottoDAO = new ProdottoDAOImpl();
    Prodotto prodotto = prodottoDAO.getById(id);
    CategoriaDAOImpl categoriaDAO = new CategoriaDAOImpl();
    List<Categoria> categorie = categoriaDAO.getAll();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Modifica Prodotto</title>
    <link rel="stylesheet" href="css/admin.css">
</head>
<body>
<h1>Modifica Prodotto</h1>
<form action="modificaProdotto" method="post">
    <input type="hidden" name="id" value="<%= prodotto.getIdProdotto() %>">
    Nome: <input type="text" name="nome" value="<%= prodotto.getNome() %>" required><br>
    Categoria: <select name="categoria" required>
        <% for (Categoria c : categorie) { %>
            <option value="<%= c.getIdCategoria() %>" <%= c.getIdCategoria() == prodotto.getIdCategoria() ? "selected" : "" %>><%= c.getNomeCategoria() %></option>
        <% } %>
    </select><br>
    Prezzo: <input type="number" name="prezzo" step="0.01" value="<%= prodotto.getPrezzo() %>" required><br>
    Quantità: <input type="number" name="quantita" value="<%= prodotto.getQuantitaDisponibile() %>" required><br>
    <input type="submit" value="Salva Modifiche">
</form>
<a href="gestioneProdotti.jsp">Torna alla gestione prodotti</a>
</body>
</html>
