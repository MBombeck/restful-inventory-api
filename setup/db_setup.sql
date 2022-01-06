-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Erstellungszeit: 01. Jan 2022 um 00:15
-- Server-Version: 5.5.68-MariaDB
-- PHP-Version: 7.3.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `inventory`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `inventory`
--

CREATE TABLE `inventory` (
  `id` int(11) NOT NULL,
  `hostname` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `uuid` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ip` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `os` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `uptime` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp(6) NULL DEFAULT '0000-00-00 00:00:00.000000'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Daten für Tabelle `inventory`
--

INSERT INTO `inventory` (`id`, `hostname`, `uuid`, `ip`, `os`, `version`, `uptime`, `created_at`, `updated_at`) VALUES
(1, 'L11PAVA-990001', '4323123213', '10.14.210.143', 'Windows 10', '1.000', '23', '2021-12-31 15:04:03', '2021-12-31 15:04:03.000000'),
(2, 'L11PAVA-990002', '2fv23erfsdffsdf', '10.31.221.31', 'Windows 3.11', '1.000', '23', '2021-12-31 15:04:03', '2021-12-31 15:04:03.000000'),
(3, 'L11PAVA-990003', 'dasdsad122123', '10.5.23.243', 'Windows 10', '1.000', '23', '2021-12-31 15:04:03', '2021-12-31 15:04:03.000000'),
(4, 'L11PAVA-990004', 'h5dfsgdfujjj', '10.14.11.2', 'Windows 98SE', '1.000', '23', '2021-12-31 15:04:03', '2021-12-31 15:04:03.000000'),
(5, 'L11PAVA-990005', 'hfghfh454dfgdfg', '10.22.4.23', 'Windows 11', '1.000', '23', '2021-12-31 15:04:03', '2021-12-31 15:04:03.000000'),
(6, 'L11PAVA-990006', 'dfgdfjkkjjiuy575', '10.102.4.32', 'Windows 10', '1.000', '55', '2021-12-31 15:04:03', '2021-12-31 15:04:03.000000'),
(7, 'L11PAVA-990007', 'fdgdfgdfg34567', '10.99.23.42', 'Windows 8', '1.000', '23', '2021-12-31 15:04:03', '2021-12-31 15:04:03.000000');

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `inventory`
--
ALTER TABLE `inventory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
