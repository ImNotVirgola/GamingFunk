<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nuova Community - GamingFunk</title>
    <link href="${pageContext.request.contextPath}/css/community.css" rel="stylesheet" type="text/css">
</head>
<body>
    <%@ include file="fragments/header.jspf" %>
    <div class="container">
        <h1>Nuova Community</h1>
        <form action="CommunityServlet" method="post">
            <input type="hidden" name="action" value="creaCommunity">
            <label for="nome">Nome Community:</label>
            <input type="text" id="nome" name="nome" required>
            <label for="descrizione">Descrizione:</label>
            <textarea id="descrizione" name="descrizione" required></textarea>
            <button type="submit" class="btn-new">Crea Community</button>
        </form>
    </div>
    <%@ include file = "fragments/footer.jspf" %>
</body>
</html>
