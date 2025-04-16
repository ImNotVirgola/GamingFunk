-- phpMyAdmin SQL Dump
-- Versione ottimizzata con gestione esclusiva dei prodotti e eventi dall'area amministrativa
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

-- Database: `gamingfunk`
CREATE DATABASE IF NOT EXISTS `gamingfunk` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `gamingfunk`;

-- --------------------------------------------------------
-- Struttura della tabella `aggiunge_carrello_prodotto`
--
CREATE TABLE `aggiunge_carrello_prodotto` (
  `id_carrello` int(11) NOT NULL,
  `id_prodotto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Struttura della tabella `area_amministrativa`
--
CREATE TABLE `area_amministrativa` (
  `id_admin` int(4) NOT NULL AUTO_INCREMENT,
  `id_utente` int(4) NOT NULL,
  PRIMARY KEY (`id_admin`),
  UNIQUE KEY `id_utente` (`id_utente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Struttura della tabella `carrello`
--
CREATE TABLE `carrello` (
  `id_carrello` int(11) NOT NULL AUTO_INCREMENT,
  `quantita` int(11) DEFAULT NULL,
  `id_prodotto` int(11) NOT NULL,
  `id_utente` int(11) NOT NULL,
  PRIMARY KEY (`id_carrello`),
  KEY `rela_carrello_Utente` (`id_utente`),
  KEY `rela_carrello_prodotto` (`id_prodotto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Struttura della tabella `categoria`
--
CREATE TABLE `categoria` (
  `id_categoria` int(4) NOT NULL AUTO_INCREMENT,
  `nome_categoria` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_categoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Struttura della tabella `community`
--
CREATE TABLE `community` (
  `id_community` int(4) NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `descrizione` text DEFAULT NULL,
  `id_creatore` int(4) NOT NULL,
  PRIMARY KEY (`id_community`),
  UNIQUE KEY `nome` (`nome`),
  KEY `RelazioneUtenteComm` (`id_creatore`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Struttura della tabella `discussione`
--
CREATE TABLE `discussione` (
  `id_discussione` int(11) NOT NULL AUTO_INCREMENT,
  `titolo` varchar(255) NOT NULL,
  `contenuto` text DEFAULT NULL,
  `data_pubblicazione` date NOT NULL,
  `id_autore` int(11) NOT NULL,
  `id_forum` int(11) NOT NULL,
  PRIMARY KEY (`id_discussione`),
  UNIQUE KEY `titolo` (`titolo`),
  KEY `rela_discussione_forum` (`id_forum`),
  KEY `rela_discussione_forum2` (`id_autore`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Struttura della tabella `evento`
--
CREATE TABLE `evento` (
  `id_evento` int(11) NOT NULL AUTO_INCREMENT,
  `luogo` text NOT NULL,
  `data` date NOT NULL,
  `descrizione` text DEFAULT NULL,
  `nome` varchar(255) NOT NULL,
  `id_organizzatore` int(11) NOT NULL,
  PRIMARY KEY (`id_evento`),
  KEY `rela_evento_utente` (`id_organizzatore`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Struttura della tabella `forum`
--
CREATE TABLE `forum` (
  `id_forum` int(4) NOT NULL AUTO_INCREMENT,
  `data_creazione` date NOT NULL,
  `titolo` longtext NOT NULL,
  `descrizione` longtext NOT NULL,
  `id_creatore` int(4) NOT NULL,
  PRIMARY KEY (`id_forum`),
  KEY `rela_forum_Utente` (`id_creatore`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Struttura della tabella `ordine`
--
CREATE TABLE `ordine` (
  `id_ordine` int(11) NOT NULL AUTO_INCREMENT,
  `stato` text NOT NULL,
  `totale` decimal(10,2) NOT NULL,
  `dati_ordine` int(11) NOT NULL,
  `id_utente` int(11) NOT NULL,
  PRIMARY KEY (`id_ordine`),
  KEY `rela_ordine_Utente` (`id_utente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Struttura della tabella `pagamento`
--
CREATE TABLE `pagamento` (
  `id_pagamento` int(11) NOT NULL AUTO_INCREMENT,
  `metodo_pagamento` text NOT NULL,
  `stato_pagamento` text NOT NULL,
  `id_ordine` int(11) NOT NULL,
  PRIMARY KEY (`id_pagamento`),
  KEY `rela_pagamento_ordine` (`id_ordine`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Struttura della tabella `prodotto`
--
CREATE TABLE `prodotto` (
  `id_prodotto` int(4) NOT NULL AUTO_INCREMENT,
  `quantita_disponibile` int(4) NOT NULL,
  `prezzo` decimal(10,2) NOT NULL,
  `media_recensioni` decimal(10,2) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `quantita_venduta` int(11) NOT NULL,
  `path_immagine` varchar(255) NOT NULL,
  `descrizione` text DEFAULT NULL,
  `id_categoria` int(4) NOT NULL,
  `id_admin` int(4) NOT NULL,
  PRIMARY KEY (`id_prodotto`),
  UNIQUE KEY `path_immagine` (`path_immagine`),
  KEY `rela_prodotto_categoria` (`id_categoria`),
  KEY `rela_prodotto_admin` (`id_admin`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Struttura della tabella `utente`
--
CREATE TABLE `utente` (
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
  `percorsoImmagine` text DEFAULT NULL,
  PRIMARY KEY (`id_utente`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Struttura della tabella `wishlist`
--
CREATE TABLE `wishlist` (
  `id_wishlist` int(4) NOT NULL AUTO_INCREMENT,
  `id_utente` int(4) NOT NULL,
  `id_prodotto` int(4) NOT NULL,
  PRIMARY KEY (`id_wishlist`),
  KEY `rela_wishlist_prodotto` (`id_prodotto`),
  KEY `rela_wishlist_Utente` (`id_utente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Vincoli per le tabelle
--
ALTER TABLE `aggiunge_carrello_prodotto`
  ADD CONSTRAINT `rela_aggiunge_carrello` FOREIGN KEY (`id_carrello`) REFERENCES `carrello` (`id_carrello`),
  ADD CONSTRAINT `rela_aggiunge_prodotto` FOREIGN KEY (`id_prodotto`) REFERENCES `prodotto` (`id_prodotto`);

ALTER TABLE `area_amministrativa`
  ADD CONSTRAINT `area_amministrativa_ibfk_1` FOREIGN KEY (`id_utente`) REFERENCES `utente` (`id_utente`) ON DELETE CASCADE;

ALTER TABLE `carrello`
  ADD CONSTRAINT `rela_carrello_Utente` FOREIGN KEY (`id_utente`) REFERENCES `utente` (`id_utente`),
  ADD CONSTRAINT `rela_carrello_prodotto` FOREIGN KEY (`id_prodotto`) REFERENCES `prodotto` (`id_prodotto`);

ALTER TABLE `community`
  ADD CONSTRAINT `RelazioneUtenteComm` FOREIGN KEY (`id_creatore`) REFERENCES `utente` (`id_utente`);

ALTER TABLE `discussione`
  ADD CONSTRAINT `rela_discussione_forum` FOREIGN KEY (`id_forum`) REFERENCES `forum` (`id_forum`),
  ADD CONSTRAINT `rela_discussione_forum2` FOREIGN KEY (`id_autore`) REFERENCES `utente` (`id_utente`);

ALTER TABLE `evento`
  ADD CONSTRAINT `rela_evento_utente` FOREIGN KEY (`id_organizzatore`) REFERENCES `area_amministrativa` (`id_admin`);

ALTER TABLE `forum`
  ADD CONSTRAINT `rela_forum_Utente` FOREIGN KEY (`id_creatore`) REFERENCES `utente` (`id_utente`);

ALTER TABLE `ordine`
  ADD CONSTRAINT `rela_ordine_Utente` FOREIGN KEY (`id_utente`) REFERENCES `utente` (`id_utente`);

ALTER TABLE `pagamento`
  ADD CONSTRAINT `rela_pagamento_ordine` FOREIGN KEY (`id_ordine`) REFERENCES `ordine` (`id_ordine`);

ALTER TABLE `prodotto`
  ADD CONSTRAINT `rela_prodotto_categoria` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id_categoria`),
  ADD CONSTRAINT `rela_prodotto_admin` FOREIGN KEY (`id_admin`) REFERENCES `area_amministrativa` (`id_admin`);

ALTER TABLE `wishlist`
  ADD CONSTRAINT `rela_wishlist_Utente` FOREIGN KEY (`id_utente`) REFERENCES `utente` (`id_utente`),
  ADD CONSTRAINT `rela_wishlist_prodotto` FOREIGN KEY (`id_prodotto`) REFERENCES `prodotto` (`id_prodotto`);

COMMIT;