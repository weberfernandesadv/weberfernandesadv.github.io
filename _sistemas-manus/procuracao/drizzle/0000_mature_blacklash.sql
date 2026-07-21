CREATE TABLE `procuracoes` (
	`id` int AUTO_INCREMENT NOT NULL,
	`nome` varchar(255) NOT NULL,
	`genero` varchar(64) NOT NULL,
	`estadoCivil` varchar(64) NOT NULL,
	`profissao` varchar(128) NOT NULL,
	`cpf` varchar(14) NOT NULL,
	`naturalidade` varchar(128) NOT NULL,
	`filiacao` text NOT NULL,
	`rua` varchar(255) NOT NULL,
	`quadra` varchar(64),
	`lote` varchar(64),
	`cidade` varchar(128) NOT NULL,
	`cep` varchar(9) NOT NULL,
	`criadoEm` timestamp NOT NULL DEFAULT (now()),
	CONSTRAINT `procuracoes_id` PRIMARY KEY(`id`)
);
--> statement-breakpoint
CREATE TABLE `users` (
	`id` int AUTO_INCREMENT NOT NULL,
	`openId` varchar(64) NOT NULL,
	`name` text,
	`email` varchar(320),
	`loginMethod` varchar(64),
	`role` enum('user','admin') NOT NULL DEFAULT 'user',
	`createdAt` timestamp NOT NULL DEFAULT (now()),
	`updatedAt` timestamp NOT NULL DEFAULT (now()) ON UPDATE CURRENT_TIMESTAMP,
	`lastSignedIn` timestamp NOT NULL DEFAULT (now()),
	CONSTRAINT `users_id` PRIMARY KEY(`id`),
	CONSTRAINT `users_openId_unique` UNIQUE(`openId`)
);
