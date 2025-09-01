SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

-- SQL script to initialize inventory database and provide a sample entry

-- Table structure for table `inventory`
DROP TABLE IF EXISTS `inventory`;
CREATE TABLE `inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hostname` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `uuid` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ip` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `os` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `uptime` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `cpuname` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `cpuload` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ram` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `freemem` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `logonserver` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `loginuser` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `vendor` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `hardwarename` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `biosfirmwaretype` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `hdd` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `hddsize` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `hddfree` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `externalip` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `gateway` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `dnsserver` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hostname` (`hostname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Sample data for `inventory`
INSERT INTO `inventory` (`id`, `hostname`, `uuid`, `ip`, `os`, `version`, `uptime`, `cpuname`, `cpuload`, `ram`, `freemem`, `logonserver`, `loginuser`, `vendor`, `hardwarename`, `biosfirmwaretype`, `hdd`, `hddsize`, `hddfree`, `externalip`, `gateway`, `dnsserver`, `updated_at`) VALUES
(1, 'L11TEST-000001', 'deff0438-0776-4e75-b36d-da6eb2c0946e', '10.14.210.143', 'Windows 11', '10.2000', '120', 'Intel(R) CPU', '5', '16GB', '8GB', 'LOGSERVER', 'user', 'Dell', 'OptiPlex', 'UEFI', 'SSD', '512GB', '256GB', '203.0.113.1', '10.14.210.1', '8.8.8.8', '2021-12-31 23:00:03');

COMMIT;
