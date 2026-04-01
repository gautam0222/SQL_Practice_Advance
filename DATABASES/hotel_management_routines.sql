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
-- Temporary view structure for view `reservationsummary`
--

DROP TABLE IF EXISTS `reservationsummary`;
/*!50001 DROP VIEW IF EXISTS `reservationsummary`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `reservationsummary` AS SELECT 
 1 AS `Name`,
 1 AS `Room_Number`,
 1 AS `Check_In_Date`,
 1 AS `Check_Out_Date`,
 1 AS `Amount`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `hotelstaff`
--

DROP TABLE IF EXISTS `hotelstaff`;
/*!50001 DROP VIEW IF EXISTS `hotelstaff`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `hotelstaff` AS SELECT 
 1 AS `StaffName`,
 1 AS `Role`,
 1 AS `Salary`,
 1 AS `Contact_Number`,
 1 AS `Hotel_Name`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `availablerooms`
--

DROP TABLE IF EXISTS `availablerooms`;
/*!50001 DROP VIEW IF EXISTS `availablerooms`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `availablerooms` AS SELECT 
 1 AS `Room_Number`,
 1 AS `Room_Type`,
 1 AS `Price`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `reservationsummary`
--

/*!50001 DROP VIEW IF EXISTS `reservationsummary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb3 */;
/*!50001 SET character_set_results     = utf8mb3 */;
/*!50001 SET collation_connection      = utf8mb3_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `reservationsummary` AS select `customer`.`Name` AS `Name`,`room`.`Room_Number` AS `Room_Number`,`reservation`.`Check_In_Date` AS `Check_In_Date`,`reservation`.`Check_Out_Date` AS `Check_Out_Date`,`payment`.`Amount` AS `Amount` from (((`reservation` join `customer` on((`reservation`.`Customer_ID` = `customer`.`Customer_ID`))) join `room` on((`reservation`.`Room_ID` = `room`.`Room_ID`))) join `payment` on((`reservation`.`Reservation_ID` = `payment`.`Reservation_ID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `hotelstaff`
--

/*!50001 DROP VIEW IF EXISTS `hotelstaff`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb3 */;
/*!50001 SET character_set_results     = utf8mb3 */;
/*!50001 SET collation_connection      = utf8mb3_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `hotelstaff` AS select `staff`.`Name` AS `StaffName`,`staff`.`Role` AS `Role`,`staff`.`Salary` AS `Salary`,`staff`.`Contact_Number` AS `Contact_Number`,`hotel`.`Hotel_Name` AS `Hotel_Name` from (`staff` join `hotel` on((`staff`.`Hotel_ID` = `hotel`.`Hotel_ID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `availablerooms`
--

/*!50001 DROP VIEW IF EXISTS `availablerooms`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb3 */;
/*!50001 SET character_set_results     = utf8mb3 */;
/*!50001 SET collation_connection      = utf8mb3_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `availablerooms` AS select `room`.`Room_Number` AS `Room_Number`,`room`.`Room_Type` AS `Room_Type`,`room`.`Price` AS `Price` from `room` where (`room`.`Room_Status` = 'Available') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-01 12:20:16
