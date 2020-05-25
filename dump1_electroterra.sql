-- MySQL dump 10.17  Distrib 10.3.17-MariaDB, for debian-linux-gnueabihf (armv7l)
--
-- Host: localhost    Database: electroterra
-- ------------------------------------------------------
-- Server version	10.3.17-MariaDB-0+deb10u1

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
-- Table structure for table `actuators`
--

DROP TABLE IF EXISTS `actuators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actuators` (
  `actuatorID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `beschrijving` varchar(200) DEFAULT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`actuatorID`),
  UNIQUE KEY `actuatorID_UNIQUE` (`actuatorID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actuators`
--

LOCK TABLES `actuators` WRITE;
/*!40000 ALTER TABLE `actuators` DISABLE KEYS */;
INSERT INTO `actuators` VALUES (1,'sit','Lorem ipsum dolor sit',4),(2,'libero','Lorem ipsum dolor sit amet,',3),(3,'pretium','Lorem ipsum dolor sit',2),(4,'orci','Lorem ipsum',4),(5,'eu','Lorem ipsum dolor',5),(6,'libero.','Lorem ipsum',4),(7,'auctor.','Lorem ipsum',5),(8,'id','Lorem ipsum dolor',1),(9,'nunc.','Lorem ipsum dolor',5),(10,'non,','Lorem',3);
/*!40000 ALTER TABLE `actuators` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inlezing_has_actuator`
--

DROP TABLE IF EXISTS `inlezing_has_actuator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inlezing_has_actuator` (
  `inlezing_inlezingID` int(11) NOT NULL,
  `actuator_actuatorID` int(11) NOT NULL,
  PRIMARY KEY (`inlezing_inlezingID`,`actuator_actuatorID`),
  KEY `fk_inlezing_has_actuator_actuator1_idx` (`actuator_actuatorID`),
  KEY `fk_inlezing_has_actuator_inlezing1_idx` (`inlezing_inlezingID`),
  CONSTRAINT `fk_inlezing_has_actuator_actuator1` FOREIGN KEY (`actuator_actuatorID`) REFERENCES `actuators` (`actuatorID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_inlezing_has_actuator_inlezing1` FOREIGN KEY (`inlezing_inlezingID`) REFERENCES `inlezingen` (`inlezingID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inlezing_has_actuator`
--

LOCK TABLES `inlezing_has_actuator` WRITE;
/*!40000 ALTER TABLE `inlezing_has_actuator` DISABLE KEYS */;
INSERT INTO `inlezing_has_actuator` VALUES (1,7),(4,5),(4,6),(4,8),(5,8),(5,9),(6,7),(7,10),(8,5),(10,7);
/*!40000 ALTER TABLE `inlezing_has_actuator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inlezingen`
--

DROP TABLE IF EXISTS `inlezingen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inlezingen` (
  `inlezingID` int(11) NOT NULL AUTO_INCREMENT,
  `sensorID` int(11) NOT NULL,
  `time` datetime NOT NULL,
  `waarde` float NOT NULL,
  PRIMARY KEY (`inlezingID`),
  UNIQUE KEY `inlezingID_UNIQUE` (`inlezingID`),
  KEY `fk_inlezing_sensors_idx` (`sensorID`),
  CONSTRAINT `fk_inlezing_sensors` FOREIGN KEY (`sensorID`) REFERENCES `sensors` (`sensorID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inlezingen`
--

LOCK TABLES `inlezingen` WRITE;
/*!40000 ALTER TABLE `inlezingen` DISABLE KEYS */;
INSERT INTO `inlezingen` VALUES (1,8,'2021-02-14 03:35:21',48),(2,2,'2020-07-22 11:28:12',24),(3,5,'2019-11-18 04:33:29',83),(4,4,'2020-07-14 18:04:29',55),(5,6,'2020-02-10 17:45:10',90),(6,4,'2020-03-25 09:17:56',75),(7,9,'2020-10-03 22:44:27',16),(8,2,'2019-06-29 21:18:33',6),(9,6,'2021-01-04 12:30:05',86),(10,9,'2020-04-10 17:41:36',21),(11,7,'2021-02-15 22:41:39',76),(12,6,'2020-03-13 00:29:49',31),(13,9,'2019-07-05 15:12:38',35),(14,5,'2019-11-12 13:30:35',52),(15,10,'2019-07-02 06:09:20',34),(16,2,'2020-02-06 15:53:12',22),(17,4,'2021-01-02 11:14:58',97),(18,1,'2021-03-09 11:43:42',29),(19,4,'2019-06-24 14:11:23',65),(20,2,'2020-03-30 09:42:15',51),(21,6,'2020-10-09 12:06:58',15),(22,4,'2019-07-23 22:56:43',70),(23,6,'2020-04-26 20:45:14',58),(24,4,'2020-08-14 07:54:13',54),(25,7,'2019-10-24 17:14:35',48),(26,3,'2020-10-31 01:33:42',96),(27,10,'2020-04-04 11:27:50',79),(28,3,'2020-03-05 01:49:00',53),(29,7,'2019-12-10 12:19:37',60),(30,6,'2020-07-20 02:52:36',47);
/*!40000 ALTER TABLE `inlezingen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sensors`
--

DROP TABLE IF EXISTS `sensors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sensors` (
  `sensorID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `beschrijving` varchar(200) DEFAULT NULL,
  `eenheid` varchar(20) NOT NULL,
  PRIMARY KEY (`sensorID`),
  UNIQUE KEY `sensorID_UNIQUE` (`sensorID`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sensors`
--

LOCK TABLES `sensors` WRITE;
/*!40000 ALTER TABLE `sensors` DISABLE KEYS */;
INSERT INTO `sensors` VALUES (1,'lectus. Nullam','Lorem ipsum dolor sit amet,','dictum'),(2,'mauris','Lorem ipsum dolor sit','dolor'),(3,'varius.','Lorem ipsum','nec'),(4,'In ornare','Lorem ipsum dolor sit amet,','non'),(5,'dictum mi,','Lorem ipsum dolor','Morbi'),(6,'risus.','Lorem ipsum dolor sit amet,','eu'),(7,'lorem','Lorem ipsum','sed'),(8,'mauris,','Lorem','consectetuer'),(9,'est,','Lorem ipsum dolor sit','et'),(10,'ipsum primis','Lorem ipsum dolor sit','Class');
/*!40000 ALTER TABLE `sensors` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-25 17:49:13
