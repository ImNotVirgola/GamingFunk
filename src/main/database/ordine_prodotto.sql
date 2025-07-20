-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Creato il: Lug 20, 2025 alle 15:05
-- Versione del server: 11.8.2-MariaDB
-- Versione PHP: 8.4.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gamingfunk`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `ordine_prodotto`
--

CREATE TABLE `ordine_prodotto` (
  `id_ordine` int(11) NOT NULL,
  `id_prodotto` int(11) NOT NULL,
  `quantita` int(11) NOT NULL,
  `prezzo_unitario` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dump dei dati per la tabella `ordine_prodotto`
--

INSERT INTO `ordine_prodotto` (`id_ordine`, `id_prodotto`, `quantita`, `prezzo_unitario`) VALUES
(36, 2, 1, 499.99),
(37, 1, 8, 49.99),
(38, 1, 2, 49.99),
(38, 2, 2, 499.99),
(38, 3, 1, 19.99),
(38, 5, 1, 59.99),
(39, 1, 1, 49.99),
(39, 2, 1, 499.99),
(39, 3, 3, 19.99),
(40, 2, 1, 499.99),
(41, 1, 1, 49.99),
(41, 2, 4, 499.99),
(41, 3, 1, 19.99),
(42, 2, 1, 499.99),
(43, 2, 2, 499.99),
(44, 2, 1, 499.99),
(44, 3, 1, 19.99),
(45, 3, 1, 19.99),
(46, 2, 2, 499.99);

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `ordine_prodotto`
--
ALTER TABLE `ordine_prodotto`
  ADD PRIMARY KEY (`id_ordine`,`id_prodotto`),
  ADD KEY `id_prodotto` (`id_prodotto`);

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `ordine_prodotto`
--
ALTER TABLE `ordine_prodotto`
  ADD CONSTRAINT `ordine_prodotto_ibfk_1` FOREIGN KEY (`id_ordine`) REFERENCES `ordine` (`id_ordine`) ON DELETE CASCADE,
  ADD CONSTRAINT `ordine_prodotto_ibfk_2` FOREIGN KEY (`id_prodotto`) REFERENCES `prodotto` (`id_prodotto`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
