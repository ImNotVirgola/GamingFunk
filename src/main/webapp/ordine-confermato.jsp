<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Ordine Confermato</title>
</head>
<body>
<%@ include file="fragments/header.jspf" %>
    <h1>✅ Ordine Confermato!</h1>
    <p>Il tuo ordine è stato registrato con successo. ID ordine: <%= request.getParameter("id") %></p>
    <a href="catalogo.jsp">Torna al catalogo</a>
    <%@ include file = "fragments/footer.jspf" %>
</body>
</html>
