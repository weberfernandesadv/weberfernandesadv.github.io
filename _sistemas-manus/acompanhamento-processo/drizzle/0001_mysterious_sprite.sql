CREATE TABLE `novidades` (
	`id` int AUTO_INCREMENT NOT NULL,
	`userId` int NOT NULL,
	`processoId` int,
	`titulo` varchar(255) NOT NULL,
	`conteudo` text,
	`lida` boolean NOT NULL DEFAULT false,
	`createdAt` timestamp NOT NULL DEFAULT (now()),
	CONSTRAINT `novidades_id` PRIMARY KEY(`id`)
);
--> statement-breakpoint
CREATE TABLE `processos` (
	`id` int AUTO_INCREMENT NOT NULL,
	`userId` int NOT NULL,
	`numeroCnj` varchar(50) NOT NULL,
	`tribunal` varchar(30) NOT NULL,
	`descricao` text,
	`status` varchar(100),
	`ativo` boolean NOT NULL DEFAULT true,
	`createdAt` timestamp NOT NULL DEFAULT (now()),
	`updatedAt` timestamp NOT NULL DEFAULT (now()) ON UPDATE CURRENT_TIMESTAMP,
	CONSTRAINT `processos_id` PRIMARY KEY(`id`)
);
