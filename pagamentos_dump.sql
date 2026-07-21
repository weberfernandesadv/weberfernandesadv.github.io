-- ============================================================
-- Dump do banco de dados: Controle de Pagamentos de Clientes
-- Gerado em: 2026-07-10 21:17:14 UTC
-- Servidor: TiDB Serverless (compatível com MySQL 8.0)
-- ============================================================

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;
SET SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO';
SET TIME_ZONE = '+00:00';

-- ------------------------------------------------------------
-- Tabela: `users`
-- ------------------------------------------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `openId` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(320) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `loginMethod` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` enum('user','admin') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `lastSignedIn` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) /*T![clustered_index] CLUSTERED */,
  UNIQUE KEY `users_openId_unique` (`openId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=1620001;

-- Dados de `users` (2 registros)
INSERT INTO `users` (`id`, `openId`, `name`, `email`, `loginMethod`, `role`, `createdAt`, `updatedAt`, `lastSignedIn`) VALUES (1, 'NWT49KcFsxJ5VDqG33YCeP', 'Prof. Weber', 'wolfrickwolf@gmail.com', 'google', 'admin', '2026-06-23 22:14:20', '2026-07-10 21:10:15', '2026-07-10 21:10:15');
INSERT INTO `users` (`id`, `openId`, `name`, `email`, `loginMethod`, `role`, `createdAt`, `updatedAt`, `lastSignedIn`) VALUES (360004, 'PXRJsUiYa7VsRrMuUzZZVL', 'Lucas Spolti', 'lucassspolti@gmail.com', 'google', 'user', '2026-06-25 16:27:53', '2026-06-25 16:28:58', '2026-06-25 16:28:58');

-- ------------------------------------------------------------
-- Tabela: `clients`
-- ------------------------------------------------------------
DROP TABLE IF EXISTS `clients`;
CREATE TABLE `clients` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `totalFees` decimal(10,2) NOT NULL,
  `installmentCount` int NOT NULL,
  `installmentValue` decimal(10,2) NOT NULL,
  `startDate` bigint NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `settledAt` bigint DEFAULT NULL,
  PRIMARY KEY (`id`) /*T![clustered_index] CLUSTERED */
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=210001;

