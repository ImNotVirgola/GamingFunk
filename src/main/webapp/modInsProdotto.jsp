<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ page import="it.unisa.model.ProdottoDAOImpl" %> 
<%@ page import="it.unisa.model.Prodotto" %> 
<%@ page import="it.unisa.model.CategoriaDAOImpl" %>
<%@ page import="it.unisa.model.Categoria" %>
<%
	if(session.getAttribute("utente") == null) response.sendRedirect("catalogo.jsp");

    String titoloPagina = "Inserisci Nuovo Prodotto";
    Prodotto prodotto = new Prodotto();
    boolean isModifica = false;

    // Recupera tutte le categorie
    CategoriaDAOImpl categoriaDAO = new CategoriaDAOImpl();
    List<Categoria> categorie = categoriaDAO.getAll();

    String idParam = request.getParameter("id");
    if (idParam != null && !idParam.isEmpty()) {
        try {
            int id = Integer.parseInt(idParam);
            ProdottoDAOImpl dao = new ProdottoDAOImpl();
            prodotto = dao.getById(id);

            if (prodotto != null) {
                isModifica = true;
                titoloPagina = "Modifica Prodotto";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title><%= titoloPagina %> - GamingFunk</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/modInsProdotto.css">
</head>
<body>
<%@ include file="fragments/header.jspf" %>

<div class="container">
    <h1><%= titoloPagina %></h1>
    
    <form action="<%= isModifica ? "modificaProdotto" : "aggiungiProdotto" %>" method="post" enctype="multipart/form-data">
        <% if (isModifica) { %>
            <input type="hidden" name="id" value="<%= prodotto.getIdProdotto() %>">
        <% } %>

        <label for="nome">Nome Prodotto:</label>
        <input type="text" name="nome" id="nome" value="<%= prodotto.getNome() != null ? prodotto.getNome() : "" %>" required>

        <label for="descrizione">Descrizione:</label>
        <textarea name="descrizione" id="descrizione" rows="4" required><%= prodotto.getDescrizione() != null ? prodotto.getDescrizione() : "" %></textarea>

        <label for="prezzo">Prezzo (€):</label>
        <input type="number" step="0.01" name="prezzo" id="prezzo" value="<%= prodotto.getPrezzo() %>" required>

        <label for="quantita">Quantità Disponibile:</label>
        <input type="number" name="quantita" id="quantita" value="<%= prodotto.getQuantitaDisponibile() %>" required>

        <label for="categoria">Categoria:</label>
		<select name="categoria" id="categoria" required>
		    <option value="">-- Seleziona Categoria --</option>
		    <% for (Categoria cat : categorie) { 
		           int catId = cat.getIdCategoria();
		           String catNome = cat.getNomeCategoria();
		           boolean selected = isModifica && catId == prodotto.getIdCategoria();
		    %>
		        <option value="<%= catId %>" <%= selected ? "selected" : "" %>><%= catNome %></option>
		    <% } %>
		</select>

        <label for="immagine">Immagine del Prodotto:</label>
        <% if (isModifica && prodotto.getPathImmagine() != null && !prodotto.getPathImmagine().isEmpty()) { %>
            <p>Immagine attuale: <img src="<%= prodotto.getPathImmagine() %>" alt="Immagine prodotto" style="max-width: 100px;"></p>
        <% } %>
        <input type="file" name="immagine" id="immagine" <%= isModifica ? "" : "required" %>>

        <button type="submit" class="btn-submit"><%= isModifica ? "Salva modifiche" : "Aggiungi Prodotto" %></button>
    </form>
</div>

<%@ include file="fragments/footer.jspf" %>
</body>
</html>
