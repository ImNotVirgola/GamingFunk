<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="it.unisa.model.UtenteDAOImpl" %>
<%@ page import="it.unisa.model.Utente" %>
<%@ page import="java.util.List" %>
<%
    UtenteDAOImpl utenteDAO = new UtenteDAOImpl();
    List<Utente> utenti = utenteDAO.getAll();
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Gestione Utenti</title>
    <link rel="stylesheet" href="css/utenti.css">
</head>
<body>
<%@ include file="fragments/header.jspf" %>

<main>
    <h1>Gestione Utenti</h1>
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Nome</th>
            <th>Cognome</th>
            <th>Email</th>
            <th>Ruolo</th>
            <th>Azioni</th>
        </tr>
        </thead>
        <tbody>
        <% for (Utente u : utenti) { %>
            <tr>
                <td><%= u.getIdUtente() %></td>
                <td><%= u.getNome() %></td>
                <td><%= u.getCognome() %></td>
                <td><%= u.getEmail() %></td>
                <td><%= u.getRuolo() %></td>
                <td>
                    <a href="modificaUtente.jsp?id=<%= u.getIdUtente() %>" class="btn-azione modifica">Modifica</a>
                    <a href="eliminaUtente?id=<%= u.getIdUtente() %>" class="btn-azione elimina" onclick="return confirm('Sei sicuro di voler eliminare questo utente?');">Elimina</a>
                </td>
            </tr>
        <% } %>
        </tbody>
    </table>

    <a href="catalogo.jsp" class="btn-link">Torna al Catalogo</a>
</main>

<%@ include file="fragments/footer.jspf" %>
</body>
</html>