-- Dados de `clients` (12 registros)
INSERT INTO `clients` (`id`, `name`, `totalFees`, `installmentCount`, `installmentValue`, `startDate`, `notes`, `createdAt`, `updatedAt`, `settledAt`) VALUES (1, 'MARLENE GONÇALVES', '15000.00', 30, '500.00', 1766588400000, NULL, '2026-06-23 22:57:37', '2026-06-24 17:20:08', NULL);
INSERT INTO `clients` (`id`, `name`, `totalFees`, `installmentCount`, `installmentValue`, `startDate`, `notes`, `createdAt`, `updatedAt`, `settledAt`) VALUES (30004, 'ELIMARA MARTINS', '6000.00', 15, '300.00', 1754665200000, NULL, '2026-06-24 14:04:08', '2026-06-24 14:04:08', NULL);
INSERT INTO `clients` (`id`, `name`, `totalFees`, `installmentCount`, `installmentValue`, `startDate`, `notes`, `createdAt`, `updatedAt`, `settledAt`) VALUES (30005, 'ANA CLARA BASTIEL', '500.00', 2, '250.00', 1777388400000, NULL, '2026-06-24 16:03:54', '2026-06-24 16:03:54', NULL);
INSERT INTO `clients` (`id`, `name`, `totalFees`, `installmentCount`, `installmentValue`, `startDate`, `notes`, `createdAt`, `updatedAt`, `settledAt`) VALUES (30009, 'KENNYA CINTIA', '18000.00', 20, '900.00', 1766502000000, NULL, '2026-06-24 16:36:33', '2026-06-24 17:21:50', NULL);
INSERT INTO `clients` (`id`, `name`, `totalFees`, `installmentCount`, `installmentValue`, `startDate`, `notes`, `createdAt`, `updatedAt`, `settledAt`) VALUES (30010, 'LEIDIANY', '5000.00', 5, '1000.00', 1764601200000, NULL, '2026-06-24 16:42:55', '2026-06-24 16:42:55', NULL);
INSERT INTO `clients` (`id`, `name`, `totalFees`, `installmentCount`, `installmentValue`, `startDate`, `notes`, `createdAt`, `updatedAt`, `settledAt`) VALUES (30011, 'PRISCILLA', '5000.00', 10, '500.00', 1768834800000, NULL, '2026-06-24 16:50:26', '2026-06-24 16:50:26', NULL);
INSERT INTO `clients` (`id`, `name`, `totalFees`, `installmentCount`, `installmentValue`, `startDate`, `notes`, `createdAt`, `updatedAt`, `settledAt`) VALUES (30012, 'LUCAS DE SOUZA', '1500.00', 3, '500.00', 1782918000000, NULL, '2026-06-24 17:06:46', '2026-06-24 17:06:46', NULL);
INSERT INTO `clients` (`id`, `name`, `totalFees`, `installmentCount`, `installmentValue`, `startDate`, `notes`, `createdAt`, `updatedAt`, `settledAt`) VALUES (60001, 'JOÃO LUÍS BATISTA', '10000.00', 10, '1000.00', 1778857200000, NULL, '2026-07-03 11:54:56', '2026-07-03 12:56:50', NULL);
INSERT INTO `clients` (`id`, `name`, `totalFees`, `installmentCount`, `installmentValue`, `startDate`, `notes`, `createdAt`, `updatedAt`, `settledAt`) VALUES (90001, 'THAIS REGINA', '5000.00', 10, '5000.00', 1762009200000, NULL, '2026-07-03 20:10:14', '2026-07-03 20:10:14', NULL);
INSERT INTO `clients` (`id`, `name`, `totalFees`, `installmentCount`, `installmentValue`, `startDate`, `notes`, `createdAt`, `updatedAt`, `settledAt`) VALUES (120001, 'NÁGILA BIANCA', '6000.00', 13, '400.00', 1780671600000, NULL, '2026-07-06 19:23:31', '2026-07-06 19:23:31', NULL);
INSERT INTO `clients` (`id`, `name`, `totalFees`, `installmentCount`, `installmentValue`, `startDate`, `notes`, `createdAt`, `updatedAt`, `settledAt`) VALUES (150001, 'FRANCISCA MARIA BALDEZ', '1500.00', 2, '750.00', 1783350000000, NULL, '2026-07-07 20:00:15', '2026-07-07 20:00:15', NULL);
INSERT INTO `clients` (`id`, `name`, `totalFees`, `installmentCount`, `installmentValue`, `startDate`, `notes`, `createdAt`, `updatedAt`, `settledAt`) VALUES (180001, 'NILVANIA DA SILVA', '1300.00', 10, '150.00', 1772290800000, NULL, '2026-07-08 16:43:29', '2026-07-08 16:43:29', NULL);

-- ------------------------------------------------------------
-- Tabela: `installments`
-- ------------------------------------------------------------
DROP TABLE IF EXISTS `installments`;
CREATE TABLE `installments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `clientId` int NOT NULL,
  `number` int NOT NULL,
  `dueDate` bigint NOT NULL,
  `paidAt` bigint DEFAULT NULL,
  `status` enum('pending','paid','overdue') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) /*T![clustered_index] CLUSTERED */,
  KEY `installments_clientId_clients_id_fk` (`clientId`),
  CONSTRAINT `installments_clientId_clients_id_fk` FOREIGN KEY (`clientId`) REFERENCES `clients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=210001;

