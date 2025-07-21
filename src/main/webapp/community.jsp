<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Community - GamingFunk</title>
    <link href="${pageContext.request.contextPath}/css/community.css" rel="stylesheet" type="text/css">
</head>
<body>
    <%@ include file="fragments/header.jspf" %>
    <div class="container">
        <h1>Community</h1>
        <a href="CommunityServlet?action=nuova" class="btn-new">Crea nuova community</a>
        <div class="community-list">
            <%-- Qui verrà inserita la lista delle community tramite backend --%>
            <div id="community-servlet"></div>
        </div>
    </div>
    <script>
	    fetch('/CommunityServlet')
	        .then(response => response.text())
	        .then(data => {
	            document.getElementById('dynamic-content').innerHTML = data;
	        })
	        .catch(error => console.error('Errore durante il caricamento del contenuto:', error));
	</script>
	<%@ include file = "fragments/footer.jspf" %>
</body>
</html>
