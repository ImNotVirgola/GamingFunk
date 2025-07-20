<%@ page contentType="text/html;charset=UTF-8" language="java" %> 
<!DOCTYPE html>
<html lang="it">
<head>
  <meta charset="UTF-8" />
  <title>Catalogo GamingFunk</title>
  <link rel="stylesheet" href="/css/catalogo.css" />
  <style>
    body {
      font-family: 'Comic Sans MS', cursive, sans-serif;
      background: linear-gradient(to bottom, #ffefff, #e0f7ff);
      margin: 0;
      padding: 0;
      overflow-x: hidden;
    }

   /* === HEADER / NAVBAR === */
    .navbar {
      display: flex;
      justify-content: space-between;
      align-items: center;
      background-color: #1a1a2e;
      padding: 1rem 2rem;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
    }

    .logo img {
      height: 50px;
      width: auto;
    }

    .nav-buttons {
      display: flex;
      gap: 1rem;
    }

    .nav-buttons a {
      color: #ffffff;
      text-decoration: none;
      font-weight: bold;
      font-size: 1rem;
      background: linear-gradient(to right, #a833ff, #00aeef);
      padding: 0.6rem 1rem;
      border-radius: 10px;
      box-shadow: 0 0 8px #a833ff;
      display: flex;
      align-items: center;
      gap: 0.5rem;
      transition: all 0.2s ease;
    }

    .nav-buttons a:hover {
      background: linear-gradient(to right, #ff007f, #e6e300);
      box-shadow: 0 0 12px #ff007f, 0 0 10px #e6e300;
      transform: scale(1.05);
    }

    .nav-buttons i {
      font-size: 1.1rem;
    }


    .catalog-container {
      padding: 3rem 2rem;
      text-align: center;
    }

    h1 {
      color: #a833ff;
      font-size: 3.2rem;
      text-shadow: 0 0 10px #ffb6ff, 0 0 20px #a833ff;
      margin-bottom: 1.5rem;
      animation: glowPulse 3s infinite alternate;
    }

    @keyframes glowPulse {
      from {
        text-shadow: 0 0 10px #ffb6ff, 0 0 20px #a833ff;
      }
      to {
        text-shadow: 0 0 20px #ff66b2, 0 0 30px #ff007f;
      }
    }

    .search-bar {
      margin: 2rem auto 3rem auto;
      max-width: 600px;
    }

    #searchInput {
      padding: 1rem 1.5rem;
      width: 100%;
      border: 3px solid #ff007f;
      border-radius: 15px;
      font-size: 1.3rem;
      box-shadow: 0 0 15px #ffc0cb;
      transition: box-shadow 0.3s ease;
    }

    #searchInput:focus {
      outline: none;
      box-shadow: 0 0 25px #ff007f, 0 0 40px #ff66b2;
    }

    .product-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
      gap: 2rem;
      margin-top: 1rem;
      padding-bottom: 4rem;
    }

    .product-card {
      background: #fff;
      border-radius: 20px;
      padding: 1.2rem 1.5rem;
      box-shadow:
        0 8px 20px rgba(255, 0, 127, 0.3),
        0 0 15px rgba(168, 51, 255, 0.4);
      transition: transform 0.3s ease, box-shadow 0.3s ease;
      position: relative;
      cursor: default;
    }

    .product-card:hover {
      transform: scale(1.07);
      box-shadow:
        0 12px 25px rgba(255, 0, 127, 0.5),
        0 0 25px rgba(168, 51, 255, 0.6),
        0 0 40px rgba(255, 0, 127, 0.6);
    }

    .product-card img {
      width: 100%;
      max-height: 180px;
      object-fit: contain;
      margin-bottom: 0.7rem;
      border-radius: 15px;
      transition: transform 0.4s ease, filter 0.4s ease;
    }

    .product-card img:hover {
      transform: scale(1.12);
      filter: drop-shadow(0 0 15px #ff007f);
    }

    .product-name {
      color: #008fcc;
      font-weight: 700;
      font-size: 1.3rem;
      margin-bottom: 0.4rem;
    }

    .product-price {
      color: #e6006e;
      font-size: 1.15rem;
      margin: 0.4rem 0 0.8rem 0;
      font-weight: bold;
    }

    .product-desc {
      font-size: 1rem;
      color: #444;
      min-height: 50px;
      margin-bottom: 1rem;
    }

    .add-cart-btn {
      background-color: #a833ff;
      color: white;
      padding: 0.8rem 1.5rem;
      border: none;
      border-radius: 12px;
      cursor: pointer;
      font-weight: 700;
      font-size: 1.1rem;
      transition: background 0.4s, box-shadow 0.4s;
      user-select: none;
    }

    .add-cart-btn:hover {
      background-color: #ff007f;
      box-shadow: 0 0 12px #ff66b2, 0 0 20px #ff007f;
    }

    .product-card.clicked {
      animation: flash 0.3s ease-in-out;
    }

    @keyframes flash {
      0%, 100% {
        box-shadow: 
          0 8px 15px rgba(255,0,127,0.3),
          0 0 15px rgba(0,174,239,0.6) inset,
          0 0 20px rgba(168,51,255,0.6);
        transform: scale(1);
      }
      50% {
        box-shadow: 
          0 8px 25px rgba(255,0,127,0.6),
          0 0 25px rgba(0,174,239,0.8) inset,
          0 0 30px rgba(168,51,255,0.8);
        transform: scale(1.05);
      }
    }
  </style>
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
</head>
<body>

  <!-- NAVBAR -->
  <nav class="navbar">
    <div class="logo">
      <a href="home.jsp"><img src="/images/logo.png" alt="GamingFunk" /></a>
    </div>
    <div class="nav-buttons">
      <a href="catalogo.jsp"><i class="fas fa-store"></i> Catalogo</a>
      <a href="blog.jsp"><i class="fas fa-blog"></i> Blog</a>
      <a href="community.jsp"><i class="fas fa-comments"></i> Community</a>
      <a href="carrello.jsp"><i class="fas fa-shopping-cart"></i> Carrello</a>
      <a href="login.jsp"><i class="fas fa-sign-in-alt"></i> Login</a>
      <a href="profilo.jsp"><i class="fas fa-user-circle"></i> Profilo</a>
    </div>
  </nav>
</head>
<body>


  <!-- CATALOGO -->
  <div class="catalog-container">
    <h1>🕹️ Catalogo GamingFunk 🃏</h1>

    <div class="search-bar">
      <input type="text" id="searchInput" placeholder="🔍 Cerca nel catalogo..." />
    </div>

    <div class="product-grid" id="productGrid">
      <!-- Prodotti generati dinamicamente -->
    </div>

    <audio id="blingSound" src="https://freesound.org/data/previews/486/486637_10255106-lq.mp3"></audio>
  </div>

  <script>
    const prodotti = [
      {
        nome: 'T-Shirt Anime Limited Edition',
        prezzo: 49.99,
        descrizione: 'T-shirt ufficiale ispirata al tuo anime preferito.',
        img: 'images/products/1.png'
      },
      {
        nome: 'PlayStation 5',
        prezzo: 499.99,
        descrizione: 'Console di nuova generazione per un\'esperienza di gioco immersiva.',
        img: 'images/products/2.png'
      },
      {
        nome: 'Custodia Protettiva per Smartphone',
        prezzo: 19.99,
        descrizione: 'Proteggi il tuo smartphone con questa custodia resistente.',
        img: 'images/products/3.png'
      },
      {
        nome: 'Action Figure Naruto',
        prezzo: 59.99,
        descrizione: 'Action figure dettagliata del personaggio Naruto.',
        img: 'images/products/4.png'
      },
      {
        nome: 'The Legend of Zelda - Breath of the Wild',
        prezzo: 59.99,
        descrizione: 'Gioco avventura open-world con grafica mozzafiato.',
        img: 'images/products/5.png'
      }
    ];

    function renderProducts(filter) {
      const grid = document.getElementById("productGrid");
      grid.innerHTML = "";

      prodotti.forEach(function(prodotto) {
        if (!filter || prodotto.nome.toLowerCase().includes(filter.toLowerCase())) {
          const div = document.createElement("div");
          div.className = "product-card";
          div.innerHTML =
            '<img src="' + prodotto.img + '" alt="' + prodotto.nome + '">' +
            '<div class="product-name">' + prodotto.nome + '</div>' +
            '<div class="product-price">€' + prodotto.prezzo.toFixed(2) + '</div>' +
            '<div class="product-desc">' + prodotto.descrizione + '</div>' +
            '<button class="add-cart-btn">🛒 Aggiungi</button>';

          div.querySelector(".add-cart-btn").addEventListener("click", function() {
            const bling = document.getElementById("blingSound");
            if (bling) {
              bling.currentTime = 0;
              bling.play();
            }
            div.classList.add("clicked");
            setTimeout(function() {
              div.classList.remove("clicked");
            }, 300);
          });

          grid.appendChild(div);
        }
      });
    }

    document.getElementById("searchInput").addEventListener("input", function(e) {
      renderProducts(e.target.value);
    });

    renderProducts();
  </script>
</body>
</html>