-- Dados de `installments` (130 registros)
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30049, 30004, 1, 1754665200000, 1782309891001, 'paid', '2026-06-24 14:04:08', '2026-06-24 14:04:51');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30050, 30004, 2, 1757343600000, NULL, 'overdue', '2026-06-24 14:04:08', '2026-06-24 14:04:08');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30051, 30004, 3, 1759935600000, NULL, 'overdue', '2026-06-24 14:04:08', '2026-06-24 14:04:08');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30052, 30004, 4, 1762614000000, NULL, 'overdue', '2026-06-24 14:04:08', '2026-06-24 14:04:08');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30053, 30004, 5, 1765206000000, NULL, 'overdue', '2026-06-24 14:04:08', '2026-06-24 14:04:08');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30054, 30004, 6, 1767884400000, 1782316333640, 'paid', '2026-06-24 14:04:08', '2026-06-24 15:52:14');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30055, 30004, 7, 1770562800000, 1782316371790, 'paid', '2026-06-24 14:04:08', '2026-06-24 15:52:52');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30056, 30004, 8, 1772982000000, NULL, 'overdue', '2026-06-24 14:04:08', '2026-06-24 14:04:08');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30057, 30004, 9, 1775660400000, NULL, 'overdue', '2026-06-24 14:04:08', '2026-06-24 14:04:08');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30058, 30004, 10, 1778252400000, NULL, 'overdue', '2026-06-24 14:04:08', '2026-06-24 14:04:08');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30059, 30004, 11, 1780930800000, NULL, 'overdue', '2026-06-24 14:04:08', '2026-06-24 14:04:08');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30060, 30004, 12, 1783522800000, NULL, 'overdue', '2026-06-24 14:04:08', '2026-07-08 16:38:59');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30061, 30004, 13, 1786201200000, NULL, 'pending', '2026-06-24 14:04:08', '2026-06-24 14:04:08');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30062, 30004, 14, 1788879600000, NULL, 'pending', '2026-06-24 14:04:08', '2026-06-24 14:04:08');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30063, 30004, 15, 1791471600000, NULL, 'pending', '2026-06-24 14:04:08', '2026-06-24 14:04:08');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30064, 30005, 1, 1777388400000, 1782317044901, 'paid', '2026-06-24 16:03:54', '2026-06-24 16:04:05');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30065, 30005, 2, 1779980400000, NULL, 'overdue', '2026-06-24 16:03:54', '2026-06-24 16:03:54');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30123, 30010, 1, 1764601200000, 1782319458800, 'paid', '2026-06-24 16:42:55', '2026-06-24 16:44:19');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30124, 30010, 2, 1767279600000, 1783096674842, 'paid', '2026-06-24 16:42:55', '2026-07-03 16:37:55');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30125, 30010, 3, 1769958000000, 1782319470098, 'paid', '2026-06-24 16:42:55', '2026-06-24 16:44:30');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30126, 30010, 4, 1772377200000, 1782319434792, 'paid', '2026-06-24 16:42:55', '2026-06-24 16:43:55');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30127, 30010, 5, 1775055600000, NULL, 'overdue', '2026-06-24 16:42:55', '2026-06-24 16:42:55');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30128, 30011, 1, 1768834800000, 1782319848187, 'paid', '2026-06-24 16:50:26', '2026-06-24 16:50:48');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30129, 30011, 2, 1771513200000, 1782319850963, 'paid', '2026-06-24 16:50:26', '2026-06-24 16:50:51');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30130, 30011, 3, 1773932400000, 1782319853588, 'paid', '2026-06-24 16:50:26', '2026-06-24 16:50:54');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30131, 30011, 4, 1776610800000, NULL, 'overdue', '2026-06-24 16:50:26', '2026-06-24 16:50:26');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30132, 30011, 5, 1779202800000, NULL, 'overdue', '2026-06-24 16:50:26', '2026-06-24 16:50:26');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30133, 30011, 6, 1781881200000, NULL, 'overdue', '2026-06-24 16:50:26', '2026-06-24 16:50:26');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30134, 30011, 7, 1784473200000, NULL, 'pending', '2026-06-24 16:50:26', '2026-06-24 16:50:26');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30135, 30011, 8, 1787151600000, NULL, 'pending', '2026-06-24 16:50:26', '2026-06-24 16:50:26');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30136, 30011, 9, 1789830000000, NULL, 'pending', '2026-06-24 16:50:26', '2026-06-24 16:50:26');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30137, 30011, 10, 1792422000000, NULL, 'pending', '2026-06-24 16:50:26', '2026-06-24 16:50:26');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30138, 30012, 1, 1782918000000, NULL, 'overdue', '2026-06-24 17:06:46', '2026-07-01 20:50:02');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30139, 30012, 2, 1785596400000, NULL, 'pending', '2026-06-24 17:06:46', '2026-06-24 17:06:46');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30140, 30012, 3, 1788274800000, NULL, 'pending', '2026-06-24 17:06:46', '2026-06-24 17:06:46');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30141, 1, 1, 1766588400000, 1782321538552, 'paid', '2026-06-24 17:17:48', '2026-06-24 17:18:59');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30142, 1, 2, 1769266800000, 1782321536826, 'paid', '2026-06-24 17:17:48', '2026-06-24 17:18:57');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30143, 1, 3, 1771945200000, 1782321535147, 'paid', '2026-06-24 17:17:48', '2026-06-24 17:18:55');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30144, 1, 4, 1774364400000, 1782321533535, 'paid', '2026-06-24 17:17:48', '2026-06-24 17:18:54');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30145, 1, 5, 1777042800000, 1782321500268, 'paid', '2026-06-24 17:17:48', '2026-06-24 17:18:20');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30146, 1, 6, 1779634800000, 1782321496463, 'paid', '2026-06-24 17:17:48', '2026-06-24 17:18:16');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30147, 1, 7, 1782313200000, 1783363485626, 'paid', '2026-06-24 17:17:48', '2026-07-06 18:44:46');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30148, 1, 8, 1784905200000, NULL, 'pending', '2026-06-24 17:17:48', '2026-06-24 17:17:48');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30149, 1, 9, 1787583600000, NULL, 'pending', '2026-06-24 17:17:48', '2026-06-24 17:17:48');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30150, 1, 10, 1790262000000, NULL, 'pending', '2026-06-24 17:17:48', '2026-06-24 17:17:48');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30151, 1, 11, 1792854000000, NULL, 'pending', '2026-06-24 17:17:48', '2026-06-24 17:17:48');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30152, 1, 12, 1795532400000, NULL, 'pending', '2026-06-24 17:17:48', '2026-06-24 17:17:48');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30153, 1, 13, 1798124400000, NULL, 'pending', '2026-06-24 17:17:48', '2026-06-24 17:17:48');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30154, 1, 14, 1800802800000, NULL, 'pending', '2026-06-24 17:17:48', '2026-06-24 17:17:48');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30155, 1, 15, 1803481200000, NULL, 'pending', '2026-06-24 17:17:48', '2026-06-24 17:17:48');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30156, 1, 16, 1805900400000, NULL, 'pending', '2026-06-24 17:17:48', '2026-06-24 17:17:48');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30157, 1, 17, 1808578800000, NULL, 'pending', '2026-06-24 17:17:48', '2026-06-24 17:17:48');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30158, 1, 18, 1811170800000, NULL, 'pending', '2026-06-24 17:17:48', '2026-06-24 17:17:48');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30159, 1, 19, 1813849200000, NULL, 'pending', '2026-06-24 17:17:48', '2026-06-24 17:17:48');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30160, 1, 20, 1816441200000, NULL, 'pending', '2026-06-24 17:17:48', '2026-06-24 17:17:48');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30161, 1, 21, 1819119600000, NULL, 'pending', '2026-06-24 17:17:48', '2026-06-24 17:17:48');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30162, 1, 22, 1821798000000, NULL, 'pending', '2026-06-24 17:17:48', '2026-06-24 17:17:48');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30163, 1, 23, 1824390000000, NULL, 'pending', '2026-06-24 17:17:48', '2026-06-24 17:17:48');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30164, 1, 24, 1827068400000, NULL, 'pending', '2026-06-24 17:17:48', '2026-06-24 17:17:48');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30165, 1, 25, 1829660400000, NULL, 'pending', '2026-06-24 17:17:48', '2026-06-24 17:17:48');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30166, 1, 26, 1832338800000, NULL, 'pending', '2026-06-24 17:17:48', '2026-06-24 17:17:48');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30167, 1, 27, 1835017200000, NULL, 'pending', '2026-06-24 17:17:48', '2026-06-24 17:17:48');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30168, 1, 28, 1837522800000, NULL, 'pending', '2026-06-24 17:17:48', '2026-06-24 17:17:48');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30169, 1, 29, 1840201200000, NULL, 'pending', '2026-06-24 17:17:48', '2026-06-24 17:17:48');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30170, 1, 30, 1842793200000, NULL, 'pending', '2026-06-24 17:17:48', '2026-06-24 17:17:48');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30171, 30009, 1, 1766502000000, 1782992067950, 'paid', '2026-06-24 17:21:49', '2026-07-02 11:34:28');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30172, 30009, 2, 1769180400000, NULL, 'overdue', '2026-06-24 17:21:49', '2026-06-24 17:21:49');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30173, 30009, 3, 1771858800000, NULL, 'overdue', '2026-06-24 17:21:49', '2026-06-24 17:21:49');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30174, 30009, 4, 1774278000000, NULL, 'overdue', '2026-06-24 17:21:49', '2026-06-24 17:21:49');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30175, 30009, 5, 1776956400000, 1782992079416, 'paid', '2026-06-24 17:21:49', '2026-07-02 11:34:39');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30176, 30009, 6, 1779548400000, 1782992090592, 'paid', '2026-06-24 17:21:49', '2026-07-02 11:34:51');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30177, 30009, 7, 1782226800000, 1782992150755, 'paid', '2026-06-24 17:21:49', '2026-07-02 11:35:51');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30178, 30009, 8, 1784818800000, 1782992033234, 'paid', '2026-06-24 17:21:49', '2026-07-02 11:33:53');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30179, 30009, 9, 1787497200000, NULL, 'pending', '2026-06-24 17:21:49', '2026-06-24 17:21:49');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30180, 30009, 10, 1790175600000, NULL, 'pending', '2026-06-24 17:21:49', '2026-06-24 17:21:49');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30181, 30009, 11, 1792767600000, NULL, 'pending', '2026-06-24 17:21:49', '2026-06-24 17:21:49');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30182, 30009, 12, 1795446000000, NULL, 'pending', '2026-06-24 17:21:49', '2026-06-24 17:21:49');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30183, 30009, 13, 1798038000000, NULL, 'pending', '2026-06-24 17:21:49', '2026-06-24 17:21:49');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30184, 30009, 14, 1800716400000, NULL, 'pending', '2026-06-24 17:21:49', '2026-06-24 17:21:49');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30185, 30009, 15, 1803394800000, NULL, 'pending', '2026-06-24 17:21:49', '2026-06-24 17:21:49');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30186, 30009, 16, 1805814000000, NULL, 'pending', '2026-06-24 17:21:49', '2026-06-24 17:21:49');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30187, 30009, 17, 1808492400000, NULL, 'pending', '2026-06-24 17:21:49', '2026-06-24 17:21:49');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30188, 30009, 18, 1811084400000, NULL, 'pending', '2026-06-24 17:21:49', '2026-06-24 17:21:49');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30189, 30009, 19, 1813762800000, NULL, 'pending', '2026-06-24 17:21:49', '2026-06-24 17:21:49');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (30190, 30009, 20, 1816354800000, NULL, 'pending', '2026-06-24 17:21:49', '2026-06-24 17:21:49');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (60019, 60001, 1, 1778857200000, 1783083415471, 'paid', '2026-07-03 12:56:49', '2026-07-03 12:56:55');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (60020, 60001, 2, 1781535600000, 1783083418129, 'paid', '2026-07-03 12:56:49', '2026-07-03 12:56:58');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (60021, 60001, 3, 1784127600000, 1783083421949, 'paid', '2026-07-03 12:56:49', '2026-07-03 12:57:02');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (60022, 60001, 4, 1786806000000, NULL, 'pending', '2026-07-03 12:56:49', '2026-07-03 12:56:49');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (60023, 60001, 5, 1789484400000, NULL, 'pending', '2026-07-03 12:56:49', '2026-07-03 12:56:49');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (60024, 60001, 6, 1792076400000, NULL, 'pending', '2026-07-03 12:56:49', '2026-07-03 12:56:49');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (60025, 60001, 7, 1794754800000, NULL, 'pending', '2026-07-03 12:56:49', '2026-07-03 12:56:49');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (60026, 60001, 8, 1797346800000, NULL, 'pending', '2026-07-03 12:56:49', '2026-07-03 12:56:49');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (60027, 60001, 9, 1800025200000, NULL, 'pending', '2026-07-03 12:56:49', '2026-07-03 12:56:49');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (60028, 60001, 10, 1802703600000, NULL, 'pending', '2026-07-03 12:56:49', '2026-07-03 12:56:49');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (90001, 90001, 1, 1762009200000, 1783109476359, 'paid', '2026-07-03 20:10:14', '2026-07-03 20:11:16');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (90002, 90001, 2, 1764601200000, 1783109472606, 'paid', '2026-07-03 20:10:14', '2026-07-03 20:11:13');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (90003, 90001, 3, 1767279600000, 1783109470943, 'paid', '2026-07-03 20:10:14', '2026-07-03 20:11:11');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (90004, 90001, 4, 1769958000000, 1783109469455, 'paid', '2026-07-03 20:10:14', '2026-07-03 20:11:09');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (90005, 90001, 5, 1772377200000, 1783109467294, 'paid', '2026-07-03 20:10:14', '2026-07-03 20:11:07');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (90006, 90001, 6, 1775055600000, 1783109465872, 'paid', '2026-07-03 20:10:14', '2026-07-03 20:11:06');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (90007, 90001, 7, 1777647600000, 1783109474329, 'paid', '2026-07-03 20:10:14', '2026-07-03 20:11:14');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (90008, 90001, 8, 1780326000000, 1783109464396, 'paid', '2026-07-03 20:10:14', '2026-07-03 20:11:04');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (90009, 90001, 9, 1782918000000, 1783109462762, 'paid', '2026-07-03 20:10:14', '2026-07-03 20:11:03');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (90010, 90001, 10, 1785596400000, NULL, 'pending', '2026-07-03 20:10:14', '2026-07-03 20:10:14');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (120001, 120001, 1, 1780671600000, 1783365820068, 'paid', '2026-07-06 19:23:31', '2026-07-06 19:23:40');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (120002, 120001, 2, 1783263600000, 1783365822927, 'paid', '2026-07-06 19:23:31', '2026-07-06 19:23:43');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (120003, 120001, 3, 1785942000000, NULL, 'pending', '2026-07-06 19:23:31', '2026-07-06 19:23:31');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (120004, 120001, 4, 1788620400000, NULL, 'pending', '2026-07-06 19:23:31', '2026-07-06 19:23:31');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (120005, 120001, 5, 1791212400000, NULL, 'pending', '2026-07-06 19:23:31', '2026-07-06 19:23:31');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (120006, 120001, 6, 1793890800000, NULL, 'pending', '2026-07-06 19:23:31', '2026-07-06 19:23:31');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (120007, 120001, 7, 1796482800000, NULL, 'pending', '2026-07-06 19:23:31', '2026-07-06 19:23:31');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (120008, 120001, 8, 1799161200000, NULL, 'pending', '2026-07-06 19:23:31', '2026-07-06 19:23:31');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (120009, 120001, 9, 1801839600000, NULL, 'pending', '2026-07-06 19:23:31', '2026-07-06 19:23:31');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (120010, 120001, 10, 1804258800000, NULL, 'pending', '2026-07-06 19:23:31', '2026-07-06 19:23:31');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (120011, 120001, 11, 1806937200000, NULL, 'pending', '2026-07-06 19:23:31', '2026-07-06 19:23:31');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (120012, 120001, 12, 1809529200000, NULL, 'pending', '2026-07-06 19:23:31', '2026-07-06 19:23:31');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (120013, 120001, 13, 1812207600000, NULL, 'pending', '2026-07-06 19:23:31', '2026-07-06 19:23:31');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (150001, 150001, 1, 1780758000000, 1783454457615, 'paid', '2026-07-07 20:00:15', '2026-07-07 20:00:58');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (150002, 150001, 2, 1783350000000, NULL, 'overdue', '2026-07-07 20:00:15', '2026-07-07 20:01:04');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (180001, 180001, 1, 1772290800000, 1783529053489, 'paid', '2026-07-08 16:43:29', '2026-07-08 16:44:13');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (180002, 180001, 2, 1774710000000, 1783529051013, 'paid', '2026-07-08 16:43:29', '2026-07-08 16:44:11');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (180003, 180001, 3, 1777388400000, 1783529048828, 'paid', '2026-07-08 16:43:29', '2026-07-08 16:44:09');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (180004, 180001, 4, 1779980400000, 1783529047014, 'paid', '2026-07-08 16:43:29', '2026-07-08 16:44:07');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (180005, 180001, 5, 1782658800000, 1783529045137, 'paid', '2026-07-08 16:43:29', '2026-07-08 16:44:05');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (180006, 180001, 6, 1785250800000, 1783529042313, 'paid', '2026-07-08 16:43:29', '2026-07-08 16:44:02');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (180007, 180001, 7, 1787929200000, NULL, 'pending', '2026-07-08 16:43:29', '2026-07-08 16:43:29');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (180008, 180001, 8, 1790607600000, NULL, 'pending', '2026-07-08 16:43:29', '2026-07-08 16:43:29');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (180009, 180001, 9, 1793199600000, NULL, 'pending', '2026-07-08 16:43:29', '2026-07-08 16:43:29');
INSERT INTO `installments` (`id`, `clientId`, `number`, `dueDate`, `paidAt`, `status`, `createdAt`, `updatedAt`) VALUES (180010, 180001, 10, 1795878000000, NULL, 'pending', '2026-07-08 16:43:29', '2026-07-08 16:43:29');

SET FOREIGN_KEY_CHECKS = 1;

-- Fim do dump