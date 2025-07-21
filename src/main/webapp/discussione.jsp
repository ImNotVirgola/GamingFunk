<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Discussione - GamingFunk</title>
    <link href="${pageContext.request.contextPath}/css/community.css" rel="stylesheet" type="text/css">
</head>
<body>
    <%@ include file="fragments/header.jspf" %>
    <div class="container">
        <h1>Discussione</h1>
        <div class="discussion-detail">
            <%-- Qui verrà inserito il dettaglio della discussione tramite backend --%>
            <div id="discussione-servlet"></div>
        </div>
        <a href="DiscussioneServlet?action=nuovoPost&discussioneId=${param.discussioneId}" class="btn-new">Rispondi</a>
    </div>
    <script>
	    fetch('/DiscussioneServlet')
	        .then(response => response.text())
	        .then(data => {
	            document.getElementById('dynamic-content').innerHTML = data;
	        })
	        .catch(error => console.error('Errore durante il caricamento del contenuto:', error));
	</script>
	<%@ include file = "fragments/footer.jspf" %>
</body>
</html>
