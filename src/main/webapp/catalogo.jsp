<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Catalogo GamingFunk</title>
    <link href="${pageContext.request.contextPath}/css/catalogo.css" rel="stylesheet" type="text/css">
</head>
<body>
    <nav class="navbar">
        <div class="navbar-left">
            <img src="path/to/logo.png" alt="Logo" class="logo">
        </div>
        <div class="navbar-center">
            <a href="catalogo">Catalogo</a>
            <a href="community.jsp">Community</a>
            <a href="blog.jsp">Blog</a>
            <a href="carrello.jsp">Carrello</a>
        </div>
        <div class="navbar-right">
            <c:choose>
                <c:when test="${not empty sessionScope.utente}">
                    <a href="profilo.jsp"><img src="${sessionScope.fotoProfilo}" alt="Foto Profilo" class="profile-pic"></a>
                    <form action="logout" method="post" style="display: inline;">
                        <button type="submit" class="btn-logout">Logout</button>
                    </form>
                </c:when>
                <c:otherwise>
                    <button class="btn-login" onclick="window.location.href='login.jsp'">Login</button>
                    <button class="btn-register" onclick="window.location.href='register.jsp'">Registrazione</button>
                </c:otherwise>
            </c:choose>
        </div>
    </nav>
    <div class="container">
        <h1>🎭 Catalogo GamingFunk 🎨</h1>
        <div class="search-bar">
            <input type="text" placeholder="Cerca nel catalogo...">
            <button class="btn-search">Cerca</button>
        </div>
        <div class="catalogo">
            <c:forEach var="prodotto" items="${prodotti}" varStatus="loop">
                <div class="prodotto" id="prod${loop.index + 1}">
                    <img src="${prodotto.pathImmagine}" alt="${prodotto.nome}">
                    <h2>${prodotto.nome}</h2>
                    <p>Descrizione del prodotto...</p>
                    <p class="prezzo">€ ${prodotto.prezzo}</p>
                    <button class="btn">Aggiungi al carrello</button>
                </div>
            </c:forEach>
        </div>
    </div>
    <script type="text/javascript">
        // Inizializza il carrello
        var carrello = {
            items: [],
            aggiungiArticolo: function (nome, prezzo) {
                this.items.push({nome: nome, prezzo: prezzo});
                sessionStorage.setItem("carrello", JSON.stringify(this.items));
            },
            visualizzaCarrello: function () {
                console.log("Articoli nel carrello:", this.items);
            }
        };

        // Aggiungi evento click ai pulsanti
        document.querySelectorAll('.btn').forEach(function (btn) {
            btn.addEventListener('click', function () {
                var parentElement = this.parentElement;
                var nome = parentElement.querySelector('h2').textContent;
                var prezzo = parentElement.querySelector('.prezzo').textContent;
                carrello.aggiungiArticolo(nome, prezzo);
                carrello.visualizzaCarrello(); // Opzionale: visualizza il carrello in console
            });
        });
    </script>
</body>
</html>