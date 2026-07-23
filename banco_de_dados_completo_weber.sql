-- ============================================================
-- BANCO DE DADOS UNIFICADO DO ESCRITÓRIO WEBER FERNANDES
-- Contém: Procurações, Contratos, Processos, Pagamentos e Clientes
-- ============================================================

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;
SET SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO';

-- --- MÓDULO PROCURAÇÕES E CONTRATOS ---
-- Weber ProcuraÃ§Ã£o â€” Dump completo do banco de dados
-- Gerado em: $(date)
-- Servidor: TiDB (MySQL-compatible)
-- Encoding: UTF-8

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
SET time_zone='+00:00';

-- MySQL dump 10.13  Distrib 8.0.45, for Linux (x86_64)
--
-- Host: gateway04.us-east-1.prod.aws.tidbcloud.com    Database: 9HxVMH7VVkjkpEJXq4mpPC
-- ------------------------------------------------------
-- Server version	8.0.11-TiDB-v8.5.3-serverless

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `contratos`
--

DROP TABLE IF EXISTS `contratos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contratos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `genero` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estadoCivil` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `profissao` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cpf` varchar(14) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rg` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `naturalidade` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nomePai` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nomeMae` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rua` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quadra` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lote` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `setor` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cidade` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cep` varchar(9) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipoAcao` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tribunal` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `faseProcessual` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `valorTotal` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `valorEntrada` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dataEntrada` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `numParcelas` int DEFAULT NULL,
  `valorParcela` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dataPrimeiraParcela` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dataContrato` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `criadoEm` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('pendente','gerada') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pendente',
  `downloadToken` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `observacoes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tipoContrato` enum('valor_fixo','entrada_exito','exito_percentual') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'valor_fixo',
  `valorTotalExtenso` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `valorEntradaExito` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `valorEntradaExitoExtenso` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `formaPagamentoEntrada` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `percentualExito` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `compensacao` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `percentualExitoPuro` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `criterioProveito` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `percentualExitoPuroExtenso` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `emailContratante` varchar(320) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefoneContratante` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dataNascimentoContratante` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `numero` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=1020001;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contratos`
--

LOCK TABLES `contratos` WRITE;
/*!40000 ALTER TABLE `contratos` DISABLE KEYS */;
INSERT INTO `contratos` (`id`, `nome`, `genero`, `estadoCivil`, `profissao`, `cpf`, `rg`, `naturalidade`, `nomePai`, `nomeMae`, `rua`, `quadra`, `lote`, `setor`, `cidade`, `estado`, `cep`, `tipoAcao`, `tribunal`, `faseProcessual`, `valorTotal`, `valorEntrada`, `dataEntrada`, `numParcelas`, `valorParcela`, `dataPrimeiraParcela`, `dataContrato`, `criadoEm`, `status`, `downloadToken`, `observacoes`, `tipoContrato`, `valorTotalExtenso`, `valorEntradaExito`, `valorEntradaExitoExtenso`, `formaPagamentoEntrada`, `percentualExito`, `compensacao`, `percentualExitoPuro`, `criterioProveito`, `percentualExitoPuroExtenso`, `emailContratante`, `telefoneContratante`, `dataNascimentoContratante`, `numero`) VALUES (240002,'JOÃƒO LUIS CORREA BATISTA','brasileiro','divorciado(a)','Jornalista/Professor','434.758.251-04','1423424','GOIÃ‚NIA-GO','Benedito Neder Batista','Jocilia de Jesus Correa da Costa','ConsolaÃ§Ã£o','','','CIDADE JARDIM','GOIÃ‚NIA','GO','74425-535',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'15/06/2026','2026-06-15 20:26:37','pendente','a365f38c600b4139946071d4a7749ef1',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(270001,'ELISA DOS SANTOS ARAUJO','brasileira','solteiro(a)','ESTUDANTE','031.696.431-00','03169643100','GoiÃ¢nia-GO','ELISEU LOPES DE ARAÃšJO','ELAINE FRANCISCA DOS SANTOS','Paulo Bregaro','1','3','Maria LourenÃ§a','GoiÃ¢nia','GO','74595-050',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'26/06/2026','2026-06-26 17:12:09','pendente','24c13d276fd54ce4acab30084bbaae25',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(300001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-06-29 22:33:29','pendente','0e4e02dfb03441b4b95240701d960daa',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(300002,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-06-29 22:34:16','pendente','4fcc724f037841829e7a22eba6d2269b',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(330001,'FRANCISCA MARIA DOS SANTOS BALDEZ','brasileira','solteiro(a)','TEC enfermagem','885.599.631-20','3625954 DGPC GO','Parnarama-MA','Orlando Baldez','Doracy dos santos Baldez','Avenida Manchester condomÃ­nio residencial metrÃ³poles bloco damasco apto 204','00','00','Jardim novo mundo','GoiÃ¢nia','GO','74702-755','Reconhecimento de uniÃ£o estÃ¡vel pÃ³s morten','tjgo','conhecimento','1500,00','00','07/08/2026',2,'750,00','07/09/2026','07/06/2026','2026-07-07 13:54:46','gerada','d5aaa0116b514ed1be6abd6d2bccbffa',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(360001,'MARIA BOMFIM LOPES DE OLIVEIRA','brasileira','casado(a)','DomÃ©stica','583.779.801-34','2068936','Coribe-BA','Edmar Moreira Lopes','Mailde Bomfim Lopes','Rua cumprida','Qd 2b','Lote 04','Vila SÃ£o Domingos triunfo 1','Goianira','GO','75369-198','DivÃ³rcio','TJGO','Conhecimento','6,000','1,000','06/07/2026',10,'500','06/08/2026','07/07/2026','2026-07-07 20:37:44','gerada','36d3cba3b35745ca87fc97a918addc12',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(360002,'SELMON RODRIGUES BATISTA','brasileiro','casado(a)','AutÃ´nomo','991.013.351-20','4324588','Ponte Alta do Norte-TO','SÃ©rgio Alves Rodrigues','Selma dos Reis Alves Batista','Avenida MangalÃ´    n 1571','','','Morada do Sol','GoiÃ¢nia','GO','74475-115','RescisÃ£o de contrato imobiliÃ¡rio','TJGO','Conhecimento','3000,00','1000,00','05/07/2026',5,'600','05/08/2026','07/07/2026','2026-07-07 22:26:40','gerada','4810666a7c6842a18556f83555faa854',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(390001,'NÃGILA BIANCA ALVES MARIANO','brasileira','solteiro(a)','Limpeza domÃ©stica','702.016.861-20','6086920','GoiÃ¢nia-GO','Wellington EustÃ¡quio Mariano','Eliane Alves de Souza','Rua b','13','2','TremendÃ£o','GoiÃ¢nia','GO','74475-020','Guarda','TJGO','Conhecimento','6000','500','05/06/2026',13,'400','05/07/2026','08/06/2028','2026-07-08 12:53:14','gerada','c0f12b661a5642839c82e010f8113388',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(420001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-08 13:08:55','pendente','0ef856b864514dc5960feeb687b45b2a',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(450001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-08 13:26:11','pendente','8aad8990-4b6c-4ad4-99dd-9d669e614263',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(450002,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-08 13:26:19','pendente','4ce6b27c-ce09-4408-b8d6-35bae697070d',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(480001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-08 16:23:53','pendente','f1cc8a8d-1f55-4950-9834-3ef7a0f53773',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(480002,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-08 16:28:05','pendente','c73c0390-6200-4a80-a495-4da84dc412e0',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(480003,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-08 16:49:56','pendente','8bc81ad8-176c-4df1-868d-75ea3b8d3121',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(480004,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-08 16:52:10','pendente','223ed37c-300b-4b6b-a485-20e55a1eef78',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(480005,'WEBER FERNANDES PEREIRA','brasileiro','casado(a)','ADV','888.950.123-13','3741411','SENADOR CANEDO-GO','WEBER FERNANDES PEREIRA','WEBER FERNANDES PEREIRA','RUA F9','1','3','Residencial Hebrom','SENADOR CANEDO','GO','75257-482','EXCECUÃ‡ÃƒO','TJGO','CONHECIMENTO',NULL,NULL,NULL,NULL,NULL,NULL,'08/07/2026','2026-07-08 16:59:48','gerada','bbec3afd-f7b5-43da-9d12-754c8832b7af',NULL,'exito_percentual',NULL,NULL,NULL,NULL,NULL,NULL,'30','valor da condenaÃ§Ã£o lÃ­quida',NULL,NULL,NULL,NULL,NULL),(480006,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-08 17:17:06','pendente','ce5aef7c-0080-423c-869b-639fe3d74edd',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(510001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-08 19:53:51','pendente','b8a627ee-2e73-416f-a502-c17c8278c91b',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(540001,'WEBER FERNANDES PEREIRA','brasileiro','casado(a)','Adv','889.221.455-33','4556662','SENADOR CANEDO-GO','WEBER FERNANDES PEREIRA','WEBER FERNANDES PEREIRA','paulo breg','1','3','Residencial Hebrom','SENADOR CANEDO','GO','75257-482','aÃ§Ã£o de cobranÃ§a','TJGO','fase de conhecimento',NULL,NULL,NULL,NULL,NULL,NULL,'08/07/2026','2026-07-08 20:17:50','gerada','eaa745a3-4884-4a93-b1cb-67e08efe2f5d',NULL,'exito_percentual',NULL,NULL,NULL,NULL,NULL,NULL,'30','valor condenaÃ§Ã£o',NULL,NULL,NULL,NULL,NULL),(540002,'WEBER FERNANDES PEREIRA','brasileiro','casado(a)','adv','777.888.555-56','8765454','SENADOR CANEDO-PA','Prof. Weber','Prof. Weber','ruaaa','1','3','Residencial Hebrom','SENADOR CANEDO','GO','75257-482','AÃ‡ÃƒO DE COBRANÃ‡A','tjgo','fase de conhecimento',NULL,NULL,NULL,NULL,NULL,NULL,'08/07/2026','2026-07-08 20:24:08','gerada','0648e61c-9090-4da1-a018-72b9ec696fc3',NULL,'entrada_exito',NULL,'1500','um mil e quinhentos reais','Ã€ VISTA','20','NÃƒO',NULL,'25%',NULL,NULL,NULL,NULL,NULL),(540003,'WEBER FERNANDES PEREIRA','brasileiro','casado(a)','ADV','121.321.545-45','1212131','SENADOR CANEDO-ES','DIEGO SANTOS','MARIA SANTOS','PAULO BREGARO','1','3','Residencial Hebrom','SENADOR CANEDO','GO','75257-482','AÃ‡ÃƒO DE COBRANÃ‡A','TJGO','AUDIENCIAS','3000','1000','08/07/2026',2,NULL,'10/07/2026','08/07/2026','2026-07-08 20:31:41','gerada','4408ad6d-7054-4c48-81c4-7cf2322f67cf',NULL,'valor_fixo','TRES MIL REAIS',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(540004,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-08 20:52:34','pendente','a658e280-fdc6-4032-97e9-ca9d67ad663c',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(540005,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-08 20:56:34','pendente','53bc07e7-cb39-4844-a171-16e2e7e272f2',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(540006,'wfkjeojfaoewo','brasileiro','solteiro(a)','orif','000.000.000-00','12346485','goiÃ¢nia-GO','elvis jikjo','Alzira xy','fkjeoi','efe','5','finso','GoiÃ¢nia','GO','74000-000','EXECUÃ‡ÃƒO','TJGO','INICIAL','3000,00','1000,00','08/07/2026',8,NULL,'08/08/2026','08/07/2026','2026-07-08 21:12:44','gerada','c20d1976-2c6c-4041-9992-65e62a25116c',NULL,'valor_fixo','TrÃªs mil reais',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(570001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-08 21:53:48','pendente','d84ca805-f5c6-43ec-aaa3-03351d766a0f',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(600001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-08 22:05:39','pendente','8bce0078-4b45-4d38-9521-e141dc4bd916',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(630001,'chica chica','brasileiro','solteiro(a)','feageafe','000.000.000-00','1234567','GoiÃ¢nia-GO','faeafeed dfeee','frterfe gfefe','rua x','1','2','finsocial','GoiÃ¢nia','GO','74000-000','execuÃ§Ã£o','tjgo','conhecimento',NULL,NULL,NULL,NULL,NULL,NULL,'08/07/2026','2026-07-08 22:06:49','gerada','443c5a48-f215-4221-94b5-465cf4df51cc',NULL,'exito_percentual',NULL,NULL,NULL,NULL,NULL,NULL,'30','valor da condenaÃ§Ã£o',NULL,NULL,NULL,NULL,NULL),(630002,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-08 22:08:51','pendente','b8e442f4-9859-48a1-9e13-dac3161fa91c',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(630003,'FRANCISCA MARIA DA SILVA','feminino','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia/GO','JoÃ£o da Silva','Maria da Silva','Rua das Flores, 123, Apto 1','','','Setor Central','GoiÃ¢nia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/07/2026','2026-07-08 22:09:17','pendente','f7c22471-d48a-40f8-b4e1-92b7315c5558',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(660001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-08 22:12:30','pendente','701e513a-263c-4d15-872c-6ca80197eae2',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(660002,'GFADAERF','brasileiro','solteiro(a)','FAEFAEW','000.000.000-00','1234567','GOIÃ‚NIA-GO','FAEAFEFAE EDFE','FADTEFE FRFES','RUA  X','2','5','FINSOC','GOIÃ‚NIA','GO','74000-000','EXECUÃ‡ÃƒO','TJGO','CONHECIMENTO','3000','1000','08/07/2026',8,NULL,'08/08/2026','08/07/2026','2026-07-08 22:17:05','gerada','c79b2346-07f7-4346-b63c-c894fb4c3a3a',NULL,'valor_fixo','TrÃªs mil Reais',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(660003,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','alimentos','tjgo','conhecimento','3000','1000','08/07/2026',8,NULL,'08/08/2026','08/06/2026','2026-07-08 22:58:11','gerada','0bfb43fb-a0b5-4026-a556-0995151a9ad7',NULL,'valor_fixo','trÃªs mil reais',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(660004,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-08 23:24:38','pendente','ed72be65-e184-443a-a680-855a1844c29a',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(660005,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-08 23:25:25','pendente','63d131ce-cd45-438e-b459-2dc47bb3dd64',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(690001,'maria birtis','brasileiro','solteiro(a)','professor','000.000.000-00','1234567','GoiÃ¢nia-GO','Evo few','few evo','rua x','01','02','cas','goiÃ¢nia','GO','74000-000','execuÃ§Ã£o','tjgo','conhecimento','3000','1000','08/07/2026',8,NULL,'08/08/2026','08/07/2026','2026-07-09 02:22:47','gerada','544290d0-a456-4c37-be65-5569d9c6493b',NULL,'valor_fixo','trÃªs mil reais',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(690002,'MARIA DA SILVA TESTE','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores',NULL,NULL,'Setor Central','GoiÃ¢nia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/07/2026','2026-07-09 02:28:05','pendente','5b698409-0574-4e4f-a66b-9d457422c272',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(690003,'chica mari','brasileiro','solteiro(a)','coman','000.000.000-00','1234567','GoiÃ¢nia-GO','chico j','j chica','rua x','01','02','cent','GoiÃ¢nia','GO','74000-000','execuÃ§Ã£o','tjgo','citaÃ§Ã£o','4000','1000','08/07/2026',10,NULL,'08/08/2026','08/07/2026','2026-07-09 02:34:14','gerada','00a5f422-bde2-4828-8fc4-2f749c7e88db',NULL,'valor_fixo','quatro mil reais',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(690004,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-09 02:41:44','pendente','81b51658-689d-4a75-8151-04021d94c531',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(690005,'CHICA MARIA TESTE','brasileira','solteira','professora','111.222.333-44','9876543','GoiÃ¢nia-GO','JosÃ© da Silva','Maria da Silva','Rua das AcÃ¡cias',NULL,NULL,'Setor Bueno','GoiÃ¢nia','GO','74000-100',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/07/2026','2026-07-09 02:42:18','pendente','986b7527-8649-4ae6-8b6a-dc5489089ca0',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(690006,'CHICA MARIA TESTE','brasileira','solteira','professora','111.222.333-44','9876543','GoiÃ¢nia-GO','JosÃ© da Silva','Maria da Silva','Rua das AcÃ¡cias, 456',NULL,NULL,'Setor Bueno','GoiÃ¢nia','GO','74000100','aÃ§Ã£o de divÃ³rcio',NULL,'fase de conhecimento e recursal','5.000,00','2.000,00',NULL,NULL,'1.000,00',NULL,'08/07/2026','2026-07-09 02:45:13','gerada','test-token-1783565113309',NULL,'valor_fixo','cinco mil reais',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(690007,'CHICA MARIA TESTE','brasileira','solteira','professora','111.222.333-44','9876543','GoiÃ¢nia-GO','JosÃ© da Silva','Maria da Silva','Rua das AcÃ¡cias, 456',NULL,NULL,'Setor Bueno','GoiÃ¢nia','GO','74000100','aÃ§Ã£o de divÃ³rcio',NULL,'fase de conhecimento e recursal','5.000,00','2.000,00',NULL,NULL,'1.000,00',NULL,'08/07/2026','2026-07-09 02:45:32','gerada','test-token-1783565132319',NULL,'valor_fixo','cinco mil reais',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(690008,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','execuÃ§Ã£o','TJGO','conhecimento','3000','1000','08/07/2026',5,NULL,'','08/06/2026','2026-07-09 02:45:55','gerada','9193b82a-7c9a-4e31-a38d-ff0a98b82bff',NULL,'valor_fixo','trÃªs mil reais',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(720001,'JFEOJEO','brasileiro','solteiro(a)','FAEFAE','000.000.000-00','1234567','GoiÃ¢nia-GO','j sleofjoe','sjojoe jeofe','rua x','2','23','fjoejfapewo','GoiÃ¢nia','GO','74000-000','exec','tjgo','conhec','5000','2000','08/07/2026',1,NULL,'08/08/2026','08/07/2026','2026-07-09 02:55:59','gerada','d0ee8ae0-984f-4ecd-9c42-a7cf045723e6',NULL,'valor_fixo','cinco mil reais',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(720002,'gfare grfaewr','brasileiro','solteiro(a)','feae','000.000.000-00','11111111','goiÃ‚NIA-GO','afaev rfgr','hrgrb grgrs','av. 5','1','2','afÃ§j eoe','GoiÃ¢nia','GO','74000-000','exec','tjgo','adu',NULL,NULL,NULL,NULL,NULL,NULL,'09/07/2026','2026-07-09 03:01:51','gerada','ea537b3e-5848-4031-b848-0a5ab813c2b7',NULL,'exito_percentual',NULL,NULL,NULL,NULL,NULL,NULL,'30','montante recebido',NULL,NULL,NULL,NULL,NULL),(720003,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-09 03:13:37','pendente','9b44b6fd-7d32-4a14-b404-576812a0098c',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(720004,'MARIA TESTE SILVA','brasileira','solteira','professora','111.222.333-44','9876543','GoiÃ¢nia-GO','JosÃ© da Silva','Maria da Silva','Rua das AcÃ¡cias, 456',NULL,NULL,'Setor Bueno','GoiÃ¢nia','GO','74000100','aÃ§Ã£o trabalhista','TRT 18Âª RegiÃ£o','fase de conhecimento',NULL,NULL,NULL,NULL,NULL,NULL,'09/07/2026','2026-07-09 03:13:58','pendente','test-exito-perc-1783566837859',NULL,'exito_percentual',NULL,NULL,NULL,NULL,NULL,NULL,'30','valor da condenaÃ§Ã£o lÃ­quida','trinta',NULL,NULL,NULL,NULL),(720005,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-09 03:14:50','pendente','c2d1d612-ddd8-4bf5-a041-b177eddc5057',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(750001,'SELMON RODRIGUES BATISTA','brasileiro','casado(a)','AutÃ´nomo','991.013.351-20','4324588','Ponte Alta do Norte-TO','SÃ©rgio Alves Rodrigues ','Selma dos Reis Alves Batista','Avenida MangalÃ´, 1571','','','Morada do Sol','GoiÃ¢nia','GO','74475-115','Distrato ImobiliÃ¡rio','TJGO','Conhecimento',NULL,NULL,NULL,NULL,NULL,NULL,'10/07/2026','2026-07-10 11:35:28','gerada','69f71547-2a70-4feb-95b0-2c554788b4b2',NULL,'exito_percentual',NULL,NULL,NULL,NULL,NULL,NULL,'30','Valor da condenaÃ§Ã£o','Trinta',NULL,NULL,NULL,NULL),(780001,'feafd afre','brasileiro','solteiro(a)','faefae','000.000.000-00','1234564567','GoiÃ¢nia-GO','grfwefs','fejlkfaje','rua x','1','2','vila finsocial','GoiÃ¢nia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'10/07/2026','2026-07-10 12:28:04','pendente','aeec137d-0cf8-4453-b347-6072d948e92f',NULL,'exito_percentual',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(810001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-10 12:46:28','pendente','19e6949c-e03b-46fe-8b20-b25f516c342f',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(840001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-10 12:48:29','pendente','a725812d-f03c-4ec2-ac35-fea541f79576',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(870001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-10 12:58:58','pendente','d71a4a19-6ed4-4b20-a917-3e88daa44f5a',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(900001,'Carlos Eduardo MendonÃ§a Alves','brasileiro','casado(a)','Engenheiro Civil','543.210.987-65','4567890','GoiÃ¢nia-GO','JosÃ© MendonÃ§a Alves','Ana Paula MendonÃ§a','Avenida T-63','Q-15','L-8','Setor Bueno','GoiÃ¢nia','GO','74230-030',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'10/07/2026','2026-07-10 13:04:10','pendente','da52a1fb-d66a-4617-b664-3cf94256b85f',NULL,'exito_percentual',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'carlos.mendonca@email.com','(62) 99876-5432','15/04/1985','1200'),(930001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-10 13:06:25','pendente','0c390cdf-a396-4bc6-bf99-6038284ed59f',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(960001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-10 13:53:11','pendente','03380167-4393-4cfb-a221-17ff7f56e90f',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(990001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-10 13:58:34','pendente','7646f55a-3b0d-4701-bed4-06197f33d6c7',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `contratos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-13 12:38:20

