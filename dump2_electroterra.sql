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
  PRIMARY KEY (`actuatorID`),
  UNIQUE KEY `actuatorID_UNIQUE` (`actuatorID`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actuators`
--

LOCK TABLES `actuators` WRITE;
/*!40000 ALTER TABLE `actuators` DISABLE KEYS */;
INSERT INTO `actuators` VALUES (1,'sit','Lorem ipsum dolor sit'),(2,'libero','Lorem ipsum dolor sit amet,'),(3,'pretium','Lorem ipsum dolor sit'),(4,'orci','Lorem ipsum'),(5,'eu','Lorem ipsum dolor'),(6,'libero.','Lorem ipsum'),(7,'auctor.','Lorem ipsum'),(8,'id','Lorem ipsum dolor'),(9,'nunc.','Lorem ipsum dolor'),(10,'non,','Lorem'),(11,'Mauris','Lorem ipsum'),(12,'egestas','Lorem ipsum'),(13,'magnis','Lorem'),(14,'Sed','Lorem ipsum dolor'),(15,'mi','Lorem ipsum dolor sit'),(16,'sollicitudin','Lorem ipsum dolor'),(17,'quis','Lorem ipsum dolor'),(18,'dolor.','Lorem ipsum dolor sit'),(19,'Maecenas','Lorem ipsum dolor sit'),(20,'magna,','Lorem ipsum'),(21,'pharetra.','Lorem ipsum dolor sit'),(22,'accumsan','Lorem ipsum dolor sit amet,'),(23,'eu','Lorem ipsum dolor sit'),(24,'a','Lorem ipsum dolor sit amet, consectetuer'),(25,'mi','Lorem'),(26,'malesuada.','Lorem ipsum dolor'),(27,'malesuada','Lorem ipsum'),(28,'adipiscing','Lorem ipsum dolor sit'),(29,'sociis','Lorem ipsum'),(30,'Nunc','Lorem ipsum dolor sit amet,'),(31,'vestibulum','Lorem ipsum dolor sit amet, consectetuer'),(32,'dictum','Lorem ipsum'),(33,'et','Lorem ipsum'),(34,'mi.','Lorem ipsum dolor'),(35,'nec','Lorem ipsum dolor sit amet,'),(36,'et','Lorem ipsum'),(37,'magna.','Lorem'),(38,'ultrices.','Lorem'),(39,'montes,','Lorem ipsum dolor sit'),(40,'nisi','Lorem ipsum'),(41,'mauris','Lorem ipsum dolor sit'),(42,'libero','Lorem ipsum'),(43,'dui,','Lorem ipsum dolor'),(44,'Ut','Lorem ipsum dolor sit amet,'),(45,'neque','Lorem ipsum dolor sit amet, consectetuer'),(46,'mi','Lorem ipsum dolor'),(47,'nibh.','Lorem ipsum dolor sit'),(48,'Vivamus','Lorem ipsum'),(49,'Donec','Lorem'),(50,'Nunc','Lorem ipsum dolor sit amet,');
/*!40000 ALTER TABLE `actuators` ENABLE KEYS */;
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
  `actuatorID` int(11) DEFAULT NULL,
  `time` datetime NOT NULL,
  `waarde` float NOT NULL,
  `statusactuator` varchar(55) DEFAULT NULL,
  PRIMARY KEY (`inlezingID`),
  UNIQUE KEY `inlezingID_UNIQUE` (`inlezingID`),
  KEY `fk_inlezing_sensors_idx` (`sensorID`),
  KEY `fk_inlezingen_actuators1_idx` (`actuatorID`),
  CONSTRAINT `fk_inlezing_sensors` FOREIGN KEY (`sensorID`) REFERENCES `sensors` (`sensorID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_inlezingen_actuators1` FOREIGN KEY (`actuatorID`) REFERENCES `actuators` (`actuatorID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inlezingen`
--

LOCK TABLES `inlezingen` WRITE;
/*!40000 ALTER TABLE `inlezingen` DISABLE KEYS */;
INSERT INTO `inlezingen` VALUES (1,6,8,'2021-02-13 02:43:04',97,'libero.'),(2,1,3,'2020-10-02 15:45:46',34,'at,'),(3,5,7,'2021-05-04 18:54:36',46,'est'),(4,5,4,'2019-08-25 21:54:36',46,'natoque'),(5,8,8,'2019-12-15 10:37:32',51,'dapibus'),(6,4,1,'2020-04-24 12:36:08',46,'scelerisque'),(7,6,5,'2020-07-15 03:31:26',11,'mauris,'),(8,5,10,'2019-08-28 05:15:47',1,'magna.'),(9,3,8,'2020-09-24 14:25:38',80,'sit'),(10,4,5,'2021-01-13 10:10:17',89,'vel'),(11,6,3,'2019-10-26 22:17:31',32,'Quisque'),(12,7,10,'2021-05-22 02:38:28',65,'Nunc'),(13,2,3,'2019-10-11 02:56:04',87,'nec,'),(14,9,10,'2020-08-02 15:15:14',78,'magna'),(15,5,3,'2021-02-19 07:52:38',99,'iaculis'),(16,9,10,'2019-09-12 05:26:49',12,'dapibus'),(17,1,10,'2020-12-05 08:30:29',83,'purus'),(18,2,6,'2020-07-26 13:49:43',48,'sociosqu'),(19,4,7,'2019-07-04 10:08:27',53,'Aenean'),(20,4,3,'2020-03-12 22:38:29',79,'consectetuer'),(21,10,3,'2021-02-07 07:43:59',1,'pharetra'),(22,10,3,'2020-10-31 09:39:33',22,'Morbi'),(23,2,2,'2019-10-05 06:10:32',34,'non'),(24,5,6,'2020-10-01 02:34:33',47,'Fusce'),(25,2,10,'2019-10-18 03:45:20',64,'a'),(26,10,10,'2021-02-28 14:39:13',28,'nunc'),(27,10,6,'2019-11-23 19:01:50',70,'nascetur'),(28,7,5,'2021-01-31 11:45:49',14,'orci'),(29,8,5,'2020-10-03 21:27:18',45,'consectetuer'),(30,7,7,'2019-06-14 20:28:23',40,'consequat'),(31,8,7,'2020-01-19 00:26:20',73,'sapien,'),(32,3,9,'2019-09-18 05:44:15',12,'in,'),(33,7,4,'2020-06-14 17:45:25',45,'magna'),(34,6,7,'2019-10-26 12:01:07',31,'ultrices,'),(35,3,7,'2020-03-08 20:23:27',63,'purus.'),(36,9,8,'2021-03-06 21:01:10',77,'ligula.'),(37,8,1,'2021-03-26 12:40:55',58,'libero.'),(38,7,4,'2020-02-14 15:35:39',87,'sit'),(39,4,7,'2020-10-10 17:01:48',5,'neque'),(40,10,10,'2020-05-18 03:39:53',56,'Maecenas'),(41,1,9,'2021-04-12 09:37:02',87,'erat.'),(42,3,5,'2020-08-14 12:43:05',59,'sem.'),(43,6,10,'2019-06-12 05:15:23',49,'urna.'),(44,3,4,'2020-03-04 07:42:55',31,'dui'),(45,3,8,'2020-01-02 12:32:37',13,'elit,'),(46,7,3,'2019-08-14 18:05:01',64,'lorem'),(47,2,10,'2020-08-10 17:50:03',66,'nunc.'),(48,4,10,'2021-04-19 16:51:16',85,'imperdiet'),(49,5,6,'2019-09-12 04:06:05',7,'ornare'),(50,7,10,'2019-12-17 07:32:26',39,'enim');
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
INSERT INTO `sensors` VALUES (1,'lectus. Nullam','Lorem ipsum dolor sit amet,','dictum'),(2,'mauris','Lorem ipsum dolor sit','dolor'),(3,'varius.','Lorem ipsum','nec'),(4,'In ornare','Lorem ipsum dolor sit amet,','non'),(5,'dictum mi,','Lorem ipsum dolor','Morbi'),(6,'risus.','Lorem ipsum dolor sit amet,','eu'),(7,'lorem','Lorem ipsum','sed'),(8,'mauris,','Lorem','consectetuer'),(9,'est,','Lorem ipsum dolor sit','et'),(10,'ipsum primis','Lorem ipsum dolor sit','Class'),(11,'feugiat','Lorem ipsum dolor sit','non,'),(12,'a','Lorem','pede.'),(13,'ac','Lorem ipsum dolor sit','mus.'),(14,'arcu','Lorem ipsum','mi,'),(15,'malesuada','Lorem ipsum','sagittis'),(16,'ante','Lorem ipsum dolor','primis'),(17,'ullamcorper,','Lorem','ut'),(18,'semper','Lorem','at,'),(19,'ut','Lorem ipsum dolor sit amet, consectetuer','sed'),(20,'ipsum.','Lorem ipsum','tincidunt'),(21,'nibh.','Lorem ipsum dolor sit amet, consectetuer','montes,'),(22,'eu','Lorem ipsum dolor sit amet,','vulputate,'),(23,'Duis','Lorem ipsum dolor','et'),(24,'aliquam','Lorem','a,'),(25,'nec,','Lorem ipsum dolor sit','neque'),(26,'ullamcorper,','Lorem ipsum','ultrices.'),(27,'nec','Lorem ipsum dolor sit','enim'),(28,'lorem,','Lorem ipsum dolor','Morbi'),(29,'enim.','Lorem ipsum dolor','sapien.'),(30,'Proin','Lorem ipsum dolor sit amet,','vel,'),(31,'ac','Lorem ipsum dolor sit','tellus.'),(32,'turpis','Lorem ipsum dolor sit amet,','Fusce'),(33,'aliquam','Lorem ipsum dolor sit amet,','mauris'),(34,'bibendum','Lorem ipsum','nunc'),(35,'litora','Lorem ipsum dolor sit','nulla'),(36,'luctus','Lorem ipsum dolor sit','lectus'),(37,'tortor','Lorem ipsum dolor sit amet, consectetuer','dolor'),(38,'vel','Lorem ipsum dolor sit amet,','est'),(39,'placerat,','Lorem ipsum dolor','fringilla.'),(40,'non','Lorem ipsum dolor sit','ac'),(41,'et','Lorem ipsum dolor sit amet, consectetuer','tristique'),(42,'eleifend','Lorem ipsum dolor sit amet, consectetuer','tristique'),(43,'elit.','Lorem ipsum','cursus,'),(44,'Cras','Lorem ipsum dolor sit','eu'),(45,'vel','Lorem ipsum','Praesent'),(46,'porttitor','Lorem','eu'),(47,'habitant','Lorem ipsum','natoque'),(48,'Proin','Lorem ipsum dolor sit amet, consectetuer','adipiscing,'),(49,'nonummy','Lorem ipsum dolor sit amet,','nulla.'),(50,'massa','Lorem','natoque');
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

-- Dump completed on 2020-05-27  9:22:21
