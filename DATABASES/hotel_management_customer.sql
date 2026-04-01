-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: hotel_management
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `Customer_ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `Phone_Number` varchar(15) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `ID_Proof` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Customer_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'John Doe','123 Elm St','111-222-3333','john.doe@email.com','Passport'),(2,'Jane Smith','456 Oak St','222-333-4444','jane.smith@email.com','Driver License'),(3,'Alice Johnson','789 Pine St','333-444-5555','alice.j@email.com','Aadhar'),(4,'Michael Brown','321 Maple St','444-555-6666','michael.b@email.com','Voter ID'),(5,'Sarah Taylor','654 Cedar St','555-666-7777','sarah.t@email.com','Passport'),(6,'David Wilson','987 Birch St','666-777-8888','david.w@email.com','Driver License'),(7,'Emily Davis','159 Spruce St','777-888-9999','emily.d@email.com','Aadhar'),(8,'Brian Miller','753 Willow St','888-999-0000','brian.m@email.com','Voter ID'),(9,'Lisa Garcia','258 Fir St','999-000-1111','lisa.g@email.com','Passport'),(10,'Kevin Lee','147 Redwood St','000-111-2222','kevin.l@email.com','Driver License'),(11,'Laura Walker','369 Aspen St','111-222-3334','laura.w@email.com','Aadhar'),(12,'Jason Martinez','486 Hemlock St','222-333-4445','jason.m@email.com','Voter ID'),(13,'Amy Anderson','369 Beech St','333-444-5556','amy.a@email.com','Passport'),(14,'Tom White','753 Poplar St','444-555-6667','tom.w@email.com','Driver License'),(15,'Nina Black','159 Sequoia St','555-666-7778','nina.b@email.com','Aadhar'),(16,'John Doe','123 Main St','1234567890','johndoe@mail.com','Passport');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-01 12:20:15
