<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nuova Discussione - GamingFunk</title>
    <link href="${pageContext.request.contextPath}/css/community.css" rel="stylesheet" type="text/css">
</head>
<body>
    <%@ include file="fragments/header.jspf" %>
    <div class="container">
        <h1>Nuova Discussione</h1>
        <form action="DiscussioneServlet" method="post">
            <input type="hidden" name="action" value="creaDiscussione">
            <input type="hidden" name="forumId" value="${param.forumId}">
            <label for="titolo">Titolo:</label>
            <input type="text" id="titolo" name="titolo" required>
            <label for="contenuto">Contenuto:</label>
            <textarea id="contenuto" name="contenuto" required></textarea>
            <button type="submit" class="btn-new">Crea Discussione</button>
        </form>
    </div>
    <%@ include file = "fragments/footer.jspf" %>
</body>
</html>
