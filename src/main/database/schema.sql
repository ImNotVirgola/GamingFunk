-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versione server:              11.7.2-MariaDB - mariadb.org binary distribution
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


-- Dump della struttura del database gamingfunk
CREATE DATABASE IF NOT EXISTS `gamingfunk` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
USE `gamingfunk`;

-- Dump della struttura di tabella gamingfunk.aggiunge_carrello_prodotto
CREATE TABLE IF NOT EXISTS `aggiunge_carrello_prodotto` (
  `id_carrello` int(11) NOT NULL,
  `id_prodotto` int(11) NOT NULL,
  KEY `rela_aggiunge_carrello` (`id_carrello`),
  KEY `rela_aggiunge_prodotto` (`id_prodotto`),
  CONSTRAINT `rela_aggiunge_carrello` FOREIGN KEY (`id_carrello`) REFERENCES `carrello` (`id_carrello`),
  CONSTRAINT `rela_aggiunge_prodotto` FOREIGN KEY (`id_prodotto`) REFERENCES `prodotto` (`id_prodotto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- L’esportazione dei dati non era selezionata.

-- Dump della struttura di tabella gamingfunk.area_amministrativa
CREATE TABLE IF NOT EXISTS `area_amministrativa` (
  `id_admin` int(4) NOT NULL AUTO_INCREMENT,
  `id_utente` int(4) NOT NULL,
  PRIMARY KEY (`id_admin`),
  UNIQUE KEY `id_utente` (`id_utente`),
  CONSTRAINT `area_amministrativa_ibfk_1` FOREIGN KEY (`id_utente`) REFERENCES `utente` (`id_utente`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- L’esportazione dei dati non era selezionata.

-- Dump della struttura di tabella gamingfunk.carrello
CREATE TABLE IF NOT EXISTS `carrello` (
  `id_carrello` int(11) NOT NULL AUTO_INCREMENT,
  `quantita` int(11) DEFAULT NULL,
  `id_prodotto` int(11) NOT NULL,
  `id_utente` int(11) NOT NULL,
  PRIMARY KEY (`id_carrello`),
  KEY `rela_carrello_Utente` (`id_utente`),
  KEY `rela_carrello_prodotto` (`id_prodotto`),
  CONSTRAINT `rela_carrello_Utente` FOREIGN KEY (`id_utente`) REFERENCES `utente` (`id_utente`),
  CONSTRAINT `rela_carrello_prodotto` FOREIGN KEY (`id_prodotto`) REFERENCES `prodotto` (`id_prodotto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- L’esportazione dei dati non era selezionata.

-- Dump della struttura di tabella gamingfunk.categoria
CREATE TABLE IF NOT EXISTS `categoria` (
  `id_categoria` int(4) NOT NULL AUTO_INCREMENT,
  `nome_categoria` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- L’esportazione dei dati non era selezionata.

-- Dump della struttura di tabella gamingfunk.community
CREATE TABLE IF NOT EXISTS `community` (
  `id_community` int(4) NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `descrizione` text DEFAULT NULL,
  `id_creatore` int(4) NOT NULL,
  PRIMARY KEY (`id_community`),
  UNIQUE KEY `nome` (`nome`),
  KEY `RelazioneUtenteComm` (`id_creatore`),
  CONSTRAINT `RelazioneUtenteComm` FOREIGN KEY (`id_creatore`) REFERENCES `utente` (`id_utente`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- L’esportazione dei dati non era selezionata.

-- Dump della struttura di tabella gamingfunk.discussione
CREATE TABLE IF NOT EXISTS `discussione` (
  `id_discussione` int(11) NOT NULL AUTO_INCREMENT,
  `titolo` varchar(255) NOT NULL,
  `contenuto` text DEFAULT NULL,
  `data_pubblicazione` date NOT NULL,
  `id_autore` int(11) NOT NULL,
  `id_forum` int(11) NOT NULL,
  PRIMARY KEY (`id_discussione`),
  UNIQUE KEY `titolo` (`titolo`),
  KEY `rela_discussione_forum` (`id_forum`),
  KEY `rela_discussione_forum2` (`id_autore`),
  CONSTRAINT `rela_discussione_forum` FOREIGN KEY (`id_forum`) REFERENCES `forum` (`id_forum`),
  CONSTRAINT `rela_discussione_forum2` FOREIGN KEY (`id_autore`) REFERENCES `utente` (`id_utente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- L’esportazione dei dati non era selezionata.

-- Dump della struttura di tabella gamingfunk.evento
CREATE TABLE IF NOT EXISTS `evento` (
  `id_evento` int(11) NOT NULL AUTO_INCREMENT,
  `luogo` text NOT NULL,
  `data` date NOT NULL,
  `descrizione` text DEFAULT NULL,
  `nome` varchar(255) NOT NULL,
  `id_organizzatore` int(11) NOT NULL,
  PRIMARY KEY (`id_evento`),
  KEY `rela_evento_utente` (`id_organizzatore`),
  CONSTRAINT `rela_evento_utente` FOREIGN KEY (`id_organizzatore`) REFERENCES `area_amministrativa` (`id_admin`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- L’esportazione dei dati non era selezionata.

-- Dump della struttura di tabella gamingfunk.forum
CREATE TABLE IF NOT EXISTS `forum` (
  `id_forum` int(4) NOT NULL AUTO_INCREMENT,
  `data_creazione` date NOT NULL,
  `titolo` longtext NOT NULL,
  `descrizione` longtext NOT NULL,
  `id_creatore` int(4) NOT NULL,
  PRIMARY KEY (`id_forum`),
  KEY `rela_forum_Utente` (`id_creatore`),
  CONSTRAINT `rela_forum_Utente` FOREIGN KEY (`id_creatore`) REFERENCES `utente` (`id_utente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- L’esportazione dei dati non era selezionata.

-- Dump della struttura di tabella gamingfunk.ordine
CREATE TABLE IF NOT EXISTS `ordine` (
  `id_ordine` int(11) NOT NULL AUTO_INCREMENT,
  `stato` text NOT NULL,
  `totale` decimal(10,2) NOT NULL,
  `dati_ordine` int(11) NOT NULL,
  `id_utente` int(11) NOT NULL,
  `data_ordine` date DEFAULT NULL,
  PRIMARY KEY (`id_ordine`),
  KEY `rela_ordine_Utente` (`id_utente`),
  CONSTRAINT `rela_ordine_Utente` FOREIGN KEY (`id_utente`) REFERENCES `utente` (`id_utente`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- L’esportazione dei dati non era selezionata.

-- Dump della struttura di tabella gamingfunk.ordine_prodotto
CREATE TABLE IF NOT EXISTS `ordine_prodotto` (
  `id_ordine` int(11) NOT NULL,
  `id_prodotto` int(11) NOT NULL,
  `quantita` int(11) NOT NULL,
  `prezzo_unitario` decimal(10,2) NOT NULL,
  `nome_prodotto` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_ordine`,`id_prodotto`),
  KEY `id_prodotto` (`id_prodotto`),
  CONSTRAINT `FK_ordine_prodotto_ordine` FOREIGN KEY (`id_ordine`) REFERENCES `ordine` (`id_ordine`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_ordine_prodotto_to_prodotto` FOREIGN KEY (`id_prodotto`) REFERENCES `prodotto` (`id_prodotto`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- L’esportazione dei dati non era selezionata.

-- Dump della struttura di tabella gamingfunk.pagamento
CREATE TABLE IF NOT EXISTS `pagamento` (
  `id_pagamento` int(11) NOT NULL AUTO_INCREMENT,
  `metodo_pagamento` text NOT NULL,
  `stato_pagamento` text NOT NULL,
  `id_ordine` int(11) NOT NULL,
  PRIMARY KEY (`id_pagamento`),
  KEY `rela_pagamento_ordine` (`id_ordine`),
  CONSTRAINT `rela_pagamento_ordine` FOREIGN KEY (`id_ordine`) REFERENCES `ordine` (`id_ordine`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- L’esportazione dei dati non era selezionata.

-- Dump della struttura di tabella gamingfunk.prodotto
CREATE TABLE IF NOT EXISTS `prodotto` (
  `id_prodotto` int(4) NOT NULL AUTO_INCREMENT,
  `quantita_disponibile` int(4) NOT NULL DEFAULT 0,
  `prezzo` decimal(10,2) NOT NULL DEFAULT 0.00,
  `media_recensioni` decimal(10,2) NOT NULL DEFAULT 0.00,
  `nome` varchar(255) NOT NULL DEFAULT '""',
  `quantita_venduta` int(11) NOT NULL DEFAULT 0,
  `path_immagine` varchar(255) NOT NULL DEFAULT 'images/products/',
  `descrizione` text DEFAULT NULL,
  `id_categoria` int(4) NOT NULL DEFAULT 1,
  `id_admin` int(4) NOT NULL DEFAULT 1,
  `attivo` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id_prodotto`),
  UNIQUE KEY `path_immagine` (`path_immagine`),
  KEY `rela_prodotto_categoria` (`id_categoria`),
  KEY `rela_prodotto_admin` (`id_admin`),
  CONSTRAINT `rela_prodotto_admin` FOREIGN KEY (`id_admin`) REFERENCES `area_amministrativa` (`id_admin`),
  CONSTRAINT `rela_prodotto_categoria` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- L’esportazione dei dati non era selezionata.

-- Dump della struttura di tabella gamingfunk.utente
CREATE TABLE IF NOT EXISTS `utente` (
  `id_utente` int(4) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `cognome` varchar(255) DEFAULT NULL,
  `indirizzo` varchar(255) DEFAULT NULL,
  `citta` varchar(255) DEFAULT NULL,
  `provincia` varchar(255) DEFAULT NULL,
  `cap` varchar(10) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `ruolo` enum('admin','regular') NOT NULL,
  `num_ordini` int(4) DEFAULT NULL,
  `totale_speso` decimal(10,2) DEFAULT NULL,
  `percorsoImmagine` text DEFAULT 'images/default/profile.png',
  PRIMARY KEY (`id_utente`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- L’esportazione dei dati non era selezionata.

-- Dump della struttura di tabella gamingfunk.wishlist
CREATE TABLE IF NOT EXISTS `wishlist` (
  `id_wishlist` int(4) NOT NULL AUTO_INCREMENT,
  `id_utente` int(4) NOT NULL,
  `id_prodotto` int(4) NOT NULL,
  PRIMARY KEY (`id_wishlist`),
  KEY `rela_wishlist_prodotto` (`id_prodotto`),
  KEY `rela_wishlist_Utente` (`id_utente`),
  CONSTRAINT `rela_wishlist_Utente` FOREIGN KEY (`id_utente`) REFERENCES `utente` (`id_utente`),
  CONSTRAINT `rela_wishlist_prodotto` FOREIGN KEY (`id_prodotto`) REFERENCES `prodotto` (`id_prodotto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- L’esportazione dei dati non era selezionata.

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
