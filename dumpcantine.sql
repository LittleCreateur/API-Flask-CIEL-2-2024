-- MariaDB dump 10.19  Distrib 10.11.6-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: cantine
-- ------------------------------------------------------
-- Server version	10.11.6-MariaDB-0+deb12u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `cantine`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `cantine` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `cantine`;

--
-- Table structure for table `Affectation_carte`
--

DROP TABLE IF EXISTS `Affectation_carte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Affectation_carte` (
  `id_affectation_carte` int(11) NOT NULL AUTO_INCREMENT,
  `id_carte` varchar(255) DEFAULT NULL,
  `id_personne` int(11) DEFAULT NULL,
  `date_debut` datetime NOT NULL,
  `date_fin` datetime DEFAULT NULL,
  PRIMARY KEY (`id_affectation_carte`),
  KEY `id_carte` (`id_carte`),
  KEY `id_personne` (`id_personne`),
  CONSTRAINT `Affectation_carte_ibfk_1` FOREIGN KEY (`id_carte`) REFERENCES `Carte` (`id_carte`),
  CONSTRAINT `Affectation_carte_ibfk_2` FOREIGN KEY (`id_personne`) REFERENCES `Personne` (`id_personne`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Affectation_carte`
--

LOCK TABLES `Affectation_carte` WRITE;
/*!40000 ALTER TABLE `Affectation_carte` DISABLE KEYS */;
/*!40000 ALTER TABLE `Affectation_carte` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Carte`
--

DROP TABLE IF EXISTS `Carte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Carte` (
  `id_carte` varchar(255) NOT NULL,
  PRIMARY KEY (`id_carte`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Carte`
--

LOCK TABLES `Carte` WRITE;
/*!40000 ALTER TABLE `Carte` DISABLE KEYS */;
/*!40000 ALTER TABLE `Carte` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Composition_groupe`
--

DROP TABLE IF EXISTS `Composition_groupe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Composition_groupe` (
  `date_debut` datetime NOT NULL,
  `date_fin` datetime DEFAULT NULL,
  `id_personne` int(11) DEFAULT NULL,
  `id_groupe` int(11) DEFAULT NULL,
  KEY `id_personne` (`id_personne`),
  KEY `id_groupe` (`id_groupe`),
  CONSTRAINT `Composition_groupe_ibfk_1` FOREIGN KEY (`id_personne`) REFERENCES `Personne` (`id_personne`),
  CONSTRAINT `Composition_groupe_ibfk_2` FOREIGN KEY (`id_groupe`) REFERENCES `Groupe` (`id_groupe`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Composition_groupe`
--

LOCK TABLES `Composition_groupe` WRITE;
/*!40000 ALTER TABLE `Composition_groupe` DISABLE KEYS */;
/*!40000 ALTER TABLE `Composition_groupe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Consomation_repas`
--

DROP TABLE IF EXISTS `Consomation_repas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Consomation_repas` (
  `id_carte` varchar(255) DEFAULT NULL,
  `id_lecteur` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  KEY `id_carte` (`id_carte`),
  KEY `id_lecteur` (`id_lecteur`),
  CONSTRAINT `Consomation_repas_ibfk_1` FOREIGN KEY (`id_carte`) REFERENCES `Carte` (`id_carte`),
  CONSTRAINT `Consomation_repas_ibfk_2` FOREIGN KEY (`id_lecteur`) REFERENCES `Lecteur` (`id_lecteur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Consomation_repas`
--

LOCK TABLES `Consomation_repas` WRITE;
/*!40000 ALTER TABLE `Consomation_repas` DISABLE KEYS */;
/*!40000 ALTER TABLE `Consomation_repas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Groupe`
--

DROP TABLE IF EXISTS `Groupe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Groupe` (
  `id_groupe` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id_groupe`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Groupe`
--

LOCK TABLES `Groupe` WRITE;
/*!40000 ALTER TABLE `Groupe` DISABLE KEYS */;
INSERT INTO `Groupe` VALUES
(1,'groupe_1'),
(2,'groupe_2'),
(3,'LesGeekos'),
(4,'LesGeekos'),
(5,'LesGeekette'),
(6,'Fan2léo');
/*!40000 ALTER TABLE `Groupe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Id_affectation_lecteur`
--

DROP TABLE IF EXISTS `Id_affectation_lecteur`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Id_affectation_lecteur` (
  `id_lecteur` int(11) DEFAULT NULL,
  `id_site` int(11) DEFAULT NULL,
  `date_debut` datetime DEFAULT NULL,
  `date_fin` datetime DEFAULT NULL,
  KEY `id_lecteur` (`id_lecteur`),
  KEY `id_site` (`id_site`),
  CONSTRAINT `Id_affectation_lecteur_ibfk_1` FOREIGN KEY (`id_lecteur`) REFERENCES `Lecteur` (`id_lecteur`),
  CONSTRAINT `Id_affectation_lecteur_ibfk_2` FOREIGN KEY (`id_site`) REFERENCES `Site` (`id_site`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Id_affectation_lecteur`
--

LOCK TABLES `Id_affectation_lecteur` WRITE;
/*!40000 ALTER TABLE `Id_affectation_lecteur` DISABLE KEYS */;
/*!40000 ALTER TABLE `Id_affectation_lecteur` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Lecteur`
--

DROP TABLE IF EXISTS `Lecteur`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Lecteur` (
  `id_lecteur` int(11) NOT NULL AUTO_INCREMENT,
  `designation` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_lecteur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Lecteur`
--

LOCK TABLES `Lecteur` WRITE;
/*!40000 ALTER TABLE `Lecteur` DISABLE KEYS */;
/*!40000 ALTER TABLE `Lecteur` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Parametres`
--

DROP TABLE IF EXISTS `Parametres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Parametres` (
  `seuil_découvert` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Parametres`
--

LOCK TABLES `Parametres` WRITE;
/*!40000 ALTER TABLE `Parametres` DISABLE KEYS */;
/*!40000 ALTER TABLE `Parametres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Personne`
--

DROP TABLE IF EXISTS `Personne`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Personne` (
  `id_personne` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(128) DEFAULT NULL,
  `prenom` varchar(128) DEFAULT NULL,
  `pwd` varchar(255) DEFAULT NULL,
  `nb_credits` int(11) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `id_role` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_personne`),
  KEY `id_role` (`id_role`),
  CONSTRAINT `Personne_ibfk_1` FOREIGN KEY (`id_role`) REFERENCES `Role` (`id_role`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Personne`
--

LOCK TABLES `Personne` WRITE;
/*!40000 ALTER TABLE `Personne` DISABLE KEYS */;
INSERT INTO `Personne` VALUES
(1,'valentini','charlie','python28',500,'charlie.valentini@nermont.fr',1),
(2,'grondin','thomas','noopy',100,'thomas.grondin@nermont.fr',1),
(3,'COLAS','Enzo','1234Abcd*',12568652,'enzo.colas@nermont.fr',1),
(5,'lepinette','léo','Python_3945!',150,'leo.lepinette@nermont.fr',1);
/*!40000 ALTER TABLE `Personne` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Role`
--

DROP TABLE IF EXISTS `Role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Role` (
  `id_role` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_role`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Role`
--

LOCK TABLES `Role` WRITE;
/*!40000 ALTER TABLE `Role` DISABLE KEYS */;
INSERT INTO `Role` VALUES
(1,'élève'),
(2,'personnel');
/*!40000 ALTER TABLE `Role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Site`
--

DROP TABLE IF EXISTS `Site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Site` (
  `id_site` int(11) NOT NULL AUTO_INCREMENT,
  `lieu` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id_site`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Site`
--

LOCK TABLES `Site` WRITE;
/*!40000 ALTER TABLE `Site` DISABLE KEYS */;
INSERT INTO `Site` VALUES
(1,'chateaudun_lycée'),
(2,'chateaudun_collège'),
(3,'nogent_le_rotrou');
/*!40000 ALTER TABLE `Site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Transaction`
--

DROP TABLE IF EXISTS `Transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Transaction` (
  `montant` decimal(8,2) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `personnel` int(11) DEFAULT NULL,
  `client` int(11) DEFAULT NULL,
  `ref_paiement` varchar(255) DEFAULT NULL,
  `nb_credit_achetes` int(11) DEFAULT NULL,
  KEY `personnel` (`personnel`),
  KEY `client` (`client`),
  CONSTRAINT `Transaction_ibfk_1` FOREIGN KEY (`personnel`) REFERENCES `Personne` (`id_personne`),
  CONSTRAINT `Transaction_ibfk_2` FOREIGN KEY (`client`) REFERENCES `Personne` (`id_personne`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Transaction`
--

LOCK TABLES `Transaction` WRITE;
/*!40000 ALTER TABLE `Transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `Transaction` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-07 10:25:17
