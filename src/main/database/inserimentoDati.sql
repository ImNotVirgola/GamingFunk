-- Inserimento delle categorie
INSERT INTO categoria (nome_categoria) VALUES ('Eventi');
INSERT INTO categoria (nome_categoria) VALUES ('Merchandising');
INSERT INTO categoria (nome_categoria) VALUES ('Console');
INSERT INTO categoria (nome_categoria) VALUES ('Accessori');
INSERT INTO categoria (nome_categoria) VALUES ('Giochi');

-- Inserimento di un prodotto nella categoria "Merchandising" (ID: 2)
INSERT INTO prodotto (
    quantita_disponibile, 
    prezzo, 
    media_recensioni, 
    nome, 
    quantita_venduta, 
    path_immagine, 
    descrizione, 
    id_categoria, 
    id_admin
) VALUES (
    50, 
    49.99, 
    4.5, 
    'T-Shirt Anime Limited Edition', 
    120, 
    'images/merchandising/tshirt_anime.jpg', 
    'T-shirt ufficiale ispirata al tuo anime preferito.', 
    2, -- ID della categoria "Merchandising"
    1  -- ID dell'amministratore (assumendo che esista un admin con ID = 1)
);

-- Inserimento di un prodotto nella categoria "Console" (ID: 3)
INSERT INTO prodotto (
    quantita_disponibile, 
    prezzo, 
    media_recensioni, 
    nome, 
    quantita_venduta, 
    path_immagine, 
    descrizione, 
    id_categoria, 
    id_admin
) VALUES (
    10, 
    499.99, 
    4.8, 
    'PlayStation 5', 
    300, 
    'images/console/ps5.jpg', 
    'La console di nuova generazione per un esperienza di gioco immersiva.', 
    3, -- ID della categoria "Console"
    1  -- ID dell'amministratore
);

-- Inserimento di un prodotto nella categoria "Accessori" (ID: 4)
INSERT INTO prodotto (
    quantita_disponibile, 
    prezzo, 
    media_recensioni, 
    nome, 
    quantita_venduta, 
    path_immagine, 
    descrizione, 
    id_categoria, 
    id_admin
) VALUES (
    200, 
    19.99, 
    4.2, 
    'Custodia Protettiva per Smartphone', 
    500, 
    'images/accessori/custodia_smartphone.jpg', 
    'Proteggi il tuo smartphone con questa custodia resistente.', 
    4, -- ID della categoria "Accessori"
    1  -- ID dell'amministratore
);

-- Inserimento di un prodotto nella categoria "Merchandising" (ID: 2)
INSERT INTO prodotto (
    quantita_disponibile, 
    prezzo, 
    media_recensioni, 
    nome, 
    quantita_venduta, 
    path_immagine, 
    descrizione, 
    id_categoria, 
    id_admin
) VALUES (
    30, 
    59.99, 
    4.6, 
    'Action Figure Naruto', 
    80, 
    'images/merchandising/naruto_figure.jpg', 
    'Action figure dettagliata del personaggio Naruto.', 
    2, -- ID della categoria "Merchandising"
    1  -- ID dell'amministratore
);

-- Inserimento di un prodotto nella categoria "Giochi" (ID: 5)
INSERT INTO prodotto (
    quantita_disponibile, 
    prezzo, 
    media_recensioni, 
    nome, 
    quantita_venduta, 
    path_immagine, 
    descrizione, 
    id_categoria, 
    id_admin
) VALUES (
    100, 
    59.99, 
    4.7, 
    'The Legend of Zelda - Breath of the Wild', 
    250, 
    'images/giochi/zelda_breath_of_the_wild.jpg', 
    'Un gioco avventura open-world con grafica mozzafiato.', 
    5, -- ID della categoria "Giochi"
    1  -- ID dell'amministratore
);