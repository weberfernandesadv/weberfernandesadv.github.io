-- Weber Procuração — Dump completo do banco de dados
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
  PRIMARY KEY (`id`) /*T![clustered_index] CLUSTERED */
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=1020001;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contratos`
--

LOCK TABLES `contratos` WRITE;
/*!40000 ALTER TABLE `contratos` DISABLE KEYS */;
INSERT INTO `contratos` (`id`, `nome`, `genero`, `estadoCivil`, `profissao`, `cpf`, `rg`, `naturalidade`, `nomePai`, `nomeMae`, `rua`, `quadra`, `lote`, `setor`, `cidade`, `estado`, `cep`, `tipoAcao`, `tribunal`, `faseProcessual`, `valorTotal`, `valorEntrada`, `dataEntrada`, `numParcelas`, `valorParcela`, `dataPrimeiraParcela`, `dataContrato`, `criadoEm`, `status`, `downloadToken`, `observacoes`, `tipoContrato`, `valorTotalExtenso`, `valorEntradaExito`, `valorEntradaExitoExtenso`, `formaPagamentoEntrada`, `percentualExito`, `compensacao`, `percentualExitoPuro`, `criterioProveito`, `percentualExitoPuroExtenso`, `emailContratante`, `telefoneContratante`, `dataNascimentoContratante`, `numero`) VALUES (240002,'JOÃO LUIS CORREA BATISTA','brasileiro','divorciado(a)','Jornalista/Professor','434.758.251-04','1423424','GOIÂNIA-GO','Benedito Neder Batista','Jocilia de Jesus Correa da Costa','Consolação','','','CIDADE JARDIM','GOIÂNIA','GO','74425-535',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'15/06/2026','2026-06-15 20:26:37','pendente','a365f38c600b4139946071d4a7749ef1',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(270001,'ELISA DOS SANTOS ARAUJO','brasileira','solteiro(a)','ESTUDANTE','031.696.431-00','03169643100','Goiânia-GO','ELISEU LOPES DE ARAÚJO','ELAINE FRANCISCA DOS SANTOS','Paulo Bregaro','1','3','Maria Lourença','Goiânia','GO','74595-050',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'26/06/2026','2026-06-26 17:12:09','pendente','24c13d276fd54ce4acab30084bbaae25',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(300001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-06-29 22:33:29','pendente','0e4e02dfb03441b4b95240701d960daa',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(300002,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-06-29 22:34:16','pendente','4fcc724f037841829e7a22eba6d2269b',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(330001,'FRANCISCA MARIA DOS SANTOS BALDEZ','brasileira','solteiro(a)','TEC enfermagem','885.599.631-20','3625954 DGPC GO','Parnarama-MA','Orlando Baldez','Doracy dos santos Baldez','Avenida Manchester condomínio residencial metrópoles bloco damasco apto 204','00','00','Jardim novo mundo','Goiânia','GO','74702-755','Reconhecimento de união estável pós morten','tjgo','conhecimento','1500,00','00','07/08/2026',2,'750,00','07/09/2026','07/06/2026','2026-07-07 13:54:46','gerada','d5aaa0116b514ed1be6abd6d2bccbffa',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(360001,'MARIA BOMFIM LOPES DE OLIVEIRA','brasileira','casado(a)','Doméstica','583.779.801-34','2068936','Coribe-BA','Edmar Moreira Lopes','Mailde Bomfim Lopes','Rua cumprida','Qd 2b','Lote 04','Vila São Domingos triunfo 1','Goianira','GO','75369-198','Divórcio','TJGO','Conhecimento','6,000','1,000','06/07/2026',10,'500','06/08/2026','07/07/2026','2026-07-07 20:37:44','gerada','36d3cba3b35745ca87fc97a918addc12',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(360002,'SELMON RODRIGUES BATISTA','brasileiro','casado(a)','Autônomo','991.013.351-20','4324588','Ponte Alta do Norte-TO','Sérgio Alves Rodrigues','Selma dos Reis Alves Batista','Avenida Mangalô    n 1571','','','Morada do Sol','Goiânia','GO','74475-115','Rescisão de contrato imobiliário','TJGO','Conhecimento','3000,00','1000,00','05/07/2026',5,'600','05/08/2026','07/07/2026','2026-07-07 22:26:40','gerada','4810666a7c6842a18556f83555faa854',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(390001,'NÁGILA BIANCA ALVES MARIANO','brasileira','solteiro(a)','Limpeza doméstica','702.016.861-20','6086920','Goiânia-GO','Wellington Eustáquio Mariano','Eliane Alves de Souza','Rua b','13','2','Tremendão','Goiânia','GO','74475-020','Guarda','TJGO','Conhecimento','6000','500','05/06/2026',13,'400','05/07/2026','08/06/2028','2026-07-08 12:53:14','gerada','c0f12b661a5642839c82e010f8113388',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(420001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-08 13:08:55','pendente','0ef856b864514dc5960feeb687b45b2a',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(450001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-08 13:26:11','pendente','8aad8990-4b6c-4ad4-99dd-9d669e614263',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(450002,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-08 13:26:19','pendente','4ce6b27c-ce09-4408-b8d6-35bae697070d',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(480001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-08 16:23:53','pendente','f1cc8a8d-1f55-4950-9834-3ef7a0f53773',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(480002,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-08 16:28:05','pendente','c73c0390-6200-4a80-a495-4da84dc412e0',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(480003,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-08 16:49:56','pendente','8bc81ad8-176c-4df1-868d-75ea3b8d3121',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(480004,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-08 16:52:10','pendente','223ed37c-300b-4b6b-a485-20e55a1eef78',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(480005,'WEBER FERNANDES PEREIRA','brasileiro','casado(a)','ADV','888.950.123-13','3741411','SENADOR CANEDO-GO','WEBER FERNANDES PEREIRA','WEBER FERNANDES PEREIRA','RUA F9','1','3','Residencial Hebrom','SENADOR CANEDO','GO','75257-482','EXCECUÇÃO','TJGO','CONHECIMENTO',NULL,NULL,NULL,NULL,NULL,NULL,'08/07/2026','2026-07-08 16:59:48','gerada','bbec3afd-f7b5-43da-9d12-754c8832b7af',NULL,'exito_percentual',NULL,NULL,NULL,NULL,NULL,NULL,'30','valor da condenação líquida',NULL,NULL,NULL,NULL,NULL),(480006,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-08 17:17:06','pendente','ce5aef7c-0080-423c-869b-639fe3d74edd',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(510001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-08 19:53:51','pendente','b8a627ee-2e73-416f-a502-c17c8278c91b',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(540001,'WEBER FERNANDES PEREIRA','brasileiro','casado(a)','Adv','889.221.455-33','4556662','SENADOR CANEDO-GO','WEBER FERNANDES PEREIRA','WEBER FERNANDES PEREIRA','paulo breg','1','3','Residencial Hebrom','SENADOR CANEDO','GO','75257-482','ação de cobrança','TJGO','fase de conhecimento',NULL,NULL,NULL,NULL,NULL,NULL,'08/07/2026','2026-07-08 20:17:50','gerada','eaa745a3-4884-4a93-b1cb-67e08efe2f5d',NULL,'exito_percentual',NULL,NULL,NULL,NULL,NULL,NULL,'30','valor condenação',NULL,NULL,NULL,NULL,NULL),(540002,'WEBER FERNANDES PEREIRA','brasileiro','casado(a)','adv','777.888.555-56','8765454','SENADOR CANEDO-PA','Prof. Weber','Prof. Weber','ruaaa','1','3','Residencial Hebrom','SENADOR CANEDO','GO','75257-482','AÇÃO DE COBRANÇA','tjgo','fase de conhecimento',NULL,NULL,NULL,NULL,NULL,NULL,'08/07/2026','2026-07-08 20:24:08','gerada','0648e61c-9090-4da1-a018-72b9ec696fc3',NULL,'entrada_exito',NULL,'1500','um mil e quinhentos reais','À VISTA','20','NÃO',NULL,'25%',NULL,NULL,NULL,NULL,NULL),(540003,'WEBER FERNANDES PEREIRA','brasileiro','casado(a)','ADV','121.321.545-45','1212131','SENADOR CANEDO-ES','DIEGO SANTOS','MARIA SANTOS','PAULO BREGARO','1','3','Residencial Hebrom','SENADOR CANEDO','GO','75257-482','AÇÃO DE COBRANÇA','TJGO','AUDIENCIAS','3000','1000','08/07/2026',2,NULL,'10/07/2026','08/07/2026','2026-07-08 20:31:41','gerada','4408ad6d-7054-4c48-81c4-7cf2322f67cf',NULL,'valor_fixo','TRES MIL REAIS',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(540004,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-08 20:52:34','pendente','a658e280-fdc6-4032-97e9-ca9d67ad663c',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(540005,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-08 20:56:34','pendente','53bc07e7-cb39-4844-a171-16e2e7e272f2',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(540006,'wfkjeojfaoewo','brasileiro','solteiro(a)','orif','000.000.000-00','12346485','goiânia-GO','elvis jikjo','Alzira xy','fkjeoi','efe','5','finso','Goiânia','GO','74000-000','EXECUÇÃO','TJGO','INICIAL','3000,00','1000,00','08/07/2026',8,NULL,'08/08/2026','08/07/2026','2026-07-08 21:12:44','gerada','c20d1976-2c6c-4041-9992-65e62a25116c',NULL,'valor_fixo','Três mil reais',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(570001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-08 21:53:48','pendente','d84ca805-f5c6-43ec-aaa3-03351d766a0f',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(600001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-08 22:05:39','pendente','8bce0078-4b45-4d38-9521-e141dc4bd916',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(630001,'chica chica','brasileiro','solteiro(a)','feageafe','000.000.000-00','1234567','Goiânia-GO','faeafeed dfeee','frterfe gfefe','rua x','1','2','finsocial','Goiânia','GO','74000-000','execução','tjgo','conhecimento',NULL,NULL,NULL,NULL,NULL,NULL,'08/07/2026','2026-07-08 22:06:49','gerada','443c5a48-f215-4221-94b5-465cf4df51cc',NULL,'exito_percentual',NULL,NULL,NULL,NULL,NULL,NULL,'30','valor da condenação',NULL,NULL,NULL,NULL,NULL),(630002,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-08 22:08:51','pendente','b8e442f4-9859-48a1-9e13-dac3161fa91c',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(630003,'FRANCISCA MARIA DA SILVA','feminino','solteira','professora','123.456.789-00','1234567','Goiânia/GO','João da Silva','Maria da Silva','Rua das Flores, 123, Apto 1','','','Setor Central','Goiânia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/07/2026','2026-07-08 22:09:17','pendente','f7c22471-d48a-40f8-b4e1-92b7315c5558',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(660001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-08 22:12:30','pendente','701e513a-263c-4d15-872c-6ca80197eae2',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(660002,'GFADAERF','brasileiro','solteiro(a)','FAEFAEW','000.000.000-00','1234567','GOIÂNIA-GO','FAEAFEFAE EDFE','FADTEFE FRFES','RUA  X','2','5','FINSOC','GOIÂNIA','GO','74000-000','EXECUÇÃO','TJGO','CONHECIMENTO','3000','1000','08/07/2026',8,NULL,'08/08/2026','08/07/2026','2026-07-08 22:17:05','gerada','c79b2346-07f7-4346-b63c-c894fb4c3a3a',NULL,'valor_fixo','Três mil Reais',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(660003,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','alimentos','tjgo','conhecimento','3000','1000','08/07/2026',8,NULL,'08/08/2026','08/06/2026','2026-07-08 22:58:11','gerada','0bfb43fb-a0b5-4026-a556-0995151a9ad7',NULL,'valor_fixo','três mil reais',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(660004,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-08 23:24:38','pendente','ed72be65-e184-443a-a680-855a1844c29a',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(660005,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-08 23:25:25','pendente','63d131ce-cd45-438e-b459-2dc47bb3dd64',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(690001,'maria birtis','brasileiro','solteiro(a)','professor','000.000.000-00','1234567','Goiânia-GO','Evo few','few evo','rua x','01','02','cas','goiânia','GO','74000-000','execução','tjgo','conhecimento','3000','1000','08/07/2026',8,NULL,'08/08/2026','08/07/2026','2026-07-09 02:22:47','gerada','544290d0-a456-4c37-be65-5569d9c6493b',NULL,'valor_fixo','três mil reais',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(690002,'MARIA DA SILVA TESTE','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores',NULL,NULL,'Setor Central','Goiânia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/07/2026','2026-07-09 02:28:05','pendente','5b698409-0574-4e4f-a66b-9d457422c272',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(690003,'chica mari','brasileiro','solteiro(a)','coman','000.000.000-00','1234567','Goiânia-GO','chico j','j chica','rua x','01','02','cent','Goiânia','GO','74000-000','execução','tjgo','citação','4000','1000','08/07/2026',10,NULL,'08/08/2026','08/07/2026','2026-07-09 02:34:14','gerada','00a5f422-bde2-4828-8fc4-2f749c7e88db',NULL,'valor_fixo','quatro mil reais',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(690004,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-09 02:41:44','pendente','81b51658-689d-4a75-8151-04021d94c531',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(690005,'CHICA MARIA TESTE','brasileira','solteira','professora','111.222.333-44','9876543','Goiânia-GO','José da Silva','Maria da Silva','Rua das Acácias',NULL,NULL,'Setor Bueno','Goiânia','GO','74000-100',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/07/2026','2026-07-09 02:42:18','pendente','986b7527-8649-4ae6-8b6a-dc5489089ca0',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(690006,'CHICA MARIA TESTE','brasileira','solteira','professora','111.222.333-44','9876543','Goiânia-GO','José da Silva','Maria da Silva','Rua das Acácias, 456',NULL,NULL,'Setor Bueno','Goiânia','GO','74000100','ação de divórcio',NULL,'fase de conhecimento e recursal','5.000,00','2.000,00',NULL,NULL,'1.000,00',NULL,'08/07/2026','2026-07-09 02:45:13','gerada','test-token-1783565113309',NULL,'valor_fixo','cinco mil reais',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(690007,'CHICA MARIA TESTE','brasileira','solteira','professora','111.222.333-44','9876543','Goiânia-GO','José da Silva','Maria da Silva','Rua das Acácias, 456',NULL,NULL,'Setor Bueno','Goiânia','GO','74000100','ação de divórcio',NULL,'fase de conhecimento e recursal','5.000,00','2.000,00',NULL,NULL,'1.000,00',NULL,'08/07/2026','2026-07-09 02:45:32','gerada','test-token-1783565132319',NULL,'valor_fixo','cinco mil reais',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(690008,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','execução','TJGO','conhecimento','3000','1000','08/07/2026',5,NULL,'','08/06/2026','2026-07-09 02:45:55','gerada','9193b82a-7c9a-4e31-a38d-ff0a98b82bff',NULL,'valor_fixo','três mil reais',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(720001,'JFEOJEO','brasileiro','solteiro(a)','FAEFAE','000.000.000-00','1234567','Goiânia-GO','j sleofjoe','sjojoe jeofe','rua x','2','23','fjoejfapewo','Goiânia','GO','74000-000','exec','tjgo','conhec','5000','2000','08/07/2026',1,NULL,'08/08/2026','08/07/2026','2026-07-09 02:55:59','gerada','d0ee8ae0-984f-4ecd-9c42-a7cf045723e6',NULL,'valor_fixo','cinco mil reais',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(720002,'gfare grfaewr','brasileiro','solteiro(a)','feae','000.000.000-00','11111111','goiÂNIA-GO','afaev rfgr','hrgrb grgrs','av. 5','1','2','afçj eoe','Goiânia','GO','74000-000','exec','tjgo','adu',NULL,NULL,NULL,NULL,NULL,NULL,'09/07/2026','2026-07-09 03:01:51','gerada','ea537b3e-5848-4031-b848-0a5ab813c2b7',NULL,'exito_percentual',NULL,NULL,NULL,NULL,NULL,NULL,'30','montante recebido',NULL,NULL,NULL,NULL,NULL),(720003,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-09 03:13:37','pendente','9b44b6fd-7d32-4a14-b404-576812a0098c',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(720004,'MARIA TESTE SILVA','brasileira','solteira','professora','111.222.333-44','9876543','Goiânia-GO','José da Silva','Maria da Silva','Rua das Acácias, 456',NULL,NULL,'Setor Bueno','Goiânia','GO','74000100','ação trabalhista','TRT 18ª Região','fase de conhecimento',NULL,NULL,NULL,NULL,NULL,NULL,'09/07/2026','2026-07-09 03:13:58','pendente','test-exito-perc-1783566837859',NULL,'exito_percentual',NULL,NULL,NULL,NULL,NULL,NULL,'30','valor da condenação líquida','trinta',NULL,NULL,NULL,NULL),(720005,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-09 03:14:50','pendente','c2d1d612-ddd8-4bf5-a041-b177eddc5057',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(750001,'SELMON RODRIGUES BATISTA','brasileiro','casado(a)','Autônomo','991.013.351-20','4324588','Ponte Alta do Norte-TO','Sérgio Alves Rodrigues ','Selma dos Reis Alves Batista','Avenida Mangalô, 1571','','','Morada do Sol','Goiânia','GO','74475-115','Distrato Imobiliário','TJGO','Conhecimento',NULL,NULL,NULL,NULL,NULL,NULL,'10/07/2026','2026-07-10 11:35:28','gerada','69f71547-2a70-4feb-95b0-2c554788b4b2',NULL,'exito_percentual',NULL,NULL,NULL,NULL,NULL,NULL,'30','Valor da condenação','Trinta',NULL,NULL,NULL,NULL),(780001,'feafd afre','brasileiro','solteiro(a)','faefae','000.000.000-00','1234564567','Goiânia-GO','grfwefs','fejlkfaje','rua x','1','2','vila finsocial','Goiânia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'10/07/2026','2026-07-10 12:28:04','pendente','aeec137d-0cf8-4453-b347-6072d948e92f',NULL,'exito_percentual',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(810001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-10 12:46:28','pendente','19e6949c-e03b-46fe-8b20-b25f516c342f',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(840001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-10 12:48:29','pendente','a725812d-f03c-4ec2-ac35-fea541f79576',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(870001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-10 12:58:58','pendente','d71a4a19-6ed4-4b20-a917-3e88daa44f5a',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(900001,'Carlos Eduardo Mendonça Alves','brasileiro','casado(a)','Engenheiro Civil','543.210.987-65','4567890','Goiânia-GO','José Mendonça Alves','Ana Paula Mendonça','Avenida T-63','Q-15','L-8','Setor Bueno','Goiânia','GO','74230-030',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'10/07/2026','2026-07-10 13:04:10','pendente','da52a1fb-d66a-4617-b664-3cf94256b85f',NULL,'exito_percentual',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'carlos.mendonca@email.com','(62) 99876-5432','15/04/1985','1200'),(930001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-10 13:06:25','pendente','0c390cdf-a396-4bc6-bf99-6038284ed59f',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(960001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-10 13:53:11','pendente','03380167-4393-4cfb-a221-17ff7f56e90f',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(990001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'08/06/2026','2026-07-10 13:58:34','pendente','7646f55a-3b0d-4701-bed4-06197f33d6c7',NULL,'valor_fixo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
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
  PRIMARY KEY (`id`) /*T![clustered_index] CLUSTERED */
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=750001;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `declaracoes`
--

LOCK TABLES `declaracoes` WRITE;
/*!40000 ALTER TABLE `declaracoes` DISABLE KEYS */;
INSERT INTO `declaracoes` (`id`, `nome`, `genero`, `estadoCivil`, `profissao`, `cpf`, `rg`, `naturalidade`, `nomePai`, `nomeMae`, `rua`, `quadra`, `lote`, `setor`, `cidade`, `estado`, `cep`, `dataDeclaracao`, `criadoEm`, `status`, `downloadToken`, `observacoes`, `numero`) VALUES (1,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-06-09 01:37:22','gerada','f52dd2fb52394be386f907c7a2310a5d',NULL,NULL),(2,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-06-09 01:37:22','pendente','2388e1a42aa745ab891919a3f1963e3a',NULL,NULL),(3,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-06-09 01:37:31','pendente','0582a27505604930a3214802c5ce220e',NULL,NULL),(4,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-06-09 01:37:31','pendente','0e88b9c9d0664ae1a40960d5a3eeb9b8',NULL,NULL),(5,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-06-09 01:38:22','pendente','e5e6e194f88847d7a0f0a297bcae9292',NULL,NULL),(30001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-06-09 02:13:24','pendente','3c6329cfa72c4230a67d966ff1339502',NULL,NULL),(30002,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-06-09 02:14:43','pendente','476f048acdc64f77ab237d163c3426b1',NULL,NULL),(30003,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-06-09 02:29:11','pendente','7887ba434a3e465c8495b8be97a5c67f',NULL,NULL),(30004,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-06-09 02:31:04','pendente','6dbaf6b2e0b84cdd8c2b82fa113bf1d0',NULL,NULL),(60001,'FADAEFA','brasileiro','casado(a)','professor','111.111.111-11','13213216','goiânia','fjjoefoe','jfoeiphgeopi','x10','de','13','fajfeiofeof','goiânia','go','74473-010','08/06/2026','2026-06-09 02:51:12','pendente','38257997ae1d40cc892d0d89eb9fc862',NULL,NULL),(90001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-06-09 03:43:41','pendente','6b102805189e4b3b949f38e0fa25647f',NULL,NULL),(90002,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-06-09 03:43:55','pendente','c4d8d66544354cf390d5a5a16c8c8f8b',NULL,NULL),(90003,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-06-09 03:44:30','pendente','27bbcd575993468d9fdb74de9dddfb34',NULL,NULL),(120001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-06-15 15:08:14','pendente','b9fbb0353b3844019b56367533ed6afe',NULL,NULL),(120002,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-06-15 15:08:25','pendente','ad97a033108b4433a2c5a7707876f254',NULL,NULL),(120003,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-06-15 15:16:58','pendente','cea320b0d52b414bbefa1ed1337f0414',NULL,NULL),(120004,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-06-15 15:17:06','pendente','9e483bc55aae4dd196acc24b416c22f5',NULL,NULL),(120005,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-06-15 15:18:20','pendente','f18e292c056a41f393c9a89ad43201da',NULL,NULL),(120006,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-06-15 15:18:28','pendente','ea62ee4684cc42c6b684135e1b769ccf',NULL,NULL),(120007,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-06-15 15:21:37','pendente','59c287783bdf463d87deb4543929161e',NULL,NULL),(120008,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-06-15 16:04:33','pendente','92e057a422cc4d9a84ff95ed325ee48d',NULL,NULL),(120009,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-06-15 16:55:15','pendente','38a1a804a8eb418ba6e5edc76ed2fdcf',NULL,NULL),(120010,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-06-15 16:59:06','pendente','df093735c53c41d2aa1dfae7b970b9f5',NULL,NULL),(150001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-06-29 22:33:29','pendente','5c37f305fccc4243b84a0f201bb8ef6f',NULL,NULL),(150002,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-06-29 22:34:16','pendente','408bd9e4dfeb42eca1a7b4a572e85701',NULL,NULL),(180001,'FRANCISCA MARIA DOS SANTOS BALDEZ','brasileira','solteiro(a)','TEC.enfermagem','885.599.631-20','3625954   DGPC','Parnarama-MA','Orlando Baldez','Doracy dos santos Baldez','Avenida Manchester condomínio residencial metrópoles bloco damasco apto 204','00','00','Jardim novo mundo','Goiânia','GO','74702-755','07/06/2026','2026-07-07 13:45:55','gerada','77aa5c3a11ec4c0bb3acdc819f31a81f',NULL,NULL),(210001,'ELISA DOS SANTOS ARAÚJO','brasileira','solteiro(a)','ESTUDANTE','031.696.431-00','03169643100','Goiânia-GO','ELISEU LOPES DE ARAÚJO','ELAINE FRANCISCA DOS SANTOS','RUA PAULO BREGARO','1','3','MARIA LOURENÇA','Goiânia','GO','74595-050','07/07/2026','2026-07-07 18:53:30','gerada','0838313296d54ffe9fd6746a9498d87c',NULL,NULL),(240001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-07-08 13:08:55','pendente','08291e99b97d4841b2f6c92d5fbbddfa',NULL,NULL),(270001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-07-08 13:26:11','pendente','82983c4c-31d6-4bf0-84e1-4892728cdc42',NULL,NULL),(270002,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-07-08 13:26:19','pendente','f4ef5242-a98d-447d-aade-3e70d3ac13ee',NULL,NULL),(300001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-07-08 16:23:53','pendente','9f7e4582-1de8-40d7-951f-bdb700ee1e43',NULL,NULL),(300002,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-07-08 16:28:05','pendente','2527a43e-d884-43d7-98bf-35465fb39c9e',NULL,NULL),(300003,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-07-08 16:49:56','pendente','ae852369-8d2e-46cb-ad0f-0fb33a649e6a',NULL,NULL),(300004,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-07-08 16:52:10','pendente','e7134074-e426-4643-8ad8-5e19a9a415ca',NULL,NULL),(300005,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-07-08 17:17:07','pendente','35f1260b-6d34-45c4-9f4f-e04644e82281',NULL,NULL),(330001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-07-08 19:53:52','pendente','49700b16-8515-48b7-ad69-6b68ea833691',NULL,NULL),(360001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-07-08 20:52:35','pendente','232d3427-68f0-4419-bf07-895f5b5cbeeb',NULL,NULL),(360002,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-07-08 20:56:34','pendente','0dbf20f3-cd16-4ff1-a291-585b1e2a6bb1',NULL,NULL),(390001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-07-08 21:53:49','pendente','91842956-cd66-4889-9c5b-4bdd0efe2017',NULL,NULL),(420001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-07-08 22:05:39','pendente','b415e023-b743-434c-a324-4ac3c1f2e2d0',NULL,NULL),(450001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-07-08 22:08:51','pendente','55448f5f-e212-489f-b0c9-5392867a3ec0',NULL,NULL),(480001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-07-08 22:12:30','pendente','2105b0bf-dece-442b-814f-e22ede83cb11',NULL,NULL),(480002,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-07-08 22:58:11','pendente','54af11b4-db03-4c35-8808-662c38768e7e',NULL,NULL),(480003,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-07-08 23:24:38','pendente','6ca9e884-b80b-41b3-bada-1897c13c8064',NULL,NULL),(480004,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-07-08 23:25:25','pendente','66a9181c-3518-4b5d-9b4a-2e389d98c5df',NULL,NULL),(510001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-07-09 02:41:44','pendente','fb785989-6f4c-4213-ba6e-0d1f0ebb697c',NULL,NULL),(510002,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-07-09 02:45:55','pendente','bb383277-4858-41e9-bf9c-67b0655d185a',NULL,NULL),(540001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-07-09 03:13:37','pendente','f490f9da-5a33-4c32-8e1c-594a2728e897',NULL,NULL),(540002,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-07-09 03:14:50','pendente','9152efac-1dba-4dda-b73e-c39bd5e131f9',NULL,NULL),(570001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-07-10 12:46:28','pendente','55e1c8ca-6fe2-488d-a2af-b4e155ea81b0',NULL,NULL),(600001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-07-10 12:48:29','pendente','2ced8043-bf1d-434e-b98c-48c0e8eaa160',NULL,NULL),(630001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-07-10 12:58:58','pendente','fa0d78f4-cd11-4210-a620-73e5cfadf0d7',NULL,NULL),(660001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-07-10 13:06:25','pendente','2f0b733d-43ac-4692-88c9-396b4501c537',NULL,NULL),(690001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-07-10 13:53:11','pendente','5b1566e5-510a-498e-adcc-be9744fe7750',NULL,NULL),(720001,'MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','08/06/2026','2026-07-10 13:58:35','pendente','2bd17c23-e98a-48dc-9bd1-4ee188cf39b8',NULL,NULL);
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
  PRIMARY KEY (`id`) /*T![clustered_index] CLUSTERED */,
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
  PRIMARY KEY (`id`) /*T![clustered_index] CLUSTERED */
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=1020001;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `procuracoes`
--

LOCK TABLES `procuracoes` WRITE;
/*!40000 ALTER TABLE `procuracoes` DISABLE KEYS */;
INSERT INTO `procuracoes` (`id`, `nome`, `genero`, `estadoCivil`, `profissao`, `cpf`, `naturalidade`, `filiacao`, `rua`, `quadra`, `lote`, `cidade`, `cep`, `criadoEm`, `status`, `downloadToken`, `observacoes`, `numero`, `setor`, `estado`, `dataAssinatura`, `rg`, `data_nascimento`, `email`, `telefone`) VALUES (1,'WEBER FERNANDES PEREIRA','brasileiro','casado(a)','Porte','889.501.231-34','Goiânia','Alzira Maria','Av. Adriano Auad, 00, Q. 02, L. 02','10','6','SENADOR CANEDO','75257-482','2026-05-14 21:16:09','pendente',NULL,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(30001,'WEBER FERNANDES PEREIRA','brasileiro','viúvo(a)','Porte','889.501.231-34','Goiânia','Alzira Maria','Av. Adriano Auad, 00, Q. 02, L. 02','10','6','SENADOR CANEDO','75257-482','2026-05-14 21:28:39','pendente',NULL,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(60001,'LEONILDO BRITO OLIVEIRA','brasileiro','solteiro(a)','Professor','019.434.441-02','Marabá Pa','Aurenides da Silva Brito e Gelson Jesus de Oliveira','Avenida Santa Terezinha','01','7/8','Aparecida de Goiânia','74948-731','2026-05-14 21:37:37','pendente',NULL,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(90001,'WEBER FERNANDES PEREIRA','brasileiro','solteiro(a)','professor','889.501.231-34','Goiânia-GO','alzira fernandes','Av. Adriano Auad, 00, Q. 02, L. 02','10','05','SENADOR CANEDO','75257-482','2026-05-15 14:22:35','pendente',NULL,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(120001,'WEBER FERNANDES PEREIRA','brasileira','solteiro(a)','professor','889.501.231-34','Goiânia-GO','alzira fernandes','Av. Adriano Auad, 00, Q. 02, L. 02','10','05','SENADOR CANEDO','75257-482','2026-05-15 16:43:11','pendente',NULL,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(150001,'WEBER FERNANDES PEREIRA','brasileiro','união estável','professor','889.501.231-34','Goiânia-GO','alzira fernandes','Av. Adriano Auad, 00, Q. 02, L. 02','10','05','SENADOR CANEDO','75257-482','2026-05-15 17:18:36','pendente',NULL,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(180001,'WEBER FERNANDES PEREIRA','brasileiro','solteiro(a)','professor','889.501.231-34','Goiânia-GO','alzira fernandes','Av. Adriano Auad, 00, Q. 02, L. 02','10','05','SENADOR CANEDO','75257-482','2026-05-15 17:33:14','gerada','46fdf2ba2bd54cf89768deefbf1c55e9',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(210001,'MARIA DE FATIMA DA SILVA LIRA','brasileira','divorciado(a)','Professora','896.110.801-82','Carolina MA','David Dias Lira, Maria da Silva Lira','Rua j','212','14','Goiânia','74475-090','2026-05-15 19:26:59','gerada','9315c3341ea34f9bb0457cc869d4fb0e',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(240001,'ELIVELTON VIEIRA DOS SANTOS','brasileiro','casado(a)','Professor','037.109.541-77','Goiânia','Clarice Pereira Vieira Dos Santos','Rua 08','04','22','Goianira','75364-082','2026-05-15 19:45:32','gerada','abc736e241d141ed8a4682d83817a2ce',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(270001,'JESSICA LORANE SANTOS PEREIRA','brasileira','solteiro(a)','Professora','029.939.991-50','Itapuranga-GO','Mario Roque Pereira/ Eni Batista dos Santos','Rua 08','11','10','Goianira','75363-264','2026-05-15 20:11:08','gerada','5ab92ec0de114ea9bcfe3833f6296ba6',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(300001,'LEONILDO BRITO OLIVEIRA','brasileiro','solteiro(a)','Professor','019.434.441-02','Marabá Pa','Aurenides da Silva Brito e Gelson Jesus de Oliveira','Avenida Santa Terezinha','01','7/8','Aparecida de Goiânia','74948-731','2026-05-15 20:38:39','gerada','a2ecb847a351449c8c18f7c34848d229',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(330001,'PALOMA VIANA DE CASTRO','brasileira','solteiro(a)','Professora','037.510.891-28','Goiânia -GO','José Martins de Castro Filho e Maria de Fátima Viana Castro','Rua Patrocínio Viana','Ch','78C','Goiânia -GO','74686-027','2026-05-15 23:01:52','gerada','7a42105d2b72427b8632e524f888d8c9',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(360001,'AILTON NAZARIO DOS SANTOS','brasileiro','solteiro(a)','sereiro','029.311.641-51','Miracema do tocantins','Maria odelite nazario dós santos','rua transversal','39','11','Goiânia','74475-520','2026-05-17 12:55:49','gerada','bcc57b13957d481fb0edbc0495681113',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(390001,'VICTOR RICARDO ALVES BATISTA','brasileiro','divorciado(a)','Promotor de eventos','038.671.071-65','Goiânia','Gilmar aparicido batista  maria de Fátima alves caitanob','Estrada114','Área LT','Casa 25','Goiânia','74470-220','2026-05-19 20:03:02','gerada','2f501ec7b68a4f3da813a93727944713',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(420001,'TAYNARA DE OLIVEIRA E SILVA','brasileira','casado(a)','Professora','032.921.011-40','Palmas- TO','Selma Maria de Oliveira e Silva','Rua jc 04','Qd 32','Lt 12','Goiânia','74480-470','2026-05-20 15:24:51','pendente','446ef45a464445fbb0ac518a44068d8d',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(450001,'TAYNARA DE OLIVEIRA E SILVA','brasileira','casado(a)','Professora','032.921.011-40','Palmas-TO','Selma Maria de Oliveira e Silva','Rua jc 04','32','12','Goiânia-GO','74480-470','2026-05-21 21:19:06','gerada','a5d0d313673c4ed2a42adbdffceb7fe9',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(480001,'DANIEL COSTA BESSA','brasileiro','solteiro(a)','Nenhuma','126.389.991-99','Goiânia','Jackeline Costa Miranda','Rua Ismael de Souza','153','02','Goiânia','74922-694','2026-05-26 19:50:22','gerada','44be6d701712443784103d78e4f8e559',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(510001,'KATIA MARTINS DE CASTRO','brasileira','solteiro(a)','Professora','713.361.921-00','Go-Anápolis','Brasil','54 S/N','01','03','Goiania','74463-830','2026-05-31 16:01:21','pendente','83d085c4c19a413480625106d17266c3',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(540001,'GUILHERME EVANGELISTA DE ALMEIDA','brasileiro','divorciado(a)','POLICIAL MILITAR','010.139.541-81','Goiania-GO','Silvia vaz de almeida e Enock Nogueira Andrade','RUA C 156','407','07','GOIÂNIA','74354-628','2026-06-02 00:22:11','gerada','b9094df4a1574f2e94a81c01cd829ecd',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(540002,'GUILHERME EVANGELISTA DE ALMEIDA','brasileiro','divorciado(a)','POLICIAL MILITAR','010.139.541-81','Goiania-GO','Silvia vaz de almeida e Enock Nogueira Andrade','RUA C 156','407','07','GOIÂNIA','74354-628','2026-06-02 00:23:54','pendente','08b8a765e6354374aa3a225eed9233c4',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(570001,'JORDEAN SILVA CARNEIRO','brasileiro','solteiro(a)','auxiliar de serviço gerais','065.430.123-90','Maranhão','Josias Miranda carneiro Tânia Maria Silva carneiro','Setor Alto do Vale, Rua Alv. 01','Q23','27','Goiânia','74594-076','2026-06-06 21:37:35','gerada','c6396e6602684918b263090175b2b1f9',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(600001,'MONIQUE DE PAULA SOUZA RODRIGUES','brasileira','solteiro(a)','Auxiliar de serviço gerais','000.072.402-52','Ourém PA','Paulo Cardoso Rodrigues Margarida de Souza lisboa','Setor Alto do Vale, Rua Alv. 01','Q23','27','Goiânia','74594-076','2026-06-06 22:11:24','gerada','2be6f9c498d2410ababe5b623fc29b80',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(630001,'FSEFSFSEF','brasileiro','casado(a)','professor','111.111.111-11','Goiânia-go','elvvs fejfoe e Alzira','rua vf 09','6a','13','goiânia go','74473-070','2026-06-09 02:36:38','gerada','3ff27509babe4c94a41234ac89ab1f4b',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(660001,'KENNYA CINTIA DE CASTRO','brasileira','casado(a)','Professora','337.041.981-53','Catalão-GO','Olair de Castro Rosa, Waldir Gonçalves de Castro','Rua 9','','','Goiânia','74040-013','2026-06-11 22:05:39','gerada','de1b40dfc9c9478a830bb876d18c13f4',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(690001,'JOÃO LUIS CORREA BATISTA','brasileiro','divorciado(a)','Jornalista/Professor','434.758.251-04','GOIÂNIA-GO','Jocilia de Jesus Correa da Costa - Benedito Neder Batista','Avenida Consolação, Apto 101 Ponto de referência: Shopping Cerrado','','','GOIÂNIA','74425-535','2026-06-12 13:44:52','gerada','3cdfaa471a9c4afbbe3caabc820df750',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(720001,'FGAWEFAWE','brasileiro','solteiro(a)','genge','889.501.231-34','Goiânia-GO','elvvs fejfoe e Alzira','VF. 09','6a','13','Goiânia','74473-070','2026-06-15 14:21:21','gerada','68e907a233014be3944cc258e5560e49',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(750001,'DIVINA D ARC MOREIRA DE OLIVEIRA','brasileira','solteiro(a)','Professora','764.546.811-49','Goiânia-GO','Maria Félix Moreira de Oliveira e Benjamin Rodrigues de Oliveira','Rua CP34','51','19','Goiânia','74477-247','2026-06-18 20:21:31','gerada','16833ae6b9104457a626ee2e22c88221',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(780001,'ELISA DOS SANTOS ARAÚJO','brasileira','solteiro(a)','Estudante','031.696.431-00','Goiânia-GO','Elaine Francisca dos Santos','Paulo Bregaro','1','3','Goiania','74595-050','2026-06-19 17:36:22','gerada','51c4d9fb893e492f86bf417e350e78f6',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(810001,'GLAUCIA ANDRÉIA RAMOS DA SILVA','brasileira','casado(a)','Funcionária Pública','972.943.651-72','Goiânia-GO','Benedita de Paula Ramos  e Eloisio de Araújo Silva','Avenida Mangalo n.1571','','','Goiânia','74475-115','2026-06-20 17:10:27','gerada','24cb21fa2f56406489beba83588fe04f',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(840001,'SELMON RODRIGUES BATISTA','brasileiro','casado(a)','Autônomo','991.013.351-20','Ponte Alta do Norte-TO','Sério Alves Rodrigues e Selma dos Reis Alves Batista','Avenida Mangalô 1571','','','Goiânia','74475-080','2026-06-20 17:16:04','gerada','a40d3a21a36f4ac5a77959ff0f837ed8',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(870001,'NILTA MENDES DA SILVA BORGES','brasileira','casado(a)','PROFESSORA','138.957.688-47','CURVELO-MG','NATALINO MENDES DA SILVA E MARIA IRES DA SILVA','AV. CONSOLAÇÃO AP. 103 BLOCO B03 CONDOMINIO AGUAS CLARAS','00','00','GOIANIA','74425-535','2026-06-25 10:26:55','gerada','d81bb9abd71d45d5aee3279f7fdd1d94',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(900001,'LUCAS ADAIR SPOLTI','brasileiro','solteiro(a)','es','088.440.569-92','Treze Tílias-SC','Ronaldo Spolti','Rua Gisela Thaler, 304','01','01','fe','89650-000','2026-06-25 16:15:18','gerada','113caef2b60b4a27990785deca266484',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(930001,'DAHIANA SOUSA PINTO PORTELA','brasileira','casado(a)','Do lar','898.102.011-68','Barra do garças-MT','Marisa Sousa otto','Rua Adriano auad','Qd 02','02','Senador canedo','75257-482','2026-07-03 12:19:44','gerada','ee9ce974594645f9b74644ceb80db9e9',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(930002,'DAHIANA SOUSA PINTO PORTELA','brasileira','separado(a) judicialmente','Do lar','898.102.011-68','Barra do garças-MT','Marisa Sousa otto','Rua Adriano auad','02','02','Senador canedo','75257-452','2026-07-03 12:22:33','gerada','0df303490b1b4b1a813d8cf80544f070',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(960001,'MARIA BOMFIM LOPES DE OLIVEIRA','brasileira','casado(a)','Doméstica','583.779.801-34','Coribe Bahia-BA','Mailde Bomfim Lopes ,Edmar Moreira Lopes','Rua cumprida qd 2B lote 04','Qd 2b','04','Goianira','75369-198','2026-07-06 21:15:19','gerada','b37869f6d8654bcfb6a97872a45589ee',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL),(990001,'FRANCISCA MARIA DOS SANTOS BALDEZ','brasileira','solteiro(a)','TEC  enfermagem','885.599.631-20','Parnarama-MA','Orlando Baldez/ Doracy dos santos Baldez','Avenida Manchester Fazenda Botafogo S/N, damasco apto 204','00','00','Goiânia','74702-755','2026-07-07 13:40:20','gerada','51f6ae2b6e2e452b9e90a8d5057e96d9',NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL);
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
  PRIMARY KEY (`id`) /*T![clustered_index] CLUSTERED */
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=690001;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `procuracoes_pa`
--

LOCK TABLES `procuracoes_pa` WRITE;
/*!40000 ALTER TABLE `procuracoes_pa` DISABLE KEYS */;
INSERT INTO `procuracoes_pa` (`id`, `nomeMenor`, `cpfMenor`, `dataNascimento`, `nome`, `genero`, `estadoCivil`, `profissao`, `cpf`, `rg`, `naturalidade`, `nomePai`, `nomeMae`, `rua`, `quadra`, `lote`, `setor`, `cidade`, `estado`, `cep`, `criadoEm`, `status`, `downloadToken`, `observacoes`, `numero`, `orgao_expedidor`, `email`, `telefone`) VALUES (1,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-06-09 01:37:22','gerada','2a3cadae3d864e9da7984bd5aa3422f5',NULL,NULL,'','',''),(2,'ANA BEATRIZ DA SILVA','111.222.333-44','20/01/2022','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-06-09 01:37:22','pendente','3d2a8a59ed4348a795e19e71970555ae',NULL,NULL,'','',''),(3,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-06-09 01:37:31','pendente','0e40197d68dd42cd8f6180911e1d0752',NULL,NULL,'','',''),(4,'ANA BEATRIZ DA SILVA','111.222.333-44','20/01/2022','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-06-09 01:37:31','pendente','60c5681083684b7bbff4fc8e27413e2b',NULL,NULL,'','',''),(5,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-06-09 01:38:22','pendente','8eca5b0d2c364b0bb6b39b22564bcef5',NULL,NULL,'','',''),(30001,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-06-09 02:13:24','pendente','aedb439238dd4c579c44c5ecbe66fd9b',NULL,NULL,'','',''),(30002,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-06-09 02:14:43','pendente','fdd5f5078ad6474f9b20a5d82cd9943b',NULL,NULL,'','',''),(30003,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-06-09 02:29:11','pendente','96e45939734343888616a5e1e3418534',NULL,NULL,'','',''),(30004,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-06-09 02:31:04','pendente','a330ff44042f4c0ea8f02dbc57580283',NULL,NULL,'','',''),(60001,'GFSERGSRFSDF','000.000.000-00','05/02/2023','GARGSERGAFG','brasileira','solteiro(a)','do lar','222.222.222-22','1215165415','Goiânia, Goiás','jkjhiu','çljlijil','x10','6a','13','fajfeiofeof','Goiânia','GO','74473-070','2026-06-09 03:00:03','pendente','e59ec69fa9814dbb82ded05b531ba896',NULL,NULL,'','',''),(90001,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-06-09 03:43:41','pendente','fad4c92d0ebb4a63a13048f05098f9f3',NULL,NULL,'','',''),(90002,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-06-09 03:43:55','pendente','33433fc478744b5eb94ab75bd75292a7',NULL,NULL,'','',''),(90003,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-06-09 03:44:30','pendente','05f6ad5ed3b54521b183bb5d0491557e',NULL,NULL,'','',''),(120001,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-06-15 15:08:14','gerada','a6c7119d39f744d6b55901b19faf9d66',NULL,NULL,'','',''),(120002,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-06-15 15:08:25','pendente','f17b51e7b59f4f67b1fb08112ced674f',NULL,NULL,'','',''),(120003,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-06-15 15:16:58','pendente','6371aa5519844639af9a563337c54b8f',NULL,NULL,'','',''),(120004,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-06-15 15:17:06','pendente','6589ee881b274d8aaec2559e5c4b968f',NULL,NULL,'','',''),(120005,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-06-15 15:18:20','pendente','c459e48b9e464de7a67693006e13dfed',NULL,NULL,'','',''),(120006,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-06-15 15:18:28','pendente','75537522ffdd427796c6e854a0e64fe8',NULL,NULL,'','',''),(120007,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-06-15 15:21:37','pendente','ee65f747daae4b8092c1ffa66fc5b089',NULL,NULL,'','',''),(120008,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-06-15 16:04:33','pendente','6ae63cc012f242e1b417f0a47adbedd6',NULL,NULL,'','',''),(120009,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-06-15 16:55:15','pendente','42159b50ac1f41efaa203d83d9f379ce',NULL,NULL,'','',''),(120010,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-06-15 16:59:06','pendente','c9647e405a4e482f869e01b638a7c8d7',NULL,NULL,'','',''),(150001,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-06-29 22:33:30','pendente','08ed93bf01aa425eba2c1007b544ac68',NULL,NULL,'','',''),(150002,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-06-29 22:34:16','pendente','4bc95b3681104132b5fc18078f3732e3',NULL,NULL,'','',''),(180001,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-07-08 13:08:55','pendente','87d451bd55ed4741bf9e75135bf180ab',NULL,NULL,'','',''),(210001,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-07-08 13:26:11','pendente','8dbf147f-afc5-44bd-a768-107aafc7093b',NULL,NULL,'','',''),(210002,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-07-08 13:26:19','pendente','700e2807-8ea8-4ec8-a475-919a5062557b',NULL,NULL,'','',''),(240001,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-07-08 16:23:54','pendente','3802e500-a568-4580-adb4-74eb2b7f0c66',NULL,NULL,'','',''),(240002,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-07-08 16:28:06','pendente','8328f152-8aa5-4370-a9fe-695bdd3dbb4e',NULL,NULL,'','',''),(240003,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-07-08 16:49:57','pendente','eb4e906f-c55c-4203-9d21-76e294ce0555',NULL,NULL,'','',''),(240004,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-07-08 16:52:10','pendente','b93beba2-8529-4ff6-ae2c-0cf11c4302b1',NULL,NULL,'','',''),(240005,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-07-08 17:17:07','pendente','68ad3a71-5d1a-4238-8d72-5f0a193aa96c',NULL,NULL,'','',''),(270001,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-07-08 19:53:52','pendente','a0988c41-9b28-4b32-9090-0aad1cc0a99e',NULL,NULL,'','',''),(300001,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-07-08 20:52:35','pendente','bc7298aa-df61-4b9f-b900-78c7904eebd8',NULL,NULL,'','',''),(300002,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-07-08 20:56:34','pendente','826f5772-8e5c-445a-9436-d10d364d9396',NULL,NULL,'','',''),(330001,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-07-08 21:53:49','pendente','6354cd38-b9a3-4df4-b518-46a768c04891',NULL,NULL,'','',''),(360001,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-07-08 22:05:40','pendente','dd7ddb7b-ea47-4c27-b72c-24db50fe7c9d',NULL,NULL,'','',''),(390001,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-07-08 22:08:52','pendente','5feb4efe-acda-4f8f-b065-60bcec9dde49',NULL,NULL,'','',''),(420001,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-07-08 22:12:30','pendente','55d8fb8e-cf9a-4f35-bfab-bb7fb69c1923',NULL,NULL,'','',''),(420002,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-07-08 22:58:12','pendente','f9c0daf6-fcc9-4b21-9478-e4213d1f0a2e',NULL,NULL,'','',''),(420003,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-07-08 23:24:39','pendente','f12ff910-62a3-4802-8f5a-72ba5d317130',NULL,NULL,'','',''),(420004,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-07-08 23:25:25','pendente','2da95a19-6849-43bf-88d8-b48b80a1d1bb',NULL,NULL,'','',''),(450001,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-07-09 02:41:44','pendente','42853cfe-3fbf-4ea0-b678-88f0ff398024',NULL,NULL,'','',''),(450002,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-07-09 02:45:55','pendente','986631af-a2af-4a56-b2f6-6fd57ba9628d',NULL,NULL,'','',''),(480001,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-07-09 03:13:38','pendente','5660e1d2-49ed-41b0-b52c-ecce2ddf0f00',NULL,NULL,'','',''),(480002,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-07-09 03:14:50','pendente','5008552f-ddf3-489c-8d7f-58a10cfe2544',NULL,NULL,'','',''),(510001,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-07-10 12:46:29','pendente','0bd08bcc-9778-4a52-8466-f3367ba08b59',NULL,NULL,'','',''),(540001,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-07-10 12:48:29','pendente','dafcce3e-67ca-4cad-8ebe-3cb5819f45ed',NULL,NULL,'','',''),(570001,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-07-10 12:58:59','pendente','a0de5d15-648f-4345-bacf-0f216983f9af',NULL,NULL,'','',''),(600001,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-07-10 13:06:25','pendente','2540aff2-1f52-4e82-aa79-2e97f6ba1814',NULL,NULL,'','',''),(630001,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-07-10 13:53:11','pendente','9dc1e6ca-0305-46b7-8a8e-b955a1b42756',NULL,NULL,'','',''),(660001,'PEDRO DA SILVA','987.654.321-00','15/03/2023','MARIA DA SILVA SOUZA','brasileira','solteira','professora','123.456.789-00','1234567','Goiânia-GO','João da Silva','Ana da Silva','Rua das Flores, nº 10',NULL,NULL,NULL,'Goiânia','GO','74000-000','2026-07-10 13:58:35','pendente','52d978e6-b85b-40ae-a22c-347f69c35fef',NULL,NULL,'','','');
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
  PRIMARY KEY (`id`) /*T![clustered_index] CLUSTERED */
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=30001;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `procuracoes_weber_ana`
--

LOCK TABLES `procuracoes_weber_ana` WRITE;
/*!40000 ALTER TABLE `procuracoes_weber_ana` DISABLE KEYS */;
INSERT INTO `procuracoes_weber_ana` (`id`, `nome`, `genero`, `estadoCivil`, `profissao`, `cpf`, `rg`, `naturalidade`, `nomePai`, `nomeMae`, `rua`, `quadra`, `lote`, `setor`, `cidade`, `estado`, `cep`, `criadoEm`, `status`, `downloadToken`, `observacoes`, `numero`) VALUES (1,'GDFAAFDAE','brasileiro','solteiro(a)','professor','111.111.111-11','22222222','Goiânia','fdefaeffaefe','ggewrefse','x10','de','12','fajfeiofeof','Goiânia','Go','74473-070','2026-06-09 02:47:44','gerada','889ccad65c204eba978901b5db8347d2',NULL,NULL);
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
  PRIMARY KEY (`id`) /*T![clustered_index] CLUSTERED */
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
  PRIMARY KEY (`id`) /*T![clustered_index] CLUSTERED */,
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
-- Dump concluído.
