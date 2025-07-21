<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forum - GamingFunk</title>
    <link href="${pageContext.request.contextPath}/css/community.css" rel="stylesheet" type="text/css">
</head>
<body>
    <%@ include file="fragments/header.jspf" %>
    <div class="container">
        <h1>Forum</h1>
        <a href="DiscussioneServlet?action=nuova&forumId=${param.forumId}" class="btn-new">Nuova Discussione</a>
        <div class="discussion-list">
            <%-- Qui verrà inserita la lista delle discussioni tramite backend --%>
            <div id="forum-servlet"></div>
        </div>
    </div>
    <script>
	    fetch('/ForumServlet')
	        .then(response => response.text())
	        .then(data => {
	            document.getElementById('dynamic-content').innerHTML = data;
	        })
	        .catch(error => console.error('Errore durante il caricamento del contenuto:', error));
	</script>
	<%@ include file = "fragments/footer.jspf" %>
</body>
</html>
