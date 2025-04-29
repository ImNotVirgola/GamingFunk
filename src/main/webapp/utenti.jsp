<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="it.unisa.model.UtenteDAOImpl" %>
<%@ page import="it.unisa.model.Utente" %>
<%@ page import="java.util.List" %>
<%
    UtenteDAOImpl utenteDAO = new UtenteDAOImpl();
    List<Utente> utenti = utenteDAO.getAll();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Gestione Utenti</title>
    <link rel="stylesheet" href="css/admin.css">
</head>
<body>
<h1>Gestione Utenti</h1>
<table border="1">
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
            <td><!-- Azioni future: modifica/elimina utente --></td>
        </tr>
    <% } %>
    </tbody>
</table>
<a href="catalogo.jsp">Torna al catalogo</a>
</body>
</html>
