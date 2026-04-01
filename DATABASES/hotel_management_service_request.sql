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
-- Table structure for table `service_request`
--

DROP TABLE IF EXISTS `service_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_request` (
  `Request_ID` int NOT NULL AUTO_INCREMENT,
  `Service_Date` date DEFAULT NULL,
  `Service_ID` int DEFAULT NULL,
  `Customer_ID` int DEFAULT NULL,
  `Staff_ID` int DEFAULT NULL,
  PRIMARY KEY (`Request_ID`),
  KEY `Service_ID` (`Service_ID`),
  KEY `Customer_ID` (`Customer_ID`),
  KEY `Staff_ID` (`Staff_ID`),
  CONSTRAINT `service_request_ibfk_1` FOREIGN KEY (`Service_ID`) REFERENCES `service` (`Service_ID`) ON DELETE CASCADE,
  CONSTRAINT `service_request_ibfk_2` FOREIGN KEY (`Customer_ID`) REFERENCES `customer` (`Customer_ID`) ON DELETE CASCADE,
  CONSTRAINT `service_request_ibfk_3` FOREIGN KEY (`Staff_ID`) REFERENCES `staff` (`Staff_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_request`
--

LOCK TABLES `service_request` WRITE;
/*!40000 ALTER TABLE `service_request` DISABLE KEYS */;
INSERT INTO `service_request` VALUES (1,'2024-10-01',1,1,1),(2,'2024-10-02',2,2,2),(3,'2024-10-03',3,3,3),(4,'2024-10-04',4,4,4),(5,'2024-10-05',5,5,5),(6,'2024-10-06',6,6,6),(7,'2024-10-07',7,7,7),(8,'2024-10-08',8,8,8),(9,'2024-10-09',9,9,9),(10,'2024-10-10',10,10,10),(11,'2024-10-11',1,11,11),(12,'2024-10-12',2,12,12),(13,'2024-10-13',3,13,13),(14,'2024-10-14',4,14,14),(15,'2024-10-15',5,15,15);
/*!40000 ALTER TABLE `service_request` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-01 12:20:14
