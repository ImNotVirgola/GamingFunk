<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home - E-commerce Biglietti Anime &amp; Manga</title>
    <link rel="stylesheet" href="css/index.css">
</head>
<body>
    <header>
        <div class="logo">
            <img src="logo.png" alt="Logo del sito">
        </div>
        <nav>
            <ul>
                <li><a href="index.jsp">Home</a></li>
                <li><a href="catalogo.jsp">Catalogo</a></li>
                <li><a href="community.jsp">Community</a></li>
                <li><a href="blog.jsp">Blog</a></li>
                <li><a href="carrello.jsp">Carrello</a></li>
            </ul>
        </nav>
        <div class="auth-buttons">
            <a href="login.jsp" class="btn">Login</a>
            <a href="registrazione.jsp" class="btn">Registrati</a>
        </div>
    </header>

    <main class="content-container">
        <section class="main-content">
            <h1>Benvenuto nel nostro store!</h1>
            <p>Acquista biglietti per i migliori eventi a tema anime e manga!</p>
            <a href="catalogo.jsp" class="btn">Scopri il Catalogo</a>
        </section>
        
        <aside class="sidebar">
            <div class="content-box">
                <h3>Contenuti Speciali</h3>
                <p>Scopri eventi esclusivi e offerte imperdibili!</p>
            </div>
            <div class="news-box">
                <h3>News</h3>
                <p>Le ultime novità dal mondo anime e manga.</p>
            </div>
        </aside>
    </main>

    <section class="event-carousel">
        <button class="prev">&#10094;</button>
        <div class="carousel">
            <div class="event">
                <img src="evento1.jpg" alt="Evento 1">
                <p>Fiera Anime 2025</p>
            </div>
            <div class="event">
                <img src="evento2.jpg" alt="Evento 2">
                <p>Manga Expo</p>
            </div>
            <div class="event">
                <img src="evento3.jpg" alt="Evento 3">
                <p>Cosplay Convention</p>
            </div>
            <div class="event">
                <img src="evento4.jpg" alt="Evento 4">
                <p>Japan Festival</p>
            </div>
        </div>
        <button class="next">&#10095;</button>
    </section>

    <footer>
        <p>&copy; 2025 E-commerce Biglietti Anime &amp; Manga - Tutti i diritti riservati</p>
    </footer>
</body>
</html>
