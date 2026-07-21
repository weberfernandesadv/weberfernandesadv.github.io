ALTER TABLE `contratos` MODIFY COLUMN `tipoAcao` text;--> statement-breakpoint
ALTER TABLE `contratos` MODIFY COLUMN `tribunal` varchar(255);--> statement-breakpoint
ALTER TABLE `contratos` MODIFY COLUMN `faseProcessual` text;--> statement-breakpoint
ALTER TABLE `contratos` MODIFY COLUMN `valorTotal` varchar(64);--> statement-breakpoint
ALTER TABLE `contratos` MODIFY COLUMN `valorEntrada` varchar(64);--> statement-breakpoint
ALTER TABLE `contratos` MODIFY COLUMN `dataEntrada` varchar(10);--> statement-breakpoint
ALTER TABLE `contratos` MODIFY COLUMN `numParcelas` int;--> statement-breakpoint
ALTER TABLE `contratos` MODIFY COLUMN `valorParcela` varchar(64);--> statement-breakpoint
ALTER TABLE `contratos` MODIFY COLUMN `dataPrimeiraParcela` varchar(10);