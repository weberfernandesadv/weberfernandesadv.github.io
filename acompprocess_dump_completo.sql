-- Dump do banco de dados: iZRnCDjueaYGD68s28cofE
-- Gerado em: 2026-07-10T20:34:04.207Z
-- Tabelas: users, processos, novidades

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- --------------------------------------------------------
-- Estrutura da tabela `users`
-- --------------------------------------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=16740001;

-- Dados da tabela `users` (3 registros)
INSERT INTO `users` (`id`, `openId`, `name`, `email`, `loginMethod`, `role`, `createdAt`, `updatedAt`, `lastSignedIn`) VALUES
(1, 'c6ZqiT5iF4h2UzHSxadQkV', 'Prof. Weber', 'wolfrickwolf@gmail.com', 'google', 'admin', '2026-05-09 06:27:45', '2026-07-10 20:20:59', '2026-07-10 20:20:59'),
(9750022, '7Z8EXJFySR5xC27NNNaXg2', 'Lucas Spolti', 'lucassspolti@gmail.com', 'google', 'user', '2026-06-25 16:25:08', '2026-06-25 17:17:02', '2026-06-25 17:17:01'),
(9810005, 'EJ7hV5rLsfG54XHQfUifCR', 'Davy Scheuermann', 'davy.scheuermann@razonet.com.br', 'google', 'user', '2026-06-25 16:55:25', '2026-06-25 17:00:09', '2026-06-25 17:00:09');

-- --------------------------------------------------------
-- Estrutura da tabela `processos`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `processos`;
CREATE TABLE `processos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `numeroCnj` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tribunal` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ativo` tinyint(1) NOT NULL DEFAULT '1',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `dataLimite` date DEFAULT NULL,
  `tipoManifestacao` enum('Recurso','Resposta','Apelação','Embargos de declaração','Autos conclusos','Conciliação','Audiência','Contestação','Impugnação','Outro') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cliente` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `anotacao` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `horario` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dataIntimacao` date DEFAULT NULL,
  PRIMARY KEY (`id`) /*T![clustered_index] CLUSTERED */
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=750001;

-- Dados da tabela `processos` (89 registros)
INSERT INTO `processos` (`id`, `userId`, `numeroCnj`, `tribunal`, `ativo`, `createdAt`, `updatedAt`, `dataLimite`, `tipoManifestacao`, `cliente`, `anotacao`, `horario`, `dataIntimacao`) VALUES
(1, 1, '5106433-08.2023.8.09.0099', 'TJGO', 0, '2026-05-09 06:50:04', '2026-05-11 17:50:42', '2026-05-26 00:00:00', 'Resposta', 'Odair', NULL, NULL, NULL),
(2, 1, '5980803-55.2025.8.09.0130', 'TJGO', 1, '2026-05-09 06:50:04', '2026-05-29 18:15:17', '2026-05-29 00:00:00', 'Autos conclusos', NULL, '14:30', NULL, NULL),
(3, 1, '5248885-83.2026.8.09.0051', 'TJGO', 0, '2026-05-09 06:50:04', '2026-05-11 12:34:24', '2026-05-18 00:00:00', 'Conciliação', NULL, '14:00', NULL, NULL),
(4, 1, '5144869-49.2024.8.09.0051', 'TJGO', 0, '2026-05-09 06:50:04', '2026-05-18 16:03:24', '2026-05-22 00:00:00', 'Resposta', NULL, NULL, NULL, NULL),
(5, 1, '5061666-24.2026.8.09.0051', 'TJGO', 1, '2026-05-09 06:50:04', '2026-05-09 06:50:04', NULL, NULL, NULL, NULL, NULL, NULL),
(6, 1, '5089329-45.2026.8.09.0051', 'TJGO', 0, '2026-05-09 06:50:04', '2026-05-09 07:07:41', '2026-05-07 00:00:00', 'Resposta', NULL, NULL, NULL, NULL),
(7, 1, '5024260-66.2026.8.09.0051', 'TJGO', 0, '2026-05-09 06:50:04', '2026-05-11 15:15:43', '2026-05-20 00:00:00', 'Outro', NULL, 'Recorrer ou não', NULL, NULL),
(8, 1, '5563039-67.2025.8.09.0051', 'TJGO', 0, '2026-05-09 06:50:04', '2026-05-15 19:33:49', '2026-05-15 00:00:00', 'Resposta', 'Marlene', NULL, NULL, NULL),
(9, 1, '5989484-91.2024.8.09.0051', 'TJGO', 0, '2026-05-09 06:50:04', '2026-05-12 15:55:27', '2026-05-15 00:00:00', 'Resposta', NULL, NULL, NULL, NULL),
(10, 1, '5554704-59.2025.8.09.0051', 'TJGO', 0, '2026-05-09 06:50:04', '2026-06-01 13:42:58', NULL, 'Resposta', 'Devair', NULL, NULL, NULL),
(11, 1, '5258413-44.2026.8.09.0051', 'TJGO', 1, '2026-05-09 06:50:04', '2026-07-01 12:40:20', NULL, 'Conciliação', 'Nágila', 'Audiência', '15:00', '2026-08-17 00:00:00'),
(12, 1, '5829187-13.2024.8.09.0051', 'TJGO', 0, '2026-05-09 06:50:04', '2026-05-09 07:07:40', '2026-05-07 00:00:00', 'Resposta', NULL, NULL, NULL, NULL),
(13, 1, '5283239-71.2025.8.09.0051', 'TJGO', 0, '2026-05-09 06:50:04', '2026-05-09 07:07:38', '2026-05-06 00:00:00', 'Resposta', 'Margarida', NULL, NULL, NULL),
(14, 1, '5172432-47.2026.8.09.0051', 'TJGO', 0, '2026-05-09 06:50:04', '2026-05-11 17:48:52', '2026-05-15 00:00:00', 'Conciliação', NULL, '17:00', NULL, NULL),
(30001, 1, '5223008-93.2016.8.09.0051', 'TJGO', 1, '2026-05-11 11:32:16', '2026-06-23 13:58:13', '2026-07-07 00:00:00', 'Recurso', 'HONIELLY', 'Agravo de instrumento ', NULL, '2026-06-16 00:00:00'),
(30002, 1, '5989484-91.2024.8.09.0051', 'TJGO', 1, '2026-05-11 11:41:58', '2026-05-11 11:41:58', '2026-04-17 00:00:00', 'Autos conclusos', 'HONIELLY', NULL, NULL, NULL),
(30003, 1, '5016205-63.2025.8.09.0051', 'TJGO', 1, '2026-05-11 11:43:45', '2026-07-10 12:18:22', '2026-07-20 00:00:00', 'Apelação', 'Elvis', 'Apelação processo ELVIS', NULL, '2026-07-09 00:00:00'),
(30004, 1, '5091948-79.2025.8.09.0051', 'TJGO', 1, '2026-05-11 11:44:36', '2026-07-01 12:36:31', '2026-07-17 00:00:00', 'Autos conclusos', 'Mateus', 'Rejeita exceção de pré-executividade/int. para pagamento do débito.', NULL, '2026-06-26 00:00:00'),
(30005, 1, '5305232-73.2025.8.09.0051', 'TJGO', 0, '2026-05-11 11:45:49', '2026-05-11 11:57:03', '2026-04-22 00:00:00', 'Outro', NULL, 'chamamento do feito à ordem', NULL, NULL),
(30006, 1, '5305232-73.2025.8.09.0051', 'TJGO', 1, '2026-05-11 11:58:09', '2026-05-11 11:58:09', '2026-04-22 00:00:00', 'Outro', 'Priscila (Espanha)', 'Chamamento do Feito a ordem', NULL, NULL),
(30007, 1, '5585454-44.2025.8.09.0051', 'TJGO', 1, '2026-05-11 11:59:38', '2026-05-11 11:59:38', '2026-03-21 00:00:00', 'Outro', 'Eniléia (Divóricio)', 'Parecer MP', NULL, NULL),
(30008, 1, '5590762-61.2025.8.09.0051', 'TJGO', 0, '2026-05-11 12:01:39', '2026-07-03 13:23:59', '2026-06-02 00:00:00', 'Resposta', 'Eniléia (Pensão HH)', 'execução cobrar', NULL, NULL),
(30009, 1, '5890907-44.2025.8.09.0051', 'TJGO', 1, '2026-05-11 12:03:30', '2026-05-11 12:03:30', '2026-04-27 00:00:00', 'Outro', 'Jenifer', 'fase Provas', NULL, NULL),
(30010, 1, '6026398-23.2025.8.09.0051', 'TJGO', 1, '2026-05-11 12:08:19', '2026-06-23 17:09:48', '2026-06-19 00:00:00', 'Autos conclusos', 'Jenifer', 'Autos conclusos', NULL, NULL),
(30011, 1, '5172432-47.2026.8.09.0051', 'TJGO', 1, '2026-05-11 12:10:53', '2026-06-23 17:15:40', '2026-06-26 00:00:00', 'Resposta', 'Luciana', 'Apresentar provas', NULL, NULL),
(30012, 1, '5248885-83.2026.8.09.0051', 'TJGO', 0, '2026-05-11 12:13:17', '2026-06-01 13:55:33', '2026-06-05 00:00:00', 'Resposta', 'Nágila', 'CONTESTAÇÃO', NULL, NULL),
(30013, 1, '5292412-85.2026.8.09.0051', 'TJGO', 1, '2026-05-11 12:36:43', '2026-06-23 12:31:29', '2026-07-17 00:00:00', 'Conciliação', 'Sabrina', 'procuração do filho', '14:00', '2026-06-02 00:00:00'),
(30014, 1, '5078798-07.2020.8.09.0051', 'TJGO', 1, '2026-05-11 12:38:12', '2026-07-03 13:22:58', '2026-07-24 00:00:00', 'Outro', 'Thalita', 'Intimações para Herdeiros', NULL, '2026-07-03 00:00:00'),
(30015, 1, '5645405-08.2021.8.09.0051', 'TJGO', 0, '2026-05-11 12:40:02', '2026-05-24 17:05:06', '2026-04-14 00:00:00', 'Outro', 'Thalita', 'prestar contas 2ª fase', NULL, NULL),
(30016, 1, '5078374-22.2024.8.09.0116', 'TJGO', 1, '2026-05-11 12:41:07', '2026-07-02 13:39:21', '2026-07-01 00:00:00', 'Audiência', 'Karoline PB', 'intimação', '17:30', NULL),
(30017, 1, '5179539-05.2025.8.09.0011', 'TJGO', 1, '2026-05-11 12:42:05', '2026-06-23 12:49:24', '2026-07-01 00:00:00', 'Resposta', 'Sônia', 'Responder a quebra de sigilo.', NULL, '2026-06-10 00:00:00'),
(30018, 1, '5233001-67.2025.8.09.0174', 'TJGO', 1, '2026-05-11 12:44:29', '2026-07-02 12:39:04', '2026-07-20 00:00:00', 'Audiência', 'Julio', 'AIARespAExt', '10:00', NULL),
(30019, 1, '5202204-86.2025.8.09.0149', 'TJGO', 1, '2026-05-11 12:49:07', '2026-05-11 12:49:07', '2026-02-03 00:00:00', 'Outro', 'Elymara', 'Criminal - MP Parecer', NULL, NULL),
(30020, 1, '5995431-53.2025.8.09.0064', 'TJGO', 1, '2026-05-11 12:50:20', '2026-05-11 12:50:20', '2026-05-02 00:00:00', 'Outro', 'Marcos ', 'Criminal - Prisão Ilegal', NULL, NULL),
(30021, 1, '5106433-08.2023.8.09.0099', 'TJGO', 1, '2026-05-11 12:51:46', '2026-05-11 12:51:46', '2026-05-07 00:00:00', 'Outro', 'Odair', 'Aguardar Cálculos da Contadoria', NULL, NULL),
(30022, 1, '5725166-44.2024.8.09.0064', 'TJGO', 1, '2026-05-11 12:54:09', '2026-05-11 12:54:09', '2026-03-31 00:00:00', 'Autos conclusos', 'Damião', 'avaliação das benfeitorias', NULL, NULL),
(30023, 1, '5745940-61.2025.8.09.0064', 'TJGO', 1, '2026-05-11 12:55:37', '2026-05-11 12:55:37', '2026-04-09 00:00:00', 'Outro', 'Nilvania', 'Reingressar', NULL, NULL),
(30024, 1, '5980803-55.2025.8.09.0130', 'TJGO', 1, '2026-05-11 12:56:40', '2026-06-03 10:38:12', '2026-06-01 00:00:00', 'Autos conclusos', 'Leidiane', 'endereços réus', NULL, NULL),
(30025, 1, '5017438-71.2020.8.09.0051', 'TJGO', 1, '2026-05-11 12:58:11', '2026-05-11 12:58:11', '2026-04-06 00:00:00', 'Outro', 'Kênia', 'Autos devolvidos - aguardar', NULL, NULL),
(30026, 1, '5292656-27.2026.8.09.0079', 'TJGO', 0, '2026-05-11 12:59:26', '2026-05-14 19:13:58', '2026-05-11 00:00:00', 'Resposta', 'Janes', 'guarda dos filhos', NULL, NULL),
(30027, 1, '5220911-55.2024.8.09.0176', 'TJGO', 1, '2026-05-11 13:01:47', '2026-06-23 13:52:13', '2026-07-07 00:00:00', 'Outro', 'Honielly', NULL, NULL, '2026-06-16 00:00:00'),
(30028, 1, '5949251-17.2025.8.09.0116', 'TJGO', 1, '2026-05-11 13:56:28', '2026-05-27 02:50:37', '2026-05-25 00:00:00', 'Outro', 'Divina', 'Acordo, cumprimento', NULL, NULL),
(30029, 1, '5366913-78.2024.8.09.0051', 'TJGO', 1, '2026-05-11 13:58:29', '2026-07-09 14:03:45', '2026-07-14 00:00:00', 'Audiência', 'Ester', 'Mediação - https://us05web.zoom.us/j/88337434251?pwd=4conOVlJfrknDTRbK7N2HQs0kcma5r.1', '14:30', NULL),
(30030, 1, '5423899-52.2024.8.09.0051', 'TJGO', 1, '2026-05-11 13:59:55', '2026-05-28 18:32:45', '2026-05-28 00:00:00', 'Outro', 'Tiago Londres', 'Impugnar Perícia', NULL, NULL),
(30031, 1, '5829187-13.2024.8.09.0051', 'TJGO', 1, '2026-05-11 14:01:48', '2026-07-09 13:34:35', '2026-06-07 00:00:00', 'Autos conclusos', 'Leonardo', 'Documento novo - Prodago Proprietária', NULL, NULL),
(30032, 1, '6145181-27.2024.8.09.0174', 'TJGO', 1, '2026-05-11 14:10:08', '2026-06-23 12:11:27', '2026-07-15 00:00:00', 'Resposta', 'Júlio Gomes', 'Responder sobre o Laudo Pericial.', NULL, '2026-06-24 00:00:00'),
(30033, 1, '5283239-71.2025.8.09.0051', 'TJGO', 1, '2026-05-11 14:11:16', '2026-06-23 13:28:37', '2026-07-06 00:00:00', 'Resposta', 'Margarida', 'Contra Razões', NULL, '2026-06-15 00:00:00'),
(30034, 1, '5340195-33.2025.8.09.0011', 'TJGO', 1, '2026-05-11 15:10:02', '2026-06-23 17:27:24', '2026-07-09 00:00:00', 'Resposta', 'Bruno', 'Apresentar endereços para Citação', NULL, '2026-06-18 00:00:00'),
(30035, 1, '5497561-15.2025.8.09.0051', 'TJGO', 1, '2026-05-11 15:11:30', '2026-05-11 15:11:30', '2026-05-05 00:00:00', 'Autos conclusos', 'Claúdia', 'prestar contas', NULL, NULL),
(30036, 1, '5554704-59.2025.8.09.0051', 'TJGO', 1, '2026-05-11 15:12:24', '2026-07-02 13:31:07', '2026-07-08 00:00:00', 'Resposta', 'Devair', 'RESPOSTA ', NULL, '2026-07-01 00:00:00');
INSERT INTO `processos` (`id`, `userId`, `numeroCnj`, `tribunal`, `ativo`, `createdAt`, `updatedAt`, `dataLimite`, `tipoManifestacao`, `cliente`, `anotacao`, `horario`, `dataIntimacao`) VALUES
(30037, 1, '5563039-67.2025.8.09.0051', 'TJGO', 1, '2026-05-11 15:13:28', '2026-07-10 12:24:47', '2026-07-30 00:00:00', 'Resposta', 'Marlene', 'Responder a petição de Fernanda', NULL, '2026-07-09 00:00:00'),
(30038, 1, '5024260-66.2026.8.09.0051', 'TJGO', 1, '2026-05-11 15:14:16', '2026-05-11 15:16:51', '2026-05-20 00:00:00', 'Outro', 'Leonardo', 'aguardar sentença', NULL, NULL),
(30039, 1, '5089329-45.2026.8.09.0051', 'TJGO', 1, '2026-05-11 15:18:04', '2026-05-11 15:18:04', '2026-05-05 00:00:00', 'Autos conclusos', 'Margarida', 'endereços para citação - pronto', NULL, NULL),
(30040, 1, '5147102-48.2026.8.09.0051', 'TJGO', 1, '2026-05-11 15:19:06', '2026-05-11 15:19:06', '2026-05-05 00:00:00', 'Autos conclusos', 'Marlene', 'Marlene x Equatorial', NULL, NULL),
(30041, 1, '5144869-49.2024.8.09.0051', 'TJGO', 1, '2026-05-11 15:38:40', '2026-05-27 04:12:11', '2026-05-22 00:00:00', 'Outro', 'Margarida', 'Decisão Penhora', NULL, NULL),
(30042, 1, '5429282-98.2022.8.09.0174', 'TJGO', 1, '2026-05-11 15:41:14', '2026-06-23 19:27:39', NULL, 'Outro', 'Daniel', 'Processo arquivado.', NULL, NULL),
(30043, 1, '5915052-03.2024.8.09.0116', 'TJGO', 1, '2026-05-11 15:42:49', '2026-05-11 15:42:59', '2026-05-05 00:00:00', 'Outro', 'Edmar', 'Criminal - Medida protetiva', NULL, NULL),
(30044, 1, '5292530-84.2026.8.09.0011', 'TJGO', 0, '2026-05-11 15:44:21', '2026-05-15 21:45:36', '2026-05-05 00:00:00', 'Autos conclusos', 'Janes', 'Criminal', NULL, NULL),
(30045, 1, '5536655-57.2023.8.09.0174', 'TJGO', 1, '2026-05-11 15:46:20', '2026-06-16 13:24:42', '2026-07-23 00:00:00', 'Autos conclusos', 'Dorizeth', 'REsp e RExt', NULL, NULL),
(30046, 1, '5310003-31.2024.8.09.0051', 'TJGO', 1, '2026-05-11 15:47:17', '2026-05-11 15:47:17', '2026-05-05 00:00:00', 'Outro', 'Odair', 'REsp e RExt', NULL, NULL),
(30047, 1, '0000093-45.2025.5.18.0006', 'TRT18', 1, '2026-05-11 16:06:46', '2026-05-11 16:06:46', '2026-05-05 00:00:00', 'Outro', 'Angelina', 'verificar 2° Grau', NULL, NULL),
(30048, 1, '0000093-45.2025.5.18.0006', 'TRT18', 0, '2026-05-11 16:20:10', '2026-05-11 16:20:34', '2026-05-05 00:00:00', 'Outro', 'Angelina', 'ver 2° Grau', NULL, NULL),
(30049, 1, '0001362-37.2025.5.18.0001', 'TRT18', 1, '2026-05-11 16:27:44', '2026-06-03 10:37:44', '2026-06-02 00:00:00', 'Autos conclusos', 'Gabrielle', 'Resposta da reclamada', NULL, NULL),
(30050, 1, '0002018-58.2025.5.18.0012', 'TRT18', 1, '2026-05-11 16:30:01', '2026-05-22 18:30:26', '2026-05-21 00:00:00', 'Autos conclusos', 'Matheus', 'Audiência de Instrução - sala 02', NULL, NULL),
(60001, 1, '5407706-88.2026.8.09.0051', 'TJGO', 1, '2026-05-11 17:23:25', '2026-06-16 13:54:20', '2026-07-21 00:00:00', 'Autos conclusos', 'Krisner', 'anulatoria de PAD', NULL, NULL),
(60002, 1, '5389036-07.2023.8.09.0051', 'TJGO', 1, '2026-05-11 17:35:15', '2026-05-11 17:35:15', '2026-05-05 00:00:00', 'Outro', 'Claúdia', 'Processo de São João Del Rei', NULL, NULL),
(90001, 1, '5365368-21.2026.8.09.0174', 'TJGO', 0, '2026-05-11 17:48:01', '2026-07-03 13:24:03', '2026-05-26 00:00:00', 'Resposta', 'Dahiana', 'Impugnar Imobiliária', NULL, NULL),
(120001, 1, '5292656-27.2026.8.09.0079', 'TJGO', 0, '2026-05-14 19:15:06', '2026-07-03 13:24:15', '2026-06-16 00:00:00', 'Audiência', 'Janes', 'Vara infancia e juventude', '15:30', NULL),
(150001, 1, '5292530-84.2026.8.09.0011', 'TJGO', 1, '2026-05-15 20:25:45', '2026-06-06 16:32:27', '2026-09-04 00:00:00', 'Audiência', 'Janes', 'ouvir Pedro', '15:00', NULL),
(180001, 1, '0010386-08.2026.8.27.2700', 'TJTO', 1, '2026-05-18 01:19:56', '2026-05-27 04:12:37', '2026-05-17 00:00:00', 'Outro', 'AILTON NAZARIO DOS SANTOS', 'Habeas Corpus', NULL, NULL),
(210001, 1, '5365368-21.2026.8.09.0174', 'TJGO', 0, '2026-05-19 12:53:52', '2026-05-27 02:45:10', '2026-05-26 00:00:00', NULL, 'Contestar', NULL, NULL, NULL),
(240001, 1, '5645405-08.2021.8.09.0051', 'TJGO', 1, '2026-05-24 17:04:40', '2026-05-24 17:04:40', '2026-06-18 00:00:00', 'Resposta', 'Marina/Talita - exigir contas', 'resposta - pedir julgamento ', NULL, NULL),
(270001, 1, '5468567-63.2026.8.09.0011', 'TJGO', 1, '2026-05-25 23:14:45', '2026-07-09 14:09:25', '2026-07-01 00:00:00', 'Autos conclusos', 'Jackeline - PA', 'Explicar valor da causa.', NULL, '2026-06-10 00:00:00'),
(300001, 1, '5367115-21.2025.8.09.0051', 'TJGO', 1, '2026-05-26 21:32:21', '2026-05-26 21:32:21', '2026-05-06 00:00:00', 'Outro', 'Gabriele', 'Execução trabalhista', NULL, NULL),
(330001, 1, '5940730-84.2025.8.09.0051', 'TJGO', 1, '2026-05-28 14:16:15', '2026-05-28 14:16:53', '2026-05-28 00:00:00', 'Outro', 'Paloma', 'processo educação', NULL, NULL),
(360001, 1, '5536655-57.2023.8.09.0174', 'TJGO', 0, '2026-05-29 19:52:40', '2026-06-16 13:24:13', '2026-05-29 00:00:00', 'Autos conclusos', 'Dorizeth', 'Recurso ao STJ', NULL, NULL),
(360002, 1, '5303068-23.2026.8.09.0174', 'TJGO', 1, '2026-05-29 19:53:49', '2026-07-09 13:35:04', '2026-05-27 00:00:00', 'Autos conclusos', 'Dorizeth', 'Cumprimento de sentença', NULL, NULL),
(390001, 1, '5248885-83.2026.8.09.0051', 'TJGO', 1, '2026-06-01 13:53:59', '2026-07-02 13:26:18', '2026-07-24 00:00:00', 'Resposta', 'Nágila', 'INTIMAÇÃO', NULL, '2026-07-03 00:00:00'),
(420001, 1, '5407735-95.2026.8.09.0130', 'TJGO', 1, '2026-06-07 14:45:19', '2026-06-07 14:45:19', '2026-06-07 00:00:00', 'Autos conclusos', 'Leidiane', 'Processo Saraiva X Leidiane', NULL, NULL),
(450001, 1, '0000964-05.2026.5.18.0018', 'TRT18', 1, '2026-06-08 13:29:10', '2026-06-08 13:29:10', '2026-07-07 00:00:00', 'Audiência', 'Honielly', NULL, '15:30', NULL),
(480001, 1, '1002034-62.2025.4.01.3500', 'TRF1', 1, '2026-06-11 22:36:31', '2026-06-11 22:36:31', '2026-06-11 00:00:00', 'Outro', 'Kênia', 'processo execução fiscal\n', NULL, NULL),
(510001, 1, '6063041-37.2024.8.09.0011', 'TJGO', 1, '2026-06-15 21:11:04', '2026-06-15 21:35:04', '2026-07-21 00:00:00', 'Audiência', 'Jhons Santos', NULL, '15:00', NULL),
(540001, 1, '5606642-64.2023.8.09.0051', 'TJGO', 1, '2026-06-15 21:42:17', '2026-06-15 21:42:17', NULL, NULL, 'Elivelton', NULL, NULL, NULL),
(570001, 1, '5539206-09.2026.8.09.0011', 'TJGO', 1, '2026-06-16 13:05:08', '2026-06-23 13:54:48', '2026-07-16 00:00:00', 'Autos conclusos', 'Jackeline AI', 'Avaliar recurso', NULL, NULL),
(600001, 1, '5860013-85.2025.8.09.0051', 'TJGO', 1, '2026-06-23 12:24:59', '2026-06-23 12:24:59', '2026-06-29 00:00:00', 'Recurso', 'Kennya', 'Verificar se irá recorrer.', NULL, NULL),
(630001, 1, '5622706-47.2026.8.09.0051', 'TJGO', 1, '2026-07-08 03:17:50', '2026-07-08 03:17:50', NULL, 'Autos conclusos', 'Honielly', 'Agravo de instrumento processo  5223008-93', NULL, NULL),
(660001, 1, '0000825-71.2024.8.27.2718', 'TJTO', 1, '2026-07-08 11:49:20', '2026-07-08 11:49:20', '2026-07-18 00:00:00', 'Resposta', 'PAULO SIMÃO', NULL, NULL, NULL),
(690001, 1, '5292656-27.2026.8.09.0079', 'TJGO', 1, '2026-07-08 14:24:28', '2026-07-08 14:24:28', NULL, NULL, 'Janes', NULL, NULL, NULL),
(720001, 1, '5624182-23.2026.8.09.0051', 'TJGO', 1, '2026-07-08 16:01:34', '2026-07-08 16:01:34', NULL, 'Autos conclusos', 'Lorenna Martins - Divórcio ', NULL, NULL, NULL);

-- --------------------------------------------------------
-- Estrutura da tabela `novidades`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `novidades`;
CREATE TABLE `novidades` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `processoId` int DEFAULT NULL,
  `titulo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `conteudo` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lida` tinyint(1) NOT NULL DEFAULT '0',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) /*T![clustered_index] CLUSTERED */
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=720001;

-- Dados da tabela `novidades` (75 registros)
INSERT INTO `novidades` (`id`, `userId`, `processoId`, `titulo`, `conteudo`, `lida`, `createdAt`) VALUES
(1, 1, NULL, 'Processo 5223008-93.2016.8.09.0051 cadastrado', 'O processo 5223008-93.2016.8.09.0051 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-11 11:32:16'),
(2, 1, NULL, 'Processo 5989484-91.2024.8.09.0051 cadastrado', 'O processo 5989484-91.2024.8.09.0051 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-11 11:41:58'),
(3, 1, NULL, 'Processo 5016205-63.2025.8.09.0051 cadastrado', 'O processo 5016205-63.2025.8.09.0051 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-11 11:43:45'),
(4, 1, NULL, 'Processo 5091948-79.2025.8.09.0051 cadastrado', 'O processo 5091948-79.2025.8.09.0051 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-11 11:44:36'),
(5, 1, NULL, 'Processo 5305232-73.2025.8.09.0051 cadastrado', 'O processo 5305232-73.2025.8.09.0051 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-11 11:45:49'),
(6, 1, NULL, 'Processo 5305232-73.2025.8.09.0051 cadastrado', 'O processo 5305232-73.2025.8.09.0051 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-11 11:58:10'),
(7, 1, NULL, 'Processo 5585454-44.2025.8.09.0051 cadastrado', 'O processo 5585454-44.2025.8.09.0051 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-11 11:59:38'),
(8, 1, NULL, 'Processo 5590762-61.2025.8.09.0051 cadastrado', 'O processo 5590762-61.2025.8.09.0051 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-11 12:01:39'),
(9, 1, NULL, 'Processo 5890907-44.2025.8.09.0051 cadastrado', 'O processo 5890907-44.2025.8.09.0051 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-11 12:03:30'),
(10, 1, NULL, 'Processo 6026398-23.2025.8.09.0051 cadastrado', 'O processo 6026398-23.2025.8.09.0051 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-11 12:08:19'),
(11, 1, NULL, 'Processo 5172432-47.2026.8.09.0051 cadastrado', 'O processo 5172432-47.2026.8.09.0051 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-11 12:10:53'),
(12, 1, NULL, 'Processo 5248885-83.2026.8.09.0051 cadastrado', 'O processo 5248885-83.2026.8.09.0051 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-11 12:13:17'),
(13, 1, NULL, 'Processo 5292412-85.2026.8.09.0051 cadastrado', 'O processo 5292412-85.2026.8.09.0051 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-11 12:36:43'),
(14, 1, NULL, 'Processo 5078798-07.2020.8.09.0051 cadastrado', 'O processo 5078798-07.2020.8.09.0051 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-11 12:38:12'),
(15, 1, NULL, 'Processo 5645405-08.2021.8.09.0051 cadastrado', 'O processo 5645405-08.2021.8.09.0051 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-11 12:40:02'),
(16, 1, NULL, 'Processo 5078374-22.2024.8.09.0116 cadastrado', 'O processo 5078374-22.2024.8.09.0116 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-11 12:41:07'),
(17, 1, NULL, 'Processo 5179539-05.2025.8.09.0011 cadastrado', 'O processo 5179539-05.2025.8.09.0011 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-11 12:42:05'),
(18, 1, NULL, 'Processo 5233001-67.2025.8.09.0174 cadastrado', 'O processo 5233001-67.2025.8.09.0174 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-11 12:44:30'),
(19, 1, NULL, 'Processo 5202204-86.2025.8.09.0149 cadastrado', 'O processo 5202204-86.2025.8.09.0149 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-11 12:49:07'),
(20, 1, NULL, 'Processo 5995431-53.2025.8.09.0064 cadastrado', 'O processo 5995431-53.2025.8.09.0064 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-11 12:50:20'),
(21, 1, NULL, 'Processo 5106433-08.2023.8.09.0099 cadastrado', 'O processo 5106433-08.2023.8.09.0099 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-11 12:51:46'),
(22, 1, NULL, 'Processo 5725166-44.2024.8.09.0064 cadastrado', 'O processo 5725166-44.2024.8.09.0064 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-11 12:54:09'),
(23, 1, NULL, 'Processo 5745940-61.2025.8.09.0064 cadastrado', 'O processo 5745940-61.2025.8.09.0064 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-11 12:55:37'),
(24, 1, NULL, 'Processo 5980803-55.2025.8.09.0130 cadastrado', 'O processo 5980803-55.2025.8.09.0130 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-11 12:56:40'),
(25, 1, NULL, 'Processo 5017438-71.2020.8.09.0051 cadastrado', 'O processo 5017438-71.2020.8.09.0051 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-11 12:58:11'),
(26, 1, NULL, 'Processo 5292656-27.2026.8.09.0079 cadastrado', 'O processo 5292656-27.2026.8.09.0079 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-11 12:59:26'),
(27, 1, NULL, 'Processo 5220911-55.2024.8.09.0176 cadastrado', 'O processo 5220911-55.2024.8.09.0176 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-11 13:01:47'),
(28, 1, NULL, 'Processo 5949251-17.2025.8.09.0116 cadastrado', 'O processo 5949251-17.2025.8.09.0116 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-11 13:56:28'),
(29, 1, NULL, 'Processo 5366913-78.2024.8.09.0051 cadastrado', 'O processo 5366913-78.2024.8.09.0051 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-11 13:58:29'),
(30, 1, NULL, 'Processo 5423899-52.2024.8.09.0051 cadastrado', 'O processo 5423899-52.2024.8.09.0051 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-11 13:59:55'),
(31, 1, NULL, 'Processo 5829187-13.2024.8.09.0051 cadastrado', 'O processo 5829187-13.2024.8.09.0051 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-11 14:01:48'),
(32, 1, NULL, 'Processo 6145181-27.2024.8.09.0174 cadastrado', 'O processo 6145181-27.2024.8.09.0174 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-11 14:10:08'),
(33, 1, NULL, 'Processo 5283239-71.2025.8.09.0051 cadastrado', 'O processo 5283239-71.2025.8.09.0051 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-11 14:11:16'),
(34, 1, NULL, 'Processo 5340195-33.2025.8.09.0011 cadastrado', 'O processo 5340195-33.2025.8.09.0011 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-11 15:10:02'),
(35, 1, NULL, 'Processo 5497561-15.2025.8.09.0051 cadastrado', 'O processo 5497561-15.2025.8.09.0051 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-11 15:11:30'),
(36, 1, NULL, 'Processo 5554704-59.2025.8.09.0051 cadastrado', 'O processo 5554704-59.2025.8.09.0051 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-11 15:12:24'),
(37, 1, NULL, 'Processo 5563039-67.2025.8.09.0051 cadastrado', 'O processo 5563039-67.2025.8.09.0051 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-11 15:13:28'),
(38, 1, NULL, 'Processo 5024260-66.2026.8.09.0051 cadastrado', 'O processo 5024260-66.2026.8.09.0051 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-11 15:14:16'),
(39, 1, NULL, 'Processo 5089329-45.2026.8.09.0051 cadastrado', 'O processo 5089329-45.2026.8.09.0051 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-11 15:18:04'),
(40, 1, NULL, 'Processo 5147102-48.2026.8.09.0051 cadastrado', 'O processo 5147102-48.2026.8.09.0051 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-11 15:19:06'),
(41, 1, NULL, 'Processo 5144869-49.2024.8.09.0051 cadastrado', 'O processo 5144869-49.2024.8.09.0051 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-11 15:38:40'),
(42, 1, NULL, 'Processo 5429282-98.2022.8.09.0174 cadastrado', 'O processo 5429282-98.2022.8.09.0174 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-11 15:41:14'),
(43, 1, NULL, 'Processo 5915052-03.2024.8.09.0116 cadastrado', 'O processo 5915052-03.2024.8.09.0116 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-11 15:42:49'),
(44, 1, NULL, 'Processo 5292530-84.2026.8.09.0011 cadastrado', 'O processo 5292530-84.2026.8.09.0011 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-11 15:44:21'),
(45, 1, NULL, 'Processo 5536655-57.2023.8.09.0174 cadastrado', 'O processo 5536655-57.2023.8.09.0174 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-11 15:46:20'),
(46, 1, NULL, 'Processo 5310003-31.2024.8.09.0051 cadastrado', 'O processo 5310003-31.2024.8.09.0051 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-11 15:47:17'),
(47, 1, NULL, 'Processo 0000093-45.2025.5.18.0006 cadastrado', 'O processo 0000093-45.2025.5.18.0006 (TRT18) foi adicionado ao seu monitoramento.', 1, '2026-05-11 16:06:46'),
(48, 1, NULL, 'Processo 0000093-45.2025.5.18.0006 cadastrado', 'O processo 0000093-45.2025.5.18.0006 (TRT18) foi adicionado ao seu monitoramento.', 1, '2026-05-11 16:20:10'),
(49, 1, NULL, 'Processo 0001362-37.2025.5.18.0001 cadastrado', 'O processo 0001362-37.2025.5.18.0001 (TRT18) foi adicionado ao seu monitoramento.', 1, '2026-05-11 16:27:44'),
(50, 1, NULL, 'Processo 0002018-58.2025.5.18.0012 cadastrado', 'O processo 0002018-58.2025.5.18.0012 (TRT18) foi adicionado ao seu monitoramento.', 1, '2026-05-11 16:30:01');
INSERT INTO `novidades` (`id`, `userId`, `processoId`, `titulo`, `conteudo`, `lida`, `createdAt`) VALUES
(30001, 1, NULL, 'Processo 5407706-88.2026.8.09.0051 cadastrado', 'O processo 5407706-88.2026.8.09.0051 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-11 17:23:25'),
(30002, 1, NULL, 'Processo 5389036-07.2023.8.09.0051 cadastrado', 'O processo 5389036-07.2023.8.09.0051 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-11 17:35:15'),
(60001, 1, NULL, 'Processo 5365368-21.2026.8.09.0174 cadastrado', 'O processo 5365368-21.2026.8.09.0174 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-11 17:48:01'),
(90001, 1, NULL, 'Processo 5292656-27.2026.8.09.0079 cadastrado', 'O processo 5292656-27.2026.8.09.0079 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-14 19:15:06'),
(120001, 1, NULL, 'Processo 5292530-84.2026.8.09.0011 cadastrado', 'O processo 5292530-84.2026.8.09.0011 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-15 20:25:45'),
(150001, 1, NULL, 'Processo 0010386-08.2026.8.27.2700 cadastrado', 'O processo 0010386-08.2026.8.27.2700 (TJTO) foi adicionado ao seu monitoramento.', 1, '2026-05-18 01:19:56'),
(180001, 1, NULL, 'Processo 5365368-21.2026.8.09.0174 cadastrado', 'O processo 5365368-21.2026.8.09.0174 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-19 12:53:52'),
(210001, 1, NULL, 'Processo 5645405-08.2021.8.09.0051 cadastrado', 'O processo 5645405-08.2021.8.09.0051 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-24 17:04:40'),
(240001, 1, NULL, 'Processo 5468567-63.2026.8.09.0011 cadastrado', 'O processo 5468567-63.2026.8.09.0011 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-25 23:14:45'),
(270001, 1, NULL, 'Processo 5367115-21.2025.8.09.0051 cadastrado', 'O processo 5367115-21.2025.8.09.0051 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-26 21:32:21'),
(300001, 1, NULL, 'Processo 5940730-84.2025.8.09.0051 cadastrado', 'O processo 5940730-84.2025.8.09.0051 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-28 14:16:16'),
(330001, 1, NULL, 'Processo 5536655-57.2023.8.09.0174 cadastrado', 'O processo 5536655-57.2023.8.09.0174 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-29 19:52:40'),
(330002, 1, NULL, 'Processo 5303068-23.2026.8.09.0174 cadastrado', 'O processo 5303068-23.2026.8.09.0174 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-05-29 19:53:49'),
(360001, 1, NULL, 'Processo 5248885-83.2026.8.09.0051 cadastrado', 'O processo 5248885-83.2026.8.09.0051 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-06-01 13:53:59'),
(390001, 1, NULL, 'Processo 5407735-95.2026.8.09.0130 cadastrado', 'O processo 5407735-95.2026.8.09.0130 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-06-07 14:45:19'),
(420001, 1, NULL, 'Processo 0000964-05.2026.5.18.0018 cadastrado', 'O processo 0000964-05.2026.5.18.0018 (TRT18) foi adicionado ao seu monitoramento.', 1, '2026-06-08 13:29:10'),
(450001, 1, NULL, 'Processo 1002034-62.2025.4.01.3500 cadastrado', 'O processo 1002034-62.2025.4.01.3500 (TRF1) foi adicionado ao seu monitoramento.', 1, '2026-06-11 22:36:31'),
(480001, 1, NULL, 'Processo 6063041-37.2024.8.09.0011 cadastrado', 'O processo 6063041-37.2024.8.09.0011 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-06-15 21:11:04'),
(510001, 1, NULL, 'Processo 5606642-64.2023.8.09.0051 cadastrado', 'O processo 5606642-64.2023.8.09.0051 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-06-15 21:42:17'),
(540001, 1, NULL, 'Processo 5539206-09.2026.8.09.0011 cadastrado', 'O processo 5539206-09.2026.8.09.0011 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-06-16 13:05:08'),
(570001, 1, NULL, 'Processo 5860013-85.2025.8.09.0051 cadastrado', 'O processo 5860013-85.2025.8.09.0051 (TJGO) foi adicionado ao seu monitoramento.', 1, '2026-06-23 12:24:59'),
(600001, 1, NULL, 'Processo 5622706-47.2026.8.09.0051 cadastrado', 'O processo 5622706-47.2026.8.09.0051 (TJGO) foi adicionado ao seu monitoramento.', 0, '2026-07-08 03:17:50'),
(630001, 1, NULL, 'Processo 0000825-71.2024.8.27.2718 cadastrado', 'O processo 0000825-71.2024.8.27.2718 (TJTO) foi adicionado ao seu monitoramento.', 1, '2026-07-08 11:49:20'),
(660001, 1, NULL, 'Processo 5292656-27.2026.8.09.0079 cadastrado', 'O processo 5292656-27.2026.8.09.0079 (TJGO) foi adicionado ao seu monitoramento.', 0, '2026-07-08 14:24:28'),
(690001, 1, NULL, 'Processo 5624182-23.2026.8.09.0051 cadastrado', 'O processo 5624182-23.2026.8.09.0051 (TJGO) foi adicionado ao seu monitoramento.', 0, '2026-07-08 16:01:34');

SET FOREIGN_KEY_CHECKS = 1;
-- Dump concluído