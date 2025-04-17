-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versione server:              11.8.1-MariaDB - mariadb.org binary distribution
-- S.O. server:                  Win64
-- HeidiSQL Versione:            12.10.0.7000
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dump dei dati della tabella gamingfunk.aggiunge_carrello_prodotto: ~0 rows (circa)

-- Dump dei dati della tabella gamingfunk.area_amministrativa: ~1 rows (circa)
INSERT INTO `area_amministrativa` (`id_admin`, `id_utente`) VALUES
	(1, 1);

-- Dump dei dati della tabella gamingfunk.carrello: ~0 rows (circa)

-- Dump dei dati della tabella gamingfunk.categoria: ~5 rows (circa)
INSERT INTO `categoria` (`id_categoria`, `nome_categoria`) VALUES
	(1, 'Eventi'),
	(2, 'Merchandising'),
	(3, 'Console'),
	(4, 'Accessori'),
	(5, 'Giochi');

-- Dump dei dati della tabella gamingfunk.community: ~0 rows (circa)

-- Dump dei dati della tabella gamingfunk.discussione: ~0 rows (circa)

-- Dump dei dati della tabella gamingfunk.evento: ~0 rows (circa)

-- Dump dei dati della tabella gamingfunk.forum: ~0 rows (circa)

-- Dump dei dati della tabella gamingfunk.ordine: ~0 rows (circa)

-- Dump dei dati della tabella gamingfunk.pagamento: ~0 rows (circa)

-- Dump dei dati della tabella gamingfunk.prodotto: ~5 rows (circa)
INSERT INTO `prodotto` (`id_prodotto`, `quantita_disponibile`, `prezzo`, `media_recensioni`, `nome`, `quantita_venduta`, `path_immagine`, `descrizione`, `id_categoria`, `id_admin`) VALUES
	(1, 50, 49.99, 4.50, 'T-Shirt Anime Limited Edition', 120, 'images/products/1.png', 'T-shirt ufficiale ispirata al tuo anime preferito.', 2, 1),
	(2, 10, 499.99, 4.80, 'PlayStation 5', 300, 'images/products/2.png', 'La console di nuova generazione per un esperienza di gioco immersiva.', 3, 1),
	(3, 200, 19.99, 4.20, 'Custodia Protettiva per Smartphone', 500, 'images/products/3.png', 'Proteggi il tuo smartphone con questa custodia resistente.', 4, 1),
	(4, 30, 59.99, 4.60, 'Action Figure Naruto', 80, 'images/products/4.png', 'Action figure dettagliata del personaggio Naruto.', 2, 1),
	(5, 100, 59.99, 4.70, 'The Legend of Zelda - Breath of the Wild', 250, 'images/products/5.png', 'Un gioco avventura open-world con grafica mozzafiato.', 5, 1);

-- Dump dei dati della tabella gamingfunk.utente: ~1 rows (circa)
INSERT INTO `utente` (`id_utente`, `email`, `nome`, `cognome`, `indirizzo`, `citta`, `provincia`, `cap`, `password`, `ruolo`, `num_ordini`, `totale_speso`, `percorsoImmagine`) VALUES
	(1, 'gamingfunk@admin.it', 'admin', 'admin1', 'via dell\'admin', 'adminonia', 'am', '1', 'admin', 'admin', 0, 0.00, 'images/profile/admin1.png');

-- Dump dei dati della tabella gamingfunk.wishlist: ~0 rows (circa)

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
