CREATE TABLE `modelos_dinamicos` (
	`id` int AUTO_INCREMENT NOT NULL,
	`nome` varchar(255) NOT NULL,
	`slug` varchar(128) NOT NULL,
	`descricao` text,
	`fileKey` varchar(512) NOT NULL,
	`ativo` int NOT NULL DEFAULT 1,
	`criadoEm` timestamp NOT NULL DEFAULT (now()),
	CONSTRAINT `modelos_dinamicos_id` PRIMARY KEY(`id`),
	CONSTRAINT `modelos_dinamicos_slug_unique` UNIQUE(`slug`)
);
--> statement-breakpoint
CREATE TABLE `submissoes_modelo` (
	`id` int AUTO_INCREMENT NOT NULL,
	`modeloId` int NOT NULL,
	`nome` varchar(255) NOT NULL,
	`genero` varchar(64) NOT NULL,
	`estadoCivil` varchar(64) NOT NULL,
	`profissao` varchar(128) NOT NULL,
	`cpf` varchar(14) NOT NULL,
	`rg` varchar(20) NOT NULL,
	`naturalidade` varchar(128) NOT NULL,
	`nomePai` varchar(255) NOT NULL,
	`nomeMae` varchar(255) NOT NULL,
	`rua` varchar(255) NOT NULL,
	`quadra` varchar(64),
	`lote` varchar(64),
	`setor` varchar(128),
	`cidade` varchar(128) NOT NULL,
	`estado` varchar(64),
	`cep` varchar(9) NOT NULL,
	`dataAssinatura` varchar(10) NOT NULL,
	`downloadToken` varchar(64),
	`status` enum('pendente','gerada') NOT NULL DEFAULT 'pendente',
	`observacoes` text,
	`criadoEm` timestamp NOT NULL DEFAULT (now()),
	CONSTRAINT `submissoes_modelo_id` PRIMARY KEY(`id`)
);