-- MySQL dump 10.13  Distrib 8.0.45, for Linux (x86_64)
--
-- Host: gateway04.us-east-1.prod.aws.tidbcloud.com    Database: 9HxVMH7VVkjkpEJXq4mpPC
-- ------------------------------------------------------
-- Server version	8.0.11-TiDB-v8.5.3-serverless

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `declaracoes`
--

DROP TABLE IF EXISTS `declaracoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `declaracoes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `genero` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estadoCivil` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `profissao` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cpf` varchar(14) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rg` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `naturalidade` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nomePai` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nomeMae` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rua` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quadra` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lote` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `setor` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cidade` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cep` varchar(9) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dataDeclaracao` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `criadoEm` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('pendente','gerada') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pendente',
  `downloadToken` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `observacoes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `numero` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=750001;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `declaracoes`
--

LOCK TABLES `declaracoes` WRITE;
/*!40000 ALTER TABLE `declaracoes` DISABLE KEYS */;
INSERT INTO `declaracoes` (`id`, `nome`, `genero`, `estadoCivil`, `profissao`, `cpf`, `rg`, `naturalidade`, `nomePai`, `nomeMae`, `rua`, `quadra`, `lote`, `setor`, `cidade`, `estado`, `cep`, `dataDeclaracao`, `criadoEm`, `status`, `downloadToken`, `observacoes`, `numero`) VALUES (1,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-06-09 01:37:22','gerada','f52dd2fb52394be386f907c7a2310a5d',NULL,NULL),(2,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-06-09 01:37:22','pendente','2388e1a42aa745ab891919a3f1963e3a',NULL,NULL),(3,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-06-09 01:37:31','pendente','0582a27505604930a3214802c5ce220e',NULL,NULL),(4,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-06-09 01:37:31','pendente','0e88b9c9d0664ae1a40960d5a3eeb9b8',NULL,NULL),(5,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-06-09 01:38:22','pendente','e5e6e194f88847d7a0f0a297bcae9292',NULL,NULL),(30001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-06-09 02:13:24','pendente','3c6329cfa72c4230a67d966ff1339502',NULL,NULL),(30002,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-06-09 02:14:43','pendente','476f048acdc64f77ab237d163c3426b1',NULL,NULL),(30003,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-06-09 02:29:11','pendente','7887ba434a3e465c8495b8be97a5c67f',NULL,NULL),(30004,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-06-09 02:31:04','pendente','6dbaf6b2e0b84cdd8c2b82fa113bf1d0',NULL,NULL),(60001,'FADAEFA','brasileiro','casado(a)','professor','111.111.111-11','13213216','goiÃ¢nia','fjjoefoe','jfoeiphgeopi','x10','de','13','fajfeiofeof','goiÃ¢nia','go','74473-010','08/06/2026','2026-06-09 02:51:12','pendente','38257997ae1d40cc892d0d89eb9fc862',NULL,NULL),(90001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-06-09 03:43:41','pendente','6b102805189e4b3b949f38e0fa25647f',NULL,NULL),(90002,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-06-09 03:43:55','pendente','c4d8d66544354cf390d5a5a16c8c8f8b',NULL,NULL),(90003,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-06-09 03:44:30','pendente','27bbcd575993468d9fdb74de9dddfb34',NULL,NULL),(120001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-06-15 15:08:14','pendente','b9fbb0353b3844019b56367533ed6afe',NULL,NULL),(120002,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-06-15 15:08:25','pendente','ad97a033108b4433a2c5a7707876f254',NULL,NULL),(120003,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-06-15 15:16:58','pendente','cea320b0d52b414bbefa1ed1337f0414',NULL,NULL),(120004,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-06-15 15:17:06','pendente','9e483bc55aae4dd196acc24b416c22f5',NULL,NULL),(120005,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-06-15 15:18:20','pendente','f18e292c056a41f393c9a89ad43201da',NULL,NULL),(120006,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-06-15 15:18:28','pendente','ea62ee4684cc42c6b684135e1b769ccf',NULL,NULL),(120007,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-06-15 15:21:37','pendente','59c287783bdf463d87deb4543929161e',NULL,NULL),(120008,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-06-15 16:04:33','pendente','92e057a422cc4d9a84ff95ed325ee48d',NULL,NULL),(120009,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-06-15 16:55:15','pendente','38a1a804a8eb418ba6e5edc76ed2fdcf',NULL,NULL),(120010,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-06-15 16:59:06','pendente','df093735c53c41d2aa1dfae7b970b9f5',NULL,NULL),(150001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-06-29 22:33:29','pendente','5c37f305fccc4243b84a0f201bb8ef6f',NULL,NULL),(150002,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-06-29 22:34:16','pendente','408bd9e4dfeb42eca1a7b4a572e85701',NULL,NULL),(180001,'FRANCISCA MARIA DOS SANTOS BALDEZ','brasileira','solteiro(a)','TEC.enfermagem','885.599.631-20','3625954   DGPC','Parnarama-MA','Orlando Baldez','Doracy dos santos Baldez','Avenida Manchester condomÃ­nio residencial metrÃ³poles bloco damasco apto 204','00','00','Jardim novo mundo','GoiÃ¢nia','GO','74702-755','07/06/2026','2026-07-07 13:45:55','gerada','77aa5c3a11ec4c0bb3acdc819f31a81f',NULL,NULL),(210001,'ELISA DOS SANTOS ARAÃšJO','brasileira','solteiro(a)','ESTUDANTE','031.696.431-00','03169643100','GoiÃ¢nia-GO','ELISEU LOPES DE ARAÃšJO','ELAINE FRANCISCA DOS SANTOS','RUA PAULO BREGARO','1','3','MARIA LOURENÃ‡A','GoiÃ¢nia','GO','74595-050','07/07/2026','2026-07-07 18:53:30','gerada','0838313296d54ffe9fd6746a9498d87c',NULL,NULL),(240001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-07-08 13:08:55','pendente','08291e99b97d4841b2f6c92d5fbbddfa',NULL,NULL),(270001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-07-08 13:26:11','pendente','82983c4c-31d6-4bf0-84e1-4892728cdc42',NULL,NULL),(270002,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-07-08 13:26:19','pendente','f4ef5242-a98d-447d-aade-3e70d3ac13ee',NULL,NULL),(300001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-07-08 16:23:53','pendente','9f7e4582-1de8-40d7-951f-bdb700ee1e43',NULL,NULL),(300002,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-07-08 16:28:05','pendente','2527a43e-d884-43d7-98bf-35465fb39c9e',NULL,NULL),(300003,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-07-08 16:49:56','pendente','ae852369-8d2e-46cb-ad0f-0fb33a649e6a',NULL,NULL),(300004,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-07-08 16:52:10','pendente','e7134074-e426-4643-8ad8-5e19a9a415ca',NULL,NULL),(300005,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-07-08 17:17:07','pendente','35f1260b-6d34-45c4-9f4f-e04644e82281',NULL,NULL),(330001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-07-08 19:53:52','pendente','49700b16-8515-48b7-ad69-6b68ea833691',NULL,NULL),(360001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-07-08 20:52:35','pendente','232d3427-68f0-4419-bf07-895f5b5cbeeb',NULL,NULL),(360002,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-07-08 20:56:34','pendente','0dbf20f3-cd16-4ff1-a291-585b1e2a6bb1',NULL,NULL),(390001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-07-08 21:53:49','pendente','91842956-cd66-4889-9c5b-4bdd0efe2017',NULL,NULL),(420001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-07-08 22:05:39','pendente','b415e023-b743-434c-a324-4ac3c1f2e2d0',NULL,NULL),(450001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-07-08 22:08:51','pendente','55448f5f-e212-489f-b0c9-5392867a3ec0',NULL,NULL),(480001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-07-08 22:12:30','pendente','2105b0bf-dece-442b-814f-e22ede83cb11',NULL,NULL),(480002,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-07-08 22:58:11','pendente','54af11b4-db03-4c35-8808-662c38768e7e',NULL,NULL),(480003,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-07-08 23:24:38','pendente','6ca9e884-b80b-41b3-bada-1897c13c8064',NULL,NULL),(480004,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-07-08 23:25:25','pendente','66a9181c-3518-4b5d-9b4a-2e389d98c5df',NULL,NULL),(510001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-07-09 02:41:44','pendente','fb785989-6f4c-4213-ba6e-0d1f0ebb697c',NULL,NULL),(510002,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-07-09 02:45:55','pendente','bb383277-4858-41e9-bf9c-67b0655d185a',NULL,NULL),(540001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-07-09 03:13:37','pendente','f490f9da-5a33-4c32-8e1c-594a2728e897',NULL,NULL),(540002,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-07-09 03:14:50','pendente','9152efac-1dba-4dda-b73e-c39bd5e131f9',NULL,NULL),(570001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-07-10 12:46:28','pendente','55e1c8ca-6fe2-488d-a2af-b4e155ea81b0',NULL,NULL),(600001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-07-10 12:48:29','pendente','2ced8043-bf1d-434e-b98c-48c0e8eaa160',NULL,NULL),(630001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-07-10 12:58:58','pendente','fa0d78f4-cd11-4210-a620-73e5cfadf0d7',NULL,NULL),(660001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-07-10 13:06:25','pendente','2f0b733d-43ac-4692-88c9-396b4501c537',NULL,NULL),(690001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-07-10 13:53:11','pendente','5b1566e5-510a-498e-adcc-be9744fe7750',NULL,NULL),(720001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','08/06/2026','2026-07-10 13:58:35','pendente','2bd17c23-e98a-48dc-9bd1-4ee188cf39b8',NULL,NULL);
/*!40000 ALTER TABLE `declaracoes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-13 12:38:20

-- MySQL dump 10.13  Distrib 8.0.45, for Linux (x86_64)
--
-- Host: gateway04.us-east-1.prod.aws.tidbcloud.com    Database: 9HxVMH7VVkjkpEJXq4mpPC
-- ------------------------------------------------------
-- Server version	8.0.11-TiDB-v8.5.3-serverless

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `modelos_dinamicos`
--

DROP TABLE IF EXISTS `modelos_dinamicos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `modelos_dinamicos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descricao` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fileKey` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ativo` int NOT NULL DEFAULT '1',
  `criadoEm` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) ,
  UNIQUE KEY `modelos_dinamicos_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modelos_dinamicos`
--

LOCK TABLES `modelos_dinamicos` WRITE;
/*!40000 ALTER TABLE `modelos_dinamicos` DISABLE KEYS */;
/*!40000 ALTER TABLE `modelos_dinamicos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-13 12:38:20

-- MySQL dump 10.13  Distrib 8.0.45, for Linux (x86_64)
--
-- Host: gateway04.us-east-1.prod.aws.tidbcloud.com    Database: 9HxVMH7VVkjkpEJXq4mpPC
-- ------------------------------------------------------
-- Server version	8.0.11-TiDB-v8.5.3-serverless

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `procuracoes`
--

DROP TABLE IF EXISTS `procuracoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `procuracoes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `genero` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estadoCivil` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `profissao` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cpf` varchar(14) COLLATE utf8mb4_unicode_ci NOT NULL,
  `naturalidade` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `filiacao` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `rua` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quadra` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lote` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cidade` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cep` varchar(9) COLLATE utf8mb4_unicode_ci NOT NULL,
  `criadoEm` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('pendente','gerada') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pendente',
  `downloadToken` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `observacoes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `numero` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `setor` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dataAssinatura` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rg` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `data_nascimento` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefone` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=1020001;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `procuracoes`
--

LOCK TABLES `procuracoes` WRITE;
/*!40000 ALTER TABLE `procuracoes` DISABLE KEYS */;
INSERT INTO `procuracoes` (`id`, `nome`, `genero`, `estadoCivil`, `profissao`, `cpf`, `naturalidade`, `filiacao`, `rua`, `quadra`, `lote`, `cidade`, `cep`, `criadoEm`, `status`, `downloadToken`, `observacoes`, `numero`, `setor`, `estado`, `dataAssinatura`, `rg`, `data_nascimento`, `email`, `telefone`) VALUES (1,'WEBER FERNANDES PEREIRA','brasileiro','casado(a)','Porte','889.501.231-34','GoiÃ¢nia','Alzira Maria','Av. Adriano Auad, 00, Q. 02, L. 02','10','6','SENADOR CANEDO','75257-482','2026-05-14 21:16:09','pendente',NULL,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(30001,'WEBER FERNANDES PEREIRA','brasileiro','viÃºvo(a)','Porte','889.501.231-34','GoiÃ¢nia','Alzira Maria','Av. Adriano Auad, 00, Q. 02, L. 02','10','6','SENADOR CANEDO','75257-482','2026-05-14 21:28:39','pendente',NULL,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(60001,'LEONILDO BRITO OLIVEIRA','brasileiro','solteiro(a)','Professor','019.434.441-02','MarabÃ¡ Pa','Aurenides da Silva Brito e Gelson Jesus de Oliveira','Avenida Santa Terezinha','01','7/8','Aparecida de GoiÃ¢nia','74948-731','2026-05-14 21:37:37','pendente',NULL,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(90001,'WEBER FERNANDES PEREIRA','brasileiro','solteiro(a)','professor','889.501.231-34','GoiÃ¢nia-GO','alzira fernandes','Av. Adriano Auad, 00, Q. 02, L. 02','10','05','SENADOR CANEDO','75257-482','2026-05-15 14:22:35','pendente',NULL,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(120001,'WEBER FERNANDES PEREIRA','brasileira','solteiro(a)','professor','889.501.231-34','GoiÃ¢nia-GO','alzira fernandes','Av. Adriano Auad, 00, Q. 02, L. 02','10','05','SENADOR CANEDO','75257-482','2026-05-15 16:43:11','pendente',NULL,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(150001,'WEBER FERNANDES PEREIRA','brasileiro','uniÃ£o estÃ¡vel','professor','889.501.231-34','GoiÃ¢nia-GO','alzira fernandes','Av. Adriano Auad, 00, Q. 02, L. 02','10','05','SENADOR CANEDO','75257-482','2026-05-15 17:18:36','pendente',NULL,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(180001,'WEBER FERNANDES PEREIRA','brasileiro','solteiro(a)','professor','889.501.231-34','GoiÃ¢nia-GO','alzira fernandes','Av. Adriano Auad, 00, Q. 02, L. 02','10','05','SENADOR CANEDO','75257-482','2026-05-15 17:33:14','gerada','46fdf2ba2bd54cf89768deefbf1c55e9',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(210001,'MARIA DE FATIMA DA SILVA LIRA','brasileira','divorciado(a)','Professora','896.110.801-82','Carolina MA','David Dias Lira, Maria da Silva Lira','Rua j','212','14','GoiÃ¢nia','74475-090','2026-05-15 19:26:59','gerada','9315c3341ea34f9bb0457cc869d4fb0e',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(240001,'ELIVELTON VIEIRA DOS SANTOS','brasileiro','casado(a)','Professor','037.109.541-77','GoiÃ¢nia','Clarice Pereira Vieira Dos Santos','Rua 08','04','22','Goianira','75364-082','2026-05-15 19:45:32','gerada','abc736e241d141ed8a4682d83817a2ce',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(270001,'JESSICA LORANE SANTOS PEREIRA','brasileira','solteiro(a)','Professora','029.939.991-50','Itapuranga-GO','Mario Roque Pereira/ Eni Batista dos Santos','Rua 08','11','10','Goianira','75363-264','2026-05-15 20:11:08','gerada','5ab92ec0de114ea9bcfe3833f6296ba6',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(300001,'LEONILDO BRITO OLIVEIRA','brasileiro','solteiro(a)','Professor','019.434.441-02','MarabÃ¡ Pa','Aurenides da Silva Brito e Gelson Jesus de Oliveira','Avenida Santa Terezinha','01','7/8','Aparecida de GoiÃ¢nia','74948-731','2026-05-15 20:38:39','gerada','a2ecb847a351449c8c18f7c34848d229',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(330001,'PALOMA VIANA DE CASTRO','brasileira','solteiro(a)','Professora','037.510.891-28','GoiÃ¢nia -GO','JosÃ© Martins de Castro Filho e Maria de FÃ¡tima Viana Castro','Rua PatrocÃ­nio Viana','Ch','78C','GoiÃ¢nia -GO','74686-027','2026-05-15 23:01:52','gerada','7a42105d2b72427b8632e524f888d8c9',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(360001,'AILTON NAZARIO DOS SANTOS','brasileiro','solteiro(a)','sereiro','029.311.641-51','Miracema do tocantins','Maria odelite nazario dÃ³s santos','rua transversal','39','11','GoiÃ¢nia','74475-520','2026-05-17 12:55:49','gerada','bcc57b13957d481fb0edbc0495681113',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(390001,'VICTOR RICARDO ALVES BATISTA','brasileiro','divorciado(a)','Promotor de eventos','038.671.071-65','GoiÃ¢nia','Gilmar aparicido batista  maria de FÃ¡tima alves caitanob','Estrada114','Ãrea LT','Casa 25','GoiÃ¢nia','74470-220','2026-05-19 20:03:02','gerada','2f501ec7b68a4f3da813a93727944713',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(420001,'TAYNARA DE OLIVEIRA E SILVA','brasileira','casado(a)','Professora','032.921.011-40','Palmas- TO','Selma Maria de Oliveira e Silva','Rua jc 04','Qd 32','Lt 12','GoiÃ¢nia','74480-470','2026-05-20 15:24:51','pendente','446ef45a464445fbb0ac518a44068d8d',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(450001,'TAYNARA DE OLIVEIRA E SILVA','brasileira','casado(a)','Professora','032.921.011-40','Palmas-TO','Selma Maria de Oliveira e Silva','Rua jc 04','32','12','GoiÃ¢nia-GO','74480-470','2026-05-21 21:19:06','gerada','a5d0d313673c4ed2a42adbdffceb7fe9',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(480001,'DANIEL COSTA BESSA','brasileiro','solteiro(a)','Nenhuma','126.389.991-99','GoiÃ¢nia','Jackeline Costa Miranda','Rua Ismael de Souza','153','02','GoiÃ¢nia','74922-694','2026-05-26 19:50:22','gerada','44be6d701712443784103d78e4f8e559',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(510001,'KATIA MARTINS DE CASTRO','brasileira','solteiro(a)','Professora','713.361.921-00','Go-AnÃ¡polis','Brasil','54 S/N','01','03','Goiania','74463-830','2026-05-31 16:01:21','pendente','83d085c4c19a413480625106d17266c3',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(540001,'GUILHERME EVANGELISTA DE ALMEIDA','brasileiro','divorciado(a)','POLICIAL MILITAR','010.139.541-81','Goiania-GO','Silvia vaz de almeida e Enock Nogueira Andrade','RUA C 156','407','07','GOIÃ‚NIA','74354-628','2026-06-02 00:22:11','gerada','b9094df4a1574f2e94a81c01cd829ecd',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(540002,'GUILHERME EVANGELISTA DE ALMEIDA','brasileiro','divorciado(a)','POLICIAL MILITAR','010.139.541-81','Goiania-GO','Silvia vaz de almeida e Enock Nogueira Andrade','RUA C 156','407','07','GOIÃ‚NIA','74354-628','2026-06-02 00:23:54','pendente','08b8a765e6354374aa3a225eed9233c4',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(570001,'JORDEAN SILVA CARNEIRO','brasileiro','solteiro(a)','auxiliar de serviÃ§o gerais','065.430.123-90','MaranhÃ£o','Josias Miranda carneiro TÃ¢nia Maria Silva carneiro','Setor Alto do Vale, Rua Alv. 01','Q23','27','GoiÃ¢nia','74594-076','2026-06-06 21:37:35','gerada','c6396e6602684918b263090175b2b1f9',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(600001,'MONIQUE DE PAULA SOUZA RODRIGUES','brasileira','solteiro(a)','Auxiliar de serviÃ§o gerais','000.072.402-52','OurÃ©m PA','Paulo Cardoso Rodrigues Margarida de Souza lisboa','Setor Alto do Vale, Rua Alv. 01','Q23','27','GoiÃ¢nia','74594-076','2026-06-06 22:11:24','gerada','2be6f9c498d2410ababe5b623fc29b80',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(630001,'FSEFSFSEF','brasileiro','casado(a)','professor','111.111.111-11','GoiÃ¢nia-go','elvvs fejfoe e Alzira','rua vf 09','6a','13','goiÃ¢nia go','74473-070','2026-06-09 02:36:38','gerada','3ff27509babe4c94a41234ac89ab1f4b',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(660001,'KENNYA CINTIA DE CASTRO','brasileira','casado(a)','Professora','337.041.981-53','CatalÃ£o-GO','Olair de Castro Rosa, Waldir GonÃ§alves de Castro','Rua 9','','','GoiÃ¢nia','74040-013','2026-06-11 22:05:39','gerada','de1b40dfc9c9478a830bb876d18c13f4',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(690001,'JOÃƒO LUIS CORREA BATISTA','brasileiro','divorciado(a)','Jornalista/Professor','434.758.251-04','GOIÃ‚NIA-GO','Jocilia de Jesus Correa da Costa - Benedito Neder Batista','Avenida ConsolaÃ§Ã£o, Apto 101 Ponto de referÃªncia: Shopping Cerrado','','','GOIÃ‚NIA','74425-535','2026-06-12 13:44:52','gerada','3cdfaa471a9c4afbbe3caabc820df750',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(720001,'FGAWEFAWE','brasileiro','solteiro(a)','genge','889.501.231-34','GoiÃ¢nia-GO','elvvs fejfoe e Alzira','VF. 09','6a','13','GoiÃ¢nia','74473-070','2026-06-15 14:21:21','gerada','68e907a233014be3944cc258e5560e49',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(750001,'DIVINA D ARC MOREIRA DE OLIVEIRA','brasileira','solteiro(a)','Professora','764.546.811-49','GoiÃ¢nia-GO','Maria FÃ©lix Moreira de Oliveira e Benjamin Rodrigues de Oliveira','Rua CP34','51','19','GoiÃ¢nia','74477-247','2026-06-18 20:21:31','gerada','16833ae6b9104457a626ee2e22c88221',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(780001,'ELISA DOS SANTOS ARAÃšJO','brasileira','solteiro(a)','Estudante','031.696.431-00','GoiÃ¢nia-GO','Elaine Francisca dos Santos','Paulo Bregaro','1','3','Goiania','74595-050','2026-06-19 17:36:22','gerada','51c4d9fb893e492f86bf417e350e78f6',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(810001,'GLAUCIA ANDRÃ‰IA RAMOS DA SILVA','brasileira','casado(a)','FuncionÃ¡ria PÃºblica','972.943.651-72','GoiÃ¢nia-GO','Benedita de Paula Ramos  e Eloisio de AraÃºjo Silva','Avenida Mangalo n.1571','','','GoiÃ¢nia','74475-115','2026-06-20 17:10:27','gerada','24cb21fa2f56406489beba83588fe04f',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(840001,'SELMON RODRIGUES BATISTA','brasileiro','casado(a)','AutÃ´nomo','991.013.351-20','Ponte Alta do Norte-TO','SÃ©rio Alves Rodrigues e Selma dos Reis Alves Batista','Avenida MangalÃ´ 1571','','','GoiÃ¢nia','74475-080','2026-06-20 17:16:04','gerada','a40d3a21a36f4ac5a77959ff0f837ed8',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(870001,'NILTA MENDES DA SILVA BORGES','brasileira','casado(a)','PROFESSORA','138.957.688-47','CURVELO-MG','NATALINO MENDES DA SILVA E MARIA IRES DA SILVA','AV. CONSOLAÃ‡ÃƒO AP. 103 BLOCO B03 CONDOMINIO AGUAS CLARAS','00','00','GOIANIA','74425-535','2026-06-25 10:26:55','gerada','d81bb9abd71d45d5aee3279f7fdd1d94',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(900001,'LUCAS ADAIR SPOLTI','brasileiro','solteiro(a)','es','088.440.569-92','Treze TÃ­lias-SC','Ronaldo Spolti','Rua Gisela Thaler, 304','01','01','fe','89650-000','2026-06-25 16:15:18','gerada','113caef2b60b4a27990785deca266484',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(930001,'DAHIANA SOUSA PINTO PORTELA','brasileira','casado(a)','Do lar','898.102.011-68','Barra do garÃ§as-MT','Marisa Sousa otto','Rua Adriano auad','Qd 02','02','Senador canedo','75257-482','2026-07-03 12:19:44','gerada','ee9ce974594645f9b74644ceb80db9e9',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(930002,'DAHIANA SOUSA PINTO PORTELA','brasileira','separado(a) judicialmente','Do lar','898.102.011-68','Barra do garÃ§as-MT','Marisa Sousa otto','Rua Adriano auad','02','02','Senador canedo','75257-452','2026-07-03 12:22:33','gerada','0df303490b1b4b1a813d8cf80544f070',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(960001,'MARIA BOMFIM LOPES DE OLIVEIRA','brasileira','casado(a)','DomÃ©stica','583.779.801-34','Coribe Bahia-BA','Mailde Bomfim Lopes ,Edmar Moreira Lopes','Rua cumprida qd 2B lote 04','Qd 2b','04','Goianira','75369-198','2026-07-06 21:15:19','gerada','b37869f6d8654bcfb6a97872a45589ee',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(990001,'FRANCISCA MARIA DOS SANTOS BALDEZ','brasileira','solteiro(a)','TEC  enfermagem','885.599.631-20','Parnarama-MA','Orlando Baldez/ Doracy dos santos Baldez','Avenida Manchester Fazenda Botafogo S/N, damasco apto 204','00','00','GoiÃ¢nia','74702-755','2026-07-07 13:40:20','gerada','51f6ae2b6e2e452b9e90a8d5057e96d9',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL);
/*!40000 ALTER TABLE `procuracoes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-13 12:38:21

-- MySQL dump 10.13  Distrib 8.0.45, for Linux (x86_64)
--
-- Host: gateway04.us-east-1.prod.aws.tidbcloud.com    Database: 9HxVMH7VVkjkpEJXq4mpPC
-- ------------------------------------------------------
-- Server version	8.0.11-TiDB-v8.5.3-serverless

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `procuracoes_pa`
--

DROP TABLE IF EXISTS `procuracoes_pa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `procuracoes_pa` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nomeMenor` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cpfMenor` varchar(14) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dataNascimento` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nome` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `genero` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estadoCivil` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `profissao` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cpf` varchar(14) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rg` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `naturalidade` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nomePai` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nomeMae` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rua` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quadra` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lote` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `setor` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cidade` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cep` varchar(9) COLLATE utf8mb4_unicode_ci NOT NULL,
  `criadoEm` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('pendente','gerada') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pendente',
  `downloadToken` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `observacoes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `numero` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `orgao_expedidor` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `telefone` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=690001;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `procuracoes_pa`
--

LOCK TABLES `procuracoes_pa` WRITE;
/*!40000 ALTER TABLE `procuracoes_pa` DISABLE KEYS */;
INSERT INTO `procuracoes_pa` (`id`, `nomeMenor`, `cpfMenor`, `dataNascimento`, `nome`, `genero`, `estadoCivil`, `profissao`, `cpf`, `rg`, `naturalidade`, `nomePai`, `nomeMae`, `rua`, `quadra`, `lote`, `setor`, `cidade`, `estado`, `cep`, `criadoEm`, `status`, `downloadToken`, `observacoes`, `numero`, `orgao_expedidor`, `email`, `telefone`) VALUES (1,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-06-09 01:37:22','gerada','2a3cadae3d864e9da7984bd5aa3422f5',NULL,NULL,'','',''),(2,'ANA BEATRIZ DA SILVA','111.222.333-44','20/01/2022','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-06-09 01:37:22','pendente','3d2a8a59ed4348a795e19e71970555ae',NULL,NULL,'','',''),(3,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-06-09 01:37:31','pendente','0e40197d68dd42cd8f6180911e1d0752',NULL,NULL,'','',''),(4,'ANA BEATRIZ DA SILVA','111.222.333-44','20/01/2022','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-06-09 01:37:31','pendente','60c5681083684b7bbff4fc8e27413e2b',NULL,NULL,'','',''),(5,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-06-09 01:38:22','pendente','8eca5b0d2c364b0bb6b39b22564bcef5',NULL,NULL,'','',''),(30001,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-06-09 02:13:24','pendente','aedb439238dd4c579c44c5ecbe66fd9b',NULL,NULL,'','',''),(30002,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-06-09 02:14:43','pendente','fdd5f5078ad6474f9b20a5d82cd9943b',NULL,NULL,'','',''),(30003,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-06-09 02:29:11','pendente','96e45939734343888616a5e1e3418534',NULL,NULL,'','',''),(30004,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-06-09 02:31:04','pendente','a330ff44042f4c0ea8f02dbc57580283',NULL,NULL,'','',''),(60001,'GFSERGSRFSDF','000.000.000-00','05/02/2023','GARGSERGAFG','brasileira','solteiro(a)','do lar','222.222.222-22','1215165415','GoiÃ¢nia, GoiÃ¡s','jkjhiu','Ã§ljlijil','x10','6a','13','fajfeiofeof','GoiÃ¢nia','GO','74473-070','2026-06-09 03:00:03','pendente','e59ec69fa9814dbb82ded05b531ba896',NULL,NULL,'','',''),(90001,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-06-09 03:43:41','pendente','fad4c92d0ebb4a63a13048f05098f9f3',NULL,NULL,'','',''),(90002,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-06-09 03:43:55','pendente','33433fc478744b5eb94ab75bd75292a7',NULL,NULL,'','',''),(90003,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-06-09 03:44:30','pendente','05f6ad5ed3b54521b183bb5d0491557e',NULL,NULL,'','',''),(120001,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-06-15 15:08:14','gerada','a6c7119d39f744d6b55901b19faf9d66',NULL,NULL,'','',''),(120002,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-06-15 15:08:25','pendente','f17b51e7b59f4f67b1fb08112ced674f',NULL,NULL,'','',''),(120003,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-06-15 15:16:58','pendente','6371aa5519844639af9a563337c54b8f',NULL,NULL,'','',''),(120004,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-06-15 15:17:06','pendente','6589ee881b274d8aaec2559e5c4b968f',NULL,NULL,'','',''),(120005,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-06-15 15:18:20','pendente','c459e48b9e464de7a67693006e13dfed',NULL,NULL,'','',''),(120006,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-06-15 15:18:28','pendente','75537522ffdd427796c6e854a0e64fe8',NULL,NULL,'','',''),(120007,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-06-15 15:21:37','pendente','ee65f747daae4b8092c1ffa66fc5b089',NULL,NULL,'','',''),(120008,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-06-15 16:04:33','pendente','6ae63cc012f242e1b417f0a47adbedd6',NULL,NULL,'','',''),(120009,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-06-15 16:55:15','pendente','42159b50ac1f41efaa203d83d9f379ce',NULL,NULL,'','',''),(120010,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-06-15 16:59:06','pendente','c9647e405a4e482f869e01b638a7c8d7',NULL,NULL,'','',''),(150001,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-06-29 22:33:30','pendente','08ed93bf01aa425eba2c1007b544ac68',NULL,NULL,'','',''),(150002,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-06-29 22:34:16','pendente','4bc95b3681104132b5fc18078f3732e3',NULL,NULL,'','',''),(180001,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-07-08 13:08:55','pendente','87d451bd55ed4741bf9e75135bf180ab',NULL,NULL,'','',''),(210001,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-07-08 13:26:11','pendente','8dbf147f-afc5-44bd-a768-107aafc7093b',NULL,NULL,'','',''),(210002,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-07-08 13:26:19','pendente','700e2807-8ea8-4ec8-a475-919a5062557b',NULL,NULL,'','',''),(240001,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-07-08 16:23:54','pendente','3802e500-a568-4580-adb4-74eb2b7f0c66',NULL,NULL,'','',''),(240002,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-07-08 16:28:06','pendente','8328f152-8aa5-4370-a9fe-695bdd3dbb4e',NULL,NULL,'','',''),(240003,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-07-08 16:49:57','pendente','eb4e906f-c55c-4203-9d21-76e294ce0555',NULL,NULL,'','',''),(240004,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-07-08 16:52:10','pendente','b93beba2-8529-4ff6-ae2c-0cf11c4302b1',NULL,NULL,'','',''),(240005,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-07-08 17:17:07','pendente','68ad3a71-5d1a-4238-8d72-5f0a193aa96c',NULL,NULL,'','',''),(270001,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-07-08 19:53:52','pendente','a0988c41-9b28-4b32-9090-0aad1cc0a99e',NULL,NULL,'','',''),(300001,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-07-08 20:52:35','pendente','bc7298aa-df61-4b9f-b900-78c7904eebd8',NULL,NULL,'','',''),(300002,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-07-08 20:56:34','pendente','826f5772-8e5c-445a-9436-d10d364d9396',NULL,NULL,'','',''),(330001,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-07-08 21:53:49','pendente','6354cd38-b9a3-4df4-b518-46a768c04891',NULL,NULL,'','',''),(360001,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-07-08 22:05:40','pendente','dd7ddb7b-ea47-4c27-b72c-24db50fe7c9d',NULL,NULL,'','',''),(390001,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-07-08 22:08:52','pendente','5feb4efe-acda-4f8f-b065-60bcec9dde49',NULL,NULL,'','',''),(420001,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-07-08 22:12:30','pendente','55d8fb8e-cf9a-4f35-bfab-bb7fb69c1923',NULL,NULL,'','',''),(420002,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-07-08 22:58:12','pendente','f9c0daf6-fcc9-4b21-9478-e4213d1f0a2e',NULL,NULL,'','',''),(420003,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-07-08 23:24:39','pendente','f12ff910-62a3-4802-8f5a-72ba5d317130',NULL,NULL,'','',''),(420004,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-07-08 23:25:25','pendente','2da95a19-6849-43bf-88d8-b48b80a1d1bb',NULL,NULL,'','',''),(450001,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-07-09 02:41:44','pendente','42853cfe-3fbf-4ea0-b678-88f0ff398024',NULL,NULL,'','',''),(450002,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-07-09 02:45:55','pendente','986631af-a2af-4a56-b2f6-6fd57ba9628d',NULL,NULL,'','',''),(480001,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-07-09 03:13:38','pendente','5660e1d2-49ed-41b0-b52c-ecce2ddf0f00',NULL,NULL,'','',''),(480002,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-07-09 03:14:50','pendente','5008552f-ddf3-489c-8d7f-58a10cfe2544',NULL,NULL,'','',''),(510001,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-07-10 12:46:29','pendente','0bd08bcc-9778-4a52-8466-f3367ba08b59',NULL,NULL,'','',''),(540001,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-07-10 12:48:29','pendente','dafcce3e-67ca-4cad-8ebe-3cb5819f45ed',NULL,NULL,'','',''),(570001,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-07-10 12:58:59','pendente','a0de5d15-648f-4345-bacf-0f216983f9af',NULL,NULL,'','',''),(600001,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-07-10 13:06:25','pendente','2540aff2-1f52-4e82-aa79-2e97f6ba1814',NULL,NULL,'','',''),(630001,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-07-10 13:53:11','pendente','9dc1e6ca-0305-46b7-8a8e-b955a1b42756',NULL,NULL,'','',''),(660001,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','GoiÃ¢nia-GO','JoÃ£o da Silva','Ana da Silva','Rua das Flores, nÂº 10',NULL,NULL,NULL,'GoiÃ¢nia','GO','74000-000','2026-07-10 13:58:35','pendente','52d978e6-b85b-40ae-a22c-347f69c35fef',NULL,NULL,'','','');
/*!40000 ALTER TABLE `procuracoes_pa` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-13 12:38:21

-- MySQL dump 10.13  Distrib 8.0.45, for Linux (x86_64)
--
-- Host: gateway04.us-east-1.prod.aws.tidbcloud.com    Database: 9HxVMH7VVkjkpEJXq4mpPC
-- ------------------------------------------------------
-- Server version	8.0.11-TiDB-v8.5.3-serverless

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `procuracoes_weber_ana`
--

DROP TABLE IF EXISTS `procuracoes_weber_ana`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `procuracoes_weber_ana` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `genero` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estadoCivil` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `profissao` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cpf` varchar(14) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rg` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `naturalidade` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nomePai` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nomeMae` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rua` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quadra` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lote` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `setor` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cidade` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cep` varchar(9) COLLATE utf8mb4_unicode_ci NOT NULL,
  `criadoEm` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('pendente','gerada') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pendente',
  `downloadToken` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `observacoes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `numero` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=30001;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `procuracoes_weber_ana`
--

LOCK TABLES `procuracoes_weber_ana` WRITE;
/*!40000 ALTER TABLE `procuracoes_weber_ana` DISABLE KEYS */;
INSERT INTO `procuracoes_weber_ana` (`id`, `nome`, `genero`, `estadoCivil`, `profissao`, `cpf`, `rg`, `naturalidade`, `nomePai`, `nomeMae`, `rua`, `quadra`, `lote`, `setor`, `cidade`, `estado`, `cep`, `criadoEm`, `status`, `downloadToken`, `observacoes`, `numero`) VALUES (1,'GDFAAFDAE','brasileiro','solteiro(a)','professor','111.111.111-11','22222222','GoiÃ¢nia','fdefaeffaefe','ggewrefse','x10','de','12','fajfeiofeof','GoiÃ¢nia','Go','74473-070','2026-06-09 02:47:44','gerada','889ccad65c204eba978901b5db8347d2',NULL,NULL);
/*!40000 ALTER TABLE `procuracoes_weber_ana` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-13 12:38:22

-- MySQL dump 10.13  Distrib 8.0.45, for Linux (x86_64)
--
-- Host: gateway04.us-east-1.prod.aws.tidbcloud.com    Database: 9HxVMH7VVkjkpEJXq4mpPC
-- ------------------------------------------------------
-- Server version	8.0.11-TiDB-v8.5.3-serverless

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `submissoes_modelo`
--

DROP TABLE IF EXISTS `submissoes_modelo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `submissoes_modelo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `modeloId` int NOT NULL,
  `nome` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `genero` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estadoCivil` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `profissao` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cpf` varchar(14) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rg` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `naturalidade` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nomePai` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nomeMae` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rua` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quadra` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lote` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `setor` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cidade` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cep` varchar(9) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dataAssinatura` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `downloadToken` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('pendente','gerada') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pendente',
  `observacoes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `criadoEm` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `numero` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `submissoes_modelo`
--

LOCK TABLES `submissoes_modelo` WRITE;
/*!40000 ALTER TABLE `submissoes_modelo` DISABLE KEYS */;
/*!40000 ALTER TABLE `submissoes_modelo` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-13 12:38:22

-- MySQL dump 10.13  Distrib 8.0.45, for Linux (x86_64)
--
-- Host: gateway04.us-east-1.prod.aws.tidbcloud.com    Database: 9HxVMH7VVkjkpEJXq4mpPC
-- ------------------------------------------------------
-- Server version	8.0.11-TiDB-v8.5.3-serverless

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
  PRIMARY KEY (`id`) ,
  UNIQUE KEY `users_openId_unique` (`openId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=5730001;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `openId`, `name`, `email`, `loginMethod`, `role`, `createdAt`, `updatedAt`, `lastSignedIn`) VALUES (1,'AAALTMUDcLuMf8jmV6NJSr','Prof. Weber','wolfrickwolf@gmail.com','google','admin','2026-05-15 14:26:22','2026-07-13 12:37:06','2026-07-13 12:37:07'),(1170004,'mvnEumu55rdYbb5FC2Mz4j','Lucas Spolti','lucassspolti@gmail.com','google','user','2026-06-25 16:26:44','2026-06-25 16:39:45','2026-06-25 16:39:45');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-13 12:38:22

SET FOREIGN_KEY_CHECKS=1;
-- Dump concluÃ­do.


-- --- MÓDULO ACOMPANHAMENTO DE PROCESSOS ---
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
  PRIMARY KEY (`id`) ,
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
  `tipoManifestacao` enum('Recurso','Resposta','ApelaÃ§Ã£o','Embargos de declaraÃ§Ã£o','Autos conclusos','ConciliaÃ§Ã£o','AudiÃªncia','ContestaÃ§Ã£o','ImpugnaÃ§Ã£o','Outro') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cliente` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `anotacao` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `horario` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dataIntimacao` date DEFAULT NULL,
  PRIMARY KEY (`id`) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=750001;

-- Dados da tabela `processos` (89 registros)
INSERT INTO `processos` (`id`, `userId`, `numeroCnj`, `tribunal`, `ativo`, `createdAt`, `updatedAt`, `dataLimite`, `tipoManifestacao`, `cliente`, `anotacao`, `horario`, `dataIntimacao`) VALUES
(1, 1, '5106433-08.2023.8.09.0099', 'TJGO', 0, '2026-05-09 06:50:04', '2026-05-11 17:50:42', '2026-05-26 00:00:00', 'Resposta', 'Odair', NULL, NULL, NULL),
(2, 1, '5980803-55.2025.8.09.0130', 'TJGO', 1, '2026-05-09 06:50:04', '2026-05-29 18:15:17', '2026-05-29 00:00:00', 'Autos conclusos', NULL, '14:30', NULL, NULL),
(3, 1, '5248885-83.2026.8.09.0051', 'TJGO', 0, '2026-05-09 06:50:04', '2026-05-11 12:34:24', '2026-05-18 00:00:00', 'ConciliaÃ§Ã£o', NULL, '14:00', NULL, NULL),
(4, 1, '5144869-49.2024.8.09.0051', 'TJGO', 0, '2026-05-09 06:50:04', '2026-05-18 16:03:24', '2026-05-22 00:00:00', 'Resposta', NULL, NULL, NULL, NULL),
(5, 1, '5061666-24.2026.8.09.0051', 'TJGO', 1, '2026-05-09 06:50:04', '2026-05-09 06:50:04', NULL, NULL, NULL, NULL, NULL, NULL),
(6, 1, '5089329-45.2026.8.09.0051', 'TJGO', 0, '2026-05-09 06:50:04', '2026-05-09 07:07:41', '2026-05-07 00:00:00', 'Resposta', NULL, NULL, NULL, NULL),
(7, 1, '5024260-66.2026.8.09.0051', 'TJGO', 0, '2026-05-09 06:50:04', '2026-05-11 15:15:43', '2026-05-20 00:00:00', 'Outro', NULL, 'Recorrer ou nÃ£o', NULL, NULL),
(8, 1, '5563039-67.2025.8.09.0051', 'TJGO', 0, '2026-05-09 06:50:04', '2026-05-15 19:33:49', '2026-05-15 00:00:00', 'Resposta', 'Marlene', NULL, NULL, NULL),
(9, 1, '5989484-91.2024.8.09.0051', 'TJGO', 0, '2026-05-09 06:50:04', '2026-05-12 15:55:27', '2026-05-15 00:00:00', 'Resposta', NULL, NULL, NULL, NULL),
(10, 1, '5554704-59.2025.8.09.0051', 'TJGO', 0, '2026-05-09 06:50:04', '2026-06-01 13:42:58', NULL, 'Resposta', 'Devair', NULL, NULL, NULL),
(11, 1, '5258413-44.2026.8.09.0051', 'TJGO', 1, '2026-05-09 06:50:04', '2026-07-01 12:40:20', NULL, 'ConciliaÃ§Ã£o', 'NÃ¡gila', 'AudiÃªncia', '15:00', '2026-08-17 00:00:00'),
(12, 1, '5829187-13.2024.8.09.0051', 'TJGO', 0, '2026-05-09 06:50:04', '2026-05-09 07:07:40', '2026-05-07 00:00:00', 'Resposta', NULL, NULL, NULL, NULL),
(13, 1, '5283239-71.2025.8.09.0051', 'TJGO', 0, '2026-05-09 06:50:04', '2026-05-09 07:07:38', '2026-05-06 00:00:00', 'Resposta', 'Margarida', NULL, NULL, NULL),
(14, 1, '5172432-47.2026.8.09.0051', 'TJGO', 0, '2026-05-09 06:50:04', '2026-05-11 17:48:52', '2026-05-15 00:00:00', 'ConciliaÃ§Ã£o', NULL, '17:00', NULL, NULL),
(30001, 1, '5223008-93.2016.8.09.0051', 'TJGO', 1, '2026-05-11 11:32:16', '2026-06-23 13:58:13', '2026-07-07 00:00:00', 'Recurso', 'HONIELLY', 'Agravo de instrumento ', NULL, '2026-06-16 00:00:00'),
(30002, 1, '5989484-91.2024.8.09.0051', 'TJGO', 1, '2026-05-11 11:41:58', '2026-05-11 11:41:58', '2026-04-17 00:00:00', 'Autos conclusos', 'HONIELLY', NULL, NULL, NULL),
(30003, 1, '5016205-63.2025.8.09.0051', 'TJGO', 1, '2026-05-11 11:43:45', '2026-07-10 12:18:22', '2026-07-20 00:00:00', 'ApelaÃ§Ã£o', 'Elvis', 'ApelaÃ§Ã£o processo ELVIS', NULL, '2026-07-09 00:00:00'),
(30004, 1, '5091948-79.2025.8.09.0051', 'TJGO', 1, '2026-05-11 11:44:36', '2026-07-01 12:36:31', '2026-07-17 00:00:00', 'Autos conclusos', 'Mateus', 'Rejeita exceÃ§Ã£o de prÃ©-executividade/int. para pagamento do dÃ©bito.', NULL, '2026-06-26 00:00:00'),
(30005, 1, '5305232-73.2025.8.09.0051', 'TJGO', 0, '2026-05-11 11:45:49', '2026-05-11 11:57:03', '2026-04-22 00:00:00', 'Outro', NULL, 'chamamento do feito Ã  ordem', NULL, NULL),
(30006, 1, '5305232-73.2025.8.09.0051', 'TJGO', 1, '2026-05-11 11:58:09', '2026-05-11 11:58:09', '2026-04-22 00:00:00', 'Outro', 'Priscila (Espanha)', 'Chamamento do Feito a ordem', NULL, NULL),
(30007, 1, '5585454-44.2025.8.09.0051', 'TJGO', 1, '2026-05-11 11:59:38', '2026-05-11 11:59:38', '2026-03-21 00:00:00', 'Outro', 'EnilÃ©ia (DivÃ³ricio)', 'Parecer MP', NULL, NULL),
(30008, 1, '5590762-61.2025.8.09.0051', 'TJGO', 0, '2026-05-11 12:01:39', '2026-07-03 13:23:59', '2026-06-02 00:00:00', 'Resposta', 'EnilÃ©ia (PensÃ£o HH)', 'execuÃ§Ã£o cobrar', NULL, NULL),
(30009, 1, '5890907-44.2025.8.09.0051', 'TJGO', 1, '2026-05-11 12:03:30', '2026-05-11 12:03:30', '2026-04-27 00:00:00', 'Outro', 'Jenifer', 'fase Provas', NULL, NULL),
(30010, 1, '6026398-23.2025.8.09.0051', 'TJGO', 1, '2026-05-11 12:08:19', '2026-06-23 17:09:48', '2026-06-19 00:00:00', 'Autos conclusos', 'Jenifer', 'Autos conclusos', NULL, NULL),
(30011, 1, '5172432-47.2026.8.09.0051', 'TJGO', 1, '2026-05-11 12:10:53', '2026-06-23 17:15:40', '2026-06-26 00:00:00', 'Resposta', 'Luciana', 'Apresentar provas', NULL, NULL),
(30012, 1, '5248885-83.2026.8.09.0051', 'TJGO', 0, '2026-05-11 12:13:17', '2026-06-01 13:55:33', '2026-06-05 00:00:00', 'Resposta', 'NÃ¡gila', 'CONTESTAÃ‡ÃƒO', NULL, NULL),
(30013, 1, '5292412-85.2026.8.09.0051', 'TJGO', 1, '2026-05-11 12:36:43', '2026-06-23 12:31:29', '2026-07-17 00:00:00', 'ConciliaÃ§Ã£o', 'Sabrina', 'procuraÃ§Ã£o do filho', '14:00', '2026-06-02 00:00:00'),
(30014, 1, '5078798-07.2020.8.09.0051', 'TJGO', 1, '2026-05-11 12:38:12', '2026-07-03 13:22:58', '2026-07-24 00:00:00', 'Outro', 'Thalita', 'IntimaÃ§Ãµes para Herdeiros', NULL, '2026-07-03 00:00:00'),
(30015, 1, '5645405-08.2021.8.09.0051', 'TJGO', 0, '2026-05-11 12:40:02', '2026-05-24 17:05:06', '2026-04-14 00:00:00', 'Outro', 'Thalita', 'prestar contas 2Âª fase', NULL, NULL),
(30016, 1, '5078374-22.2024.8.09.0116', 'TJGO', 1, '2026-05-11 12:41:07', '2026-07-02 13:39:21', '2026-07-01 00:00:00', 'AudiÃªncia', 'Karoline PB', 'intimaÃ§Ã£o', '17:30', NULL),
(30017, 1, '5179539-05.2025.8.09.0011', 'TJGO', 1, '2026-05-11 12:42:05', '2026-06-23 12:49:24', '2026-07-01 00:00:00', 'Resposta', 'SÃ´nia', 'Responder a quebra de sigilo.', NULL, '2026-06-10 00:00:00'),
(30018, 1, '5233001-67.2025.8.09.0174', 'TJGO', 1, '2026-05-11 12:44:29', '2026-07-02 12:39:04', '2026-07-20 00:00:00', 'AudiÃªncia', 'Julio', 'AIARespAExt', '10:00', NULL),
(30019, 1, '5202204-86.2025.8.09.0149', 'TJGO', 1, '2026-05-11 12:49:07', '2026-05-11 12:49:07', '2026-02-03 00:00:00', 'Outro', 'Elymara', 'Criminal - MP Parecer', NULL, NULL),
(30020, 1, '5995431-53.2025.8.09.0064', 'TJGO', 1, '2026-05-11 12:50:20', '2026-05-11 12:50:20', '2026-05-02 00:00:00', 'Outro', 'Marcos ', 'Criminal - PrisÃ£o Ilegal', NULL, NULL),
(30021, 1, '5106433-08.2023.8.09.0099', 'TJGO', 1, '2026-05-11 12:51:46', '2026-05-11 12:51:46', '2026-05-07 00:00:00', 'Outro', 'Odair', 'Aguardar CÃ¡lculos da Contadoria', NULL, NULL),
(30022, 1, '5725166-44.2024.8.09.0064', 'TJGO', 1, '2026-05-11 12:54:09', '2026-05-11 12:54:09', '2026-03-31 00:00:00', 'Autos conclusos', 'DamiÃ£o', 'avaliaÃ§Ã£o das benfeitorias', NULL, NULL),
(30023, 1, '5745940-61.2025.8.09.0064', 'TJGO', 1, '2026-05-11 12:55:37', '2026-05-11 12:55:37', '2026-04-09 00:00:00', 'Outro', 'Nilvania', 'Reingressar', NULL, NULL),
(30024, 1, '5980803-55.2025.8.09.0130', 'TJGO', 1, '2026-05-11 12:56:40', '2026-06-03 10:38:12', '2026-06-01 00:00:00', 'Autos conclusos', 'Leidiane', 'endereÃ§os rÃ©us', NULL, NULL),
(30025, 1, '5017438-71.2020.8.09.0051', 'TJGO', 1, '2026-05-11 12:58:11', '2026-05-11 12:58:11', '2026-04-06 00:00:00', 'Outro', 'KÃªnia', 'Autos devolvidos - aguardar', NULL, NULL),
(30026, 1, '5292656-27.2026.8.09.0079', 'TJGO', 0, '2026-05-11 12:59:26', '2026-05-14 19:13:58', '2026-05-11 00:00:00', 'Resposta', 'Janes', 'guarda dos filhos', NULL, NULL),
(30027, 1, '5220911-55.2024.8.09.0176', 'TJGO', 1, '2026-05-11 13:01:47', '2026-06-23 13:52:13', '2026-07-07 00:00:00', 'Outro', 'Honielly', NULL, NULL, '2026-06-16 00:00:00'),
(30028, 1, '5949251-17.2025.8.09.0116', 'TJGO', 1, '2026-05-11 13:56:28', '2026-05-27 02:50:37', '2026-05-25 00:00:00', 'Outro', 'Divina', 'Acordo, cumprimento', NULL, NULL),
(30029, 1, '5366913-78.2024.8.09.0051', 'TJGO', 1, '2026-05-11 13:58:29', '2026-07-09 14:03:45', '2026-07-14 00:00:00', 'AudiÃªncia', 'Ester', 'MediaÃ§Ã£o - https://us05web.zoom.us/j/88337434251?pwd=4conOVlJfrknDTRbK7N2HQs0kcma5r.1', '14:30', NULL),
(30030, 1, '5423899-52.2024.8.09.0051', 'TJGO', 1, '2026-05-11 13:59:55', '2026-05-28 18:32:45', '2026-05-28 00:00:00', 'Outro', 'Tiago Londres', 'Impugnar PerÃ­cia', NULL, NULL),
(30031, 1, '5829187-13.2024.8.09.0051', 'TJGO', 1, '2026-05-11 14:01:48', '2026-07-09 13:34:35', '2026-06-07 00:00:00', 'Autos conclusos', 'Leonardo', 'Documento novo - Prodago ProprietÃ¡ria', NULL, NULL),
(30032, 1, '6145181-27.2024.8.09.0174', 'TJGO', 1, '2026-05-11 14:10:08', '2026-06-23 12:11:27', '2026-07-15 00:00:00', 'Resposta', 'JÃºlio Gomes', 'Responder sobre o Laudo Pericial.', NULL, '2026-06-24 00:00:00'),
(30033, 1, '5283239-71.2025.8.09.0051', 'TJGO', 1, '2026-05-11 14:11:16', '2026-06-23 13:28:37', '2026-07-06 00:00:00', 'Resposta', 'Margarida', 'Contra RazÃµes', NULL, '2026-06-15 00:00:00'),
(30034, 1, '5340195-33.2025.8.09.0011', 'TJGO', 1, '2026-05-11 15:10:02', '2026-06-23 17:27:24', '2026-07-09 00:00:00', 'Resposta', 'Bruno', 'Apresentar endereÃ§os para CitaÃ§Ã£o', NULL, '2026-06-18 00:00:00'),
(30035, 1, '5497561-15.2025.8.09.0051', 'TJGO', 1, '2026-05-11 15:11:30', '2026-05-11 15:11:30', '2026-05-05 00:00:00', 'Autos conclusos', 'ClaÃºdia', 'prestar contas', NULL, NULL),
(30036, 1, '5554704-59.2025.8.09.0051', 'TJGO', 1, '2026-05-11 15:12:24', '2026-07-02 13:31:07', '2026-07-08 00:00:00', 'Resposta', 'Devair', 'RESPOSTA ', NULL, '2026-07-01 00:00:00');
INSERT INTO `processos` (`id`, `userId`, `numeroCnj`, `tribunal`, `ativo`, `createdAt`, `updatedAt`, `dataLimite`, `tipoManifestacao`, `cliente`, `anotacao`, `horario`, `dataIntimacao`) VALUES
(30037, 1, '5563039-67.2025.8.09.0051', 'TJGO', 1, '2026-05-11 15:13:28', '2026-07-10 12:24:47', '2026-07-30 00:00:00', 'Resposta', 'Marlene', 'Responder a petiÃ§Ã£o de Fernanda', NULL, '2026-07-09 00:00:00'),
(30038, 1, '5024260-66.2026.8.09.0051', 'TJGO', 1, '2026-05-11 15:14:16', '2026-05-11 15:16:51', '2026-05-20 00:00:00', 'Outro', 'Leonardo', 'aguardar sentenÃ§a', NULL, NULL),
(30039, 1, '5089329-45.2026.8.09.0051', 'TJGO', 1, '2026-05-11 15:18:04', '2026-05-11 15:18:04', '2026-05-05 00:00:00', 'Autos conclusos', 'Margarida', 'endereÃ§os para citaÃ§Ã£o - pronto', NULL, NULL),
(30040, 1, '5147102-48.2026.8.09.0051', 'TJGO', 1, '2026-05-11 15:19:06', '2026-05-11 15:19:06', '2026-05-05 00:00:00', 'Autos conclusos', 'Marlene', 'Marlene x Equatorial', NULL, NULL),
(30041, 1, '5144869-49.2024.8.09.0051', 'TJGO', 1, '2026-05-11 15:38:40', '2026-05-27 04:12:11', '2026-05-22 00:00:00', 'Outro', 'Margarida', 'DecisÃ£o Penhora', NULL, NULL),
(30042, 1, '5429282-98.2022.8.09.0174', 'TJGO', 1, '2026-05-11 15:41:14', '2026-06-23 19:27:39', NULL, 'Outro', 'Daniel', 'Processo arquivado.', NULL, NULL),
(30043, 1, '5915052-03.2024.8.09.0116', 'TJGO', 1, '2026-05-11 15:42:49', '2026-05-11 15:42:59', '2026-05-05 00:00:00', 'Outro', 'Edmar', 'Criminal - Medida protetiva', NULL, NULL),
(30044, 1, '5292530-84.2026.8.09.0011', 'TJGO', 0, '2026-05-11 15:44:21', '2026-05-15 21:45:36', '2026-05-05 00:00:00', 'Autos conclusos', 'Janes', 'Criminal', NULL, NULL),
(30045, 1, '5536655-57.2023.8.09.0174', 'TJGO', 1, '2026-05-11 15:46:20', '2026-06-16 13:24:42', '2026-07-23 00:00:00', 'Autos conclusos', 'Dorizeth', 'REsp e RExt', NULL, NULL),
(30046, 1, '5310003-31.2024.8.09.0051', 'TJGO', 1, '2026-05-11 15:47:17', '2026-05-11 15:47:17', '2026-05-05 00:00:00', 'Outro', 'Odair', 'REsp e RExt', NULL, NULL),
(30047, 1, '0000093-45.2025.5.18.0006', 'TRT18', 1, '2026-05-11 16:06:46', '2026-05-11 16:06:46', '2026-05-05 00:00:00', 'Outro', 'Angelina', 'verificar 2Â° Grau', NULL, NULL),
(30048, 1, '0000093-45.2025.5.18.0006', 'TRT18', 0, '2026-05-11 16:20:10', '2026-05-11 16:20:34', '2026-05-05 00:00:00', 'Outro', 'Angelina', 'ver 2Â° Grau', NULL, NULL),
(30049, 1, '0001362-37.2025.5.18.0001', 'TRT18', 1, '2026-05-11 16:27:44', '2026-06-03 10:37:44', '2026-06-02 00:00:00', 'Autos conclusos', 'Gabrielle', 'Resposta da reclamada', NULL, NULL),
(30050, 1, '0002018-58.2025.5.18.0012', 'TRT18', 1, '2026-05-11 16:30:01', '2026-05-22 18:30:26', '2026-05-21 00:00:00', 'Autos conclusos', 'Matheus', 'AudiÃªncia de InstruÃ§Ã£o - sala 02', NULL, NULL),
(60001, 1, '5407706-88.2026.8.09.0051', 'TJGO', 1, '2026-05-11 17:23:25', '2026-06-16 13:54:20', '2026-07-21 00:00:00', 'Autos conclusos', 'Krisner', 'anulatoria de PAD', NULL, NULL),
(60002, 1, '5389036-07.2023.8.09.0051', 'TJGO', 1, '2026-05-11 17:35:15', '2026-05-11 17:35:15', '2026-05-05 00:00:00', 'Outro', 'ClaÃºdia', 'Processo de SÃ£o JoÃ£o Del Rei', NULL, NULL),
(90001, 1, '5365368-21.2026.8.09.0174', 'TJGO', 0, '2026-05-11 17:48:01', '2026-07-03 13:24:03', '2026-05-26 00:00:00', 'Resposta', 'Dahiana', 'Impugnar ImobiliÃ¡ria', NULL, NULL),
(120001, 1, '5292656-27.2026.8.09.0079', 'TJGO', 0, '2026-05-14 19:15:06', '2026-07-03 13:24:15', '2026-06-16 00:00:00', 'AudiÃªncia', 'Janes', 'Vara infancia e juventude', '15:30', NULL),
(150001, 1, '5292530-84.2026.8.09.0011', 'TJGO', 1, '2026-05-15 20:25:45', '2026-06-06 16:32:27', '2026-09-04 00:00:00', 'AudiÃªncia', 'Janes', 'ouvir Pedro', '15:00', NULL),
(180001, 1, '0010386-08.2026.8.27.2700', 'TJTO', 1, '2026-05-18 01:19:56', '2026-05-27 04:12:37', '2026-05-17 00:00:00', 'Outro', 'AILTON NAZARIO DOS SANTOS', 'Habeas Corpus', NULL, NULL),
(210001, 1, '5365368-21.2026.8.09.0174', 'TJGO', 0, '2026-05-19 12:53:52', '2026-05-27 02:45:10', '2026-05-26 00:00:00', NULL, 'Contestar', NULL, NULL, NULL),
(240001, 1, '5645405-08.2021.8.09.0051', 'TJGO', 1, '2026-05-24 17:04:40', '2026-05-24 17:04:40', '2026-06-18 00:00:00', 'Resposta', 'Marina/Talita - exigir contas', 'resposta - pedir julgamento ', NULL, NULL),
(270001, 1, '5468567-63.2026.8.09.0011', 'TJGO', 1, '2026-05-25 23:14:45', '2026-07-09 14:09:25', '2026-07-01 00:00:00', 'Autos conclusos', 'Jackeline - PA', 'Explicar valor da causa.', NULL, '2026-06-10 00:00:00'),
(300001, 1, '5367115-21.2025.8.09.0051', 'TJGO', 1, '2026-05-26 21:32:21', '2026-05-26 21:32:21', '2026-05-06 00:00:00', 'Outro', 'Gabriele', 'ExecuÃ§Ã£o trabalhista', NULL, NULL),
(330001, 1, '5940730-84.2025.8.09.0051', 'TJGO', 1, '2026-05-28 14:16:15', '2026-05-28 14:16:53', '2026-05-28 00:00:00', 'Outro', 'Paloma', 'processo educaÃ§Ã£o', NULL, NULL),
(360001, 1, '5536655-57.2023.8.09.0174', 'TJGO', 0, '2026-05-29 19:52:40', '2026-06-16 13:24:13', '2026-05-29 00:00:00', 'Autos conclusos', 'Dorizeth', 'Recurso ao STJ', NULL, NULL),
(360002, 1, '5303068-23.2026.8.09.0174', 'TJGO', 1, '2026-05-29 19:53:49', '2026-07-09 13:35:04', '2026-05-27 00:00:00', 'Autos conclusos', 'Dorizeth', 'Cumprimento de sentenÃ§a', NULL, NULL),
(390001, 1, '5248885-83.2026.8.09.0051', 'TJGO', 1, '2026-06-01 13:53:59', '2026-07-02 13:26:18', '2026-07-24 00:00:00', 'Resposta', 'NÃ¡gila', 'INTIMAÃ‡ÃƒO', NULL, '2026-07-03 00:00:00'),
(420001, 1, '5407735-95.2026.8.09.0130', 'TJGO', 1, '2026-06-07 14:45:19', '2026-06-07 14:45:19', '2026-06-07 00:00:00', 'Autos conclusos', 'Leidiane', 'Processo Saraiva X Leidiane', NULL, NULL),
(450001, 1, '0000964-05.2026.5.18.0018', 'TRT18', 1, '2026-06-08 13:29:10', '2026-06-08 13:29:10', '2026-07-07 00:00:00', 'AudiÃªncia', 'Honielly', NULL, '15:30', NULL),
(480001, 1, '1002034-62.2025.4.01.3500', 'TRF1', 1, '2026-06-11 22:36:31', '2026-06-11 22:36:31', '2026-06-11 00:00:00', 'Outro', 'KÃªnia', 'processo execuÃ§Ã£o fiscal\n', NULL, NULL),
(510001, 1, '6063041-37.2024.8.09.0011', 'TJGO', 1, '2026-06-15 21:11:04', '2026-06-15 21:35:04', '2026-07-21 00:00:00', 'AudiÃªncia', 'Jhons Santos', NULL, '15:00', NULL),
(540001, 1, '5606642-64.2023.8.09.0051', 'TJGO', 1, '2026-06-15 21:42:17', '2026-06-15 21:42:17', NULL, NULL, 'Elivelton', NULL, NULL, NULL),
(570001, 1, '5539206-09.2026.8.09.0011', 'TJGO', 1, '2026-06-16 13:05:08', '2026-06-23 13:54:48', '2026-07-16 00:00:00', 'Autos conclusos', 'Jackeline AI', 'Avaliar recurso', NULL, NULL),
(600001, 1, '5860013-85.2025.8.09.0051', 'TJGO', 1, '2026-06-23 12:24:59', '2026-06-23 12:24:59', '2026-06-29 00:00:00', 'Recurso', 'Kennya', 'Verificar se irÃ¡ recorrer.', NULL, NULL),
(630001, 1, '5622706-47.2026.8.09.0051', 'TJGO', 1, '2026-07-08 03:17:50', '2026-07-08 03:17:50', NULL, 'Autos conclusos', 'Honielly', 'Agravo de instrumento processo  5223008-93', NULL, NULL),
(660001, 1, '0000825-71.2024.8.27.2718', 'TJTO', 1, '2026-07-08 11:49:20', '2026-07-08 11:49:20', '2026-07-18 00:00:00', 'Resposta', 'PAULO SIMÃƒO', NULL, NULL, NULL),
(690001, 1, '5292656-27.2026.8.09.0079', 'TJGO', 1, '2026-07-08 14:24:28', '2026-07-08 14:24:28', NULL, NULL, 'Janes', NULL, NULL, NULL),
(720001, 1, '5624182-23.2026.8.09.0051', 'TJGO', 1, '2026-07-08 16:01:34', '2026-07-08 16:01:34', NULL, 'Autos conclusos', 'Lorenna Martins - DivÃ³rcio ', NULL, NULL, NULL);

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
  PRIMARY KEY (`id`) 
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
-- Dump concluÃ­do

-- --- MÓDULO CONTROLE DE PAGAMENTOS ---
-- ============================================================
-- Dump do banco de dados: Controle de Pagamentos de Clientes
-- Gerado em: 2026-07-10 21:17:14 UTC
-- Servidor: TiDB Serverless (compatÃ­vel com MySQL 8.0)
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
  PRIMARY KEY (`id`) ,
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
  PRIMARY KEY (`id`) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=210001;

-- Dados de `clients` (12 registros)
INSERT INTO `clients` (`id`, `name`, `totalFees`, `installmentCount`, `installmentValue`, `startDate`, `notes`, `createdAt`, `updatedAt`, `settledAt`) VALUES (1, 'MARLENE GONÃ‡ALVES', '15000.00', 30, '500.00', 1766588400000, NULL, '2026-06-23 22:57:37', '2026-06-24 17:20:08', NULL);
INSERT INTO `clients` (`id`, `name`, `totalFees`, `installmentCount`, `installmentValue`, `startDate`, `notes`, `createdAt`, `updatedAt`, `settledAt`) VALUES (30004, 'ELIMARA MARTINS', '6000.00', 15, '300.00', 1754665200000, NULL, '2026-06-24 14:04:08', '2026-06-24 14:04:08', NULL);
INSERT INTO `clients` (`id`, `name`, `totalFees`, `installmentCount`, `installmentValue`, `startDate`, `notes`, `createdAt`, `updatedAt`, `settledAt`) VALUES (30005, 'ANA CLARA BASTIEL', '500.00', 2, '250.00', 1777388400000, NULL, '2026-06-24 16:03:54', '2026-06-24 16:03:54', NULL);
INSERT INTO `clients` (`id`, `name`, `totalFees`, `installmentCount`, `installmentValue`, `startDate`, `notes`, `createdAt`, `updatedAt`, `settledAt`) VALUES (30009, 'KENNYA CINTIA', '18000.00', 20, '900.00', 1766502000000, NULL, '2026-06-24 16:36:33', '2026-06-24 17:21:50', NULL);
INSERT INTO `clients` (`id`, `name`, `totalFees`, `installmentCount`, `installmentValue`, `startDate`, `notes`, `createdAt`, `updatedAt`, `settledAt`) VALUES (30010, 'LEIDIANY', '5000.00', 5, '1000.00', 1764601200000, NULL, '2026-06-24 16:42:55', '2026-06-24 16:42:55', NULL);
INSERT INTO `clients` (`id`, `name`, `totalFees`, `installmentCount`, `installmentValue`, `startDate`, `notes`, `createdAt`, `updatedAt`, `settledAt`) VALUES (30011, 'PRISCILLA', '5000.00', 10, '500.00', 1768834800000, NULL, '2026-06-24 16:50:26', '2026-06-24 16:50:26', NULL);
INSERT INTO `clients` (`id`, `name`, `totalFees`, `installmentCount`, `installmentValue`, `startDate`, `notes`, `createdAt`, `updatedAt`, `settledAt`) VALUES (30012, 'LUCAS DE SOUZA', '1500.00', 3, '500.00', 1782918000000, NULL, '2026-06-24 17:06:46', '2026-06-24 17:06:46', NULL);
INSERT INTO `clients` (`id`, `name`, `totalFees`, `installmentCount`, `installmentValue`, `startDate`, `notes`, `createdAt`, `updatedAt`, `settledAt`) VALUES (60001, 'JOÃƒO LUÃS BATISTA', '10000.00', 10, '1000.00', 1778857200000, NULL, '2026-07-03 11:54:56', '2026-07-03 12:56:50', NULL);
INSERT INTO `clients` (`id`, `name`, `totalFees`, `installmentCount`, `installmentValue`, `startDate`, `notes`, `createdAt`, `updatedAt`, `settledAt`) VALUES (90001, 'THAIS REGINA', '5000.00', 10, '5000.00', 1762009200000, NULL, '2026-07-03 20:10:14', '2026-07-03 20:10:14', NULL);
INSERT INTO `clients` (`id`, `name`, `totalFees`, `installmentCount`, `installmentValue`, `startDate`, `notes`, `createdAt`, `updatedAt`, `settledAt`) VALUES (120001, 'NÃGILA BIANCA', '6000.00', 13, '400.00', 1780671600000, NULL, '2026-07-06 19:23:31', '2026-07-06 19:23:31', NULL);
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
  PRIMARY KEY (`id`) ,
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

SET FOREIGN_KEY_CHECKS = 1;

