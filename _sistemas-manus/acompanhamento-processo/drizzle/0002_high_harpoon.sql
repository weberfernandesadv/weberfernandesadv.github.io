ALTER TABLE `processos` ADD `dataLimite` date;--> statement-breakpoint
ALTER TABLE `processos` ADD `tipoManifestacao` enum('Recurso','Resposta','Apelação','Embargos de declaração','Autos conclusos','Conciliação','Outro');--> statement-breakpoint
ALTER TABLE `processos` ADD `cliente` varchar(255);--> statement-breakpoint
ALTER TABLE `processos` ADD `anotacao` text;--> statement-breakpoint
ALTER TABLE `processos` DROP COLUMN `descricao`;--> statement-breakpoint
ALTER TABLE `processos` DROP COLUMN `status`;