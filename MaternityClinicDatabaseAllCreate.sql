CREATE DATABASE  IF NOT EXISTS `maternity_clinic_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `maternity_clinic_db`;
-- MySQL dump 10.13  Distrib 8.0.18, for Win64 (x86_64)
--
-- Host: localhost    Database: maternity_clinic_db
-- ------------------------------------------------------
-- Server version	8.0.18

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
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admins` (
  `sid` int(7) NOT NULL,
  `adminid` int(7) NOT NULL,
  PRIMARY KEY (`sid`),
  UNIQUE KEY `unique_adminid` (`adminid`),
  CONSTRAINT `admin_is_staff` FOREIGN KEY (`sid`) REFERENCES `staff` (`sid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` VALUES (3152017,2002017),(5232014,2332014),(5082010,4562010);
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admissions`
--

DROP TABLE IF EXISTS `admissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admissions` (
  `a_number` int(11) NOT NULL AUTO_INCREMENT,
  `adminid` int(7) NOT NULL,
  `pid` int(7) NOT NULL,
  `admission_datetime` datetime NOT NULL,
  `reason` varchar(45) NOT NULL,
  `room_number` varchar(5) NOT NULL,
  `discharged_datetime` datetime NOT NULL,
  `notes` varchar(200) NOT NULL DEFAULT 'None',
  PRIMARY KEY (`a_number`),
  UNIQUE KEY `unique_pid_admission_datetime` (`pid`,`admission_datetime`),
  KEY `admission_admin_idx` (`adminid`),
  KEY `admission_patient_idx` (`pid`),
  CONSTRAINT `admission_admin` FOREIGN KEY (`adminid`) REFERENCES `admins` (`adminid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `admission_patient` FOREIGN KEY (`pid`) REFERENCES `patients` (`pid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admissions`
--

LOCK TABLES `admissions` WRITE;
/*!40000 ALTER TABLE `admissions` DISABLE KEYS */;
INSERT INTO `admissions` VALUES (1,2002017,2018297,'2018-10-04 18:55:00','respiratory issues','N1001','2018-10-10 08:30:00','baby admission'),(2,2002017,2018478,'2018-01-24 08:55:00','respiratory issues','N1002','2018-01-31 10:30:00','baby admission'),(3,2002017,2015415,'2018-01-23 18:20:00','scheduled cesarian','M1012','2018-01-31 10:30:00','None'),(4,2002017,2017332,'2018-10-04 12:30:00','delivery','M1018','2018-10-07 08:30:00','None'),(5,4562010,2018034,'2018-11-24 08:15:00','scheduled cesarian','M1005','2018-11-28 12:30:00','None'),(6,4562010,2018448,'2019-09-28 05:20:00','delivery','M1010','2019-09-30 12:50:00','None'),(7,4562010,2019452,'2019-06-17 10:30:00','delivery','M1009','2019-06-21 09:25:00','None'),(8,4562010,2015415,'2016-01-05 12:30:00','delivery','M1002','2016-01-08 10:30:00','None'),(9,4562010,2018561,'2018-01-23 12:30:00','delivery','M1011','2018-01-26 13:30:00','None'),(10,2332014,2017001,'2017-11-30 08:00:00','delivery','M1006','2017-12-01 13:25:00','None'),(11,2332014,2017248,'2017-04-08 09:30:00','delivery','M1005','2017-04-10 13:25:00','None'),(12,2332014,2015321,'2016-09-23 14:30:00','miscarriage','M1003','2016-09-26 14:30:00','None'),(13,2332014,2015415,'2018-03-28 14:30:00','contraception issues','M1004','2018-03-29 09:30:00','None');
/*!40000 ALTER TABLE `admissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `babies`
--

DROP TABLE IF EXISTS `babies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `babies` (
  `bid` int(7) NOT NULL,
  `pid` int(7) NOT NULL,
  `sid` int(7) NOT NULL,
  `gender` varchar(1) NOT NULL,
  `weight` decimal(2,0) NOT NULL,
  `birthmark` varchar(45) NOT NULL DEFAULT 'None',
  `blood_type` varchar(2) NOT NULL,
  `delivery_type` varchar(45) NOT NULL,
  `delivery_datetime` datetime NOT NULL,
  `condition_at_delivery` varchar(45) NOT NULL,
  `bed_number` varchar(5) NOT NULL,
  `discharged_datetime` datetime NOT NULL,
  `notes` varchar(100) NOT NULL DEFAULT 'None',
  PRIMARY KEY (`bid`),
  UNIQUE KEY `unique_mother_delivery_datetime` (`pid`,`delivery_datetime`),
  KEY `birthed_by_idx` (`pid`),
  CONSTRAINT `birthed_by` FOREIGN KEY (`pid`) REFERENCES `patients` (`pid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `babies`
--

LOCK TABLES `babies` WRITE;
/*!40000 ALTER TABLE `babies` DISABLE KEYS */;
INSERT INTO `babies` VALUES (2016004,2015415,2022014,'M',4,'None','AB','natural','2016-01-06 12:45:00','healthy','A1011','2016-01-08 10:30:00','None'),(2017841,2017248,1092012,'F',3,'None','B','natural','2017-04-08 13:25:00','healthy','A1016','2017-04-10 13:25:00','None'),(2018021,2018561,1092012,'M',4,'None','B','natural','2018-01-24 05:15:00','healthy','A1008','2018-01-26 13:30:00','None'),(2018022,2015415,2462015,'M',5,'None','AB','cesarean','2018-01-24 08:55:00','respiratory issues','A1002','2018-01-24 08:55:00','None'),(2018245,2017332,2462015,'F',3,'extra toe','A','natural','2018-10-04 17:25:00','respiratory issues','A1003','2018-10-04 18:55:00','None'),(2018726,2018034,1092012,'F',3,'None','A','cesarean','2018-11-24 12:15:00','healthy','A1006','2018-11-28 12:30:00','None'),(2018727,2018034,1092012,'F',3,'neck beauty spots','A','cesarean','2018-11-24 12:25:00','healthy','A1007','2018-11-28 12:30:00','None'),(2019238,2019452,1132011,'F',3,'None','AB','natural','2019-06-18 16:20:00','healthy','A1026','2019-06-21 09:25:00','None'),(2019564,2018448,2022014,'M',4,'None','O','natural','2019-09-28 10:40:00','healthy','A1006','2019-09-30 12:50:00','None');
/*!40000 ALTER TABLE `babies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `care_for`
--

DROP TABLE IF EXISTS `care_for`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `care_for` (
  `sid` int(7) NOT NULL,
  `pid` int(11) NOT NULL,
  `care_datetime` datetime NOT NULL,
  `notes` varchar(100) NOT NULL DEFAULT 'None',
  PRIMARY KEY (`sid`,`pid`,`care_datetime`),
  KEY `patient_care_idx` (`pid`) /*!80000 INVISIBLE */,
  KEY `nurse_care_idx` (`sid`),
  CONSTRAINT `nurse_care` FOREIGN KEY (`sid`) REFERENCES `nurses` (`sid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `patient_care` FOREIGN KEY (`pid`) REFERENCES `patients` (`pid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `care_for`
--

LOCK TABLES `care_for` WRITE;
/*!40000 ALTER TABLE `care_for` DISABLE KEYS */;
INSERT INTO `care_for` VALUES (1062015,2015321,'2016-09-23 19:30:00','None'),(1062015,2017332,'2018-10-04 18:30:00','None'),(3242010,2015415,'2018-01-24 17:30:00','vitals'),(3242010,2015415,'2018-01-27 17:00:00','change  bandage'),(3242010,2017001,'2017-11-30 18:30:00','vitals'),(3242010,2018561,'2018-01-24 08:30:00','vitals'),(4232017,2017248,'2017-04-08 19:30:00','vitals'),(4232017,2018297,'2018-10-06 15:00:00','vitals'),(4232017,2018448,'2019-09-28 05:20:00','None'),(4232017,2018478,'2018-01-25 13:35:00','vitals'),(4552013,2015321,'2016-09-23 19:30:00','None'),(4552013,2015415,'2016-01-06 12:30:00','vitals'),(4552013,2015415,'2018-01-25 09:30:00','change bandage'),(6022012,2015415,'2018-01-25 12:30:00','vitals'),(6022012,2015415,'2018-01-29 10:30:00','vitals'),(6022012,2018034,'2018-11-25 08:15:00','change bandage'),(8232011,2015415,'2018-03-28 19:30:00','vitals'),(8232011,2019452,'2019-06-17 19:30:00','None');
/*!40000 ALTER TABLE `care_for` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctors`
--

DROP TABLE IF EXISTS `doctors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctors` (
  `sid` int(7) NOT NULL,
  `license_number` varchar(20) NOT NULL,
  PRIMARY KEY (`sid`),
  UNIQUE KEY `unique_license_number` (`license_number`),
  CONSTRAINT `doctor_is_staff` FOREIGN KEY (`sid`) REFERENCES `staff` (`sid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctors`
--

LOCK TABLES `doctors` WRITE;
/*!40000 ALTER TABLE `doctors` DISABLE KEYS */;
INSERT INTO `doctors` VALUES (2022014,'MP03223457892'),(1132011,'MQ01457617429'),(2462015,'MS00240125727'),(1092012,'MS03346577822');
/*!40000 ALTER TABLE `doctors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nurses`
--

DROP TABLE IF EXISTS `nurses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nurses` (
  `sid` int(7) NOT NULL,
  `license_number` varchar(20) NOT NULL,
  `license_expiry_date` date NOT NULL,
  PRIMARY KEY (`sid`),
  UNIQUE KEY `unique_license_number` (`license_number`),
  CONSTRAINT `nurse_is_staff` FOREIGN KEY (`sid`) REFERENCES `staff` (`sid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nurses`
--

LOCK TABLES `nurses` WRITE;
/*!40000 ALTER TABLE `nurses` DISABLE KEYS */;
INSERT INTO `nurses` VALUES (1062015,'NS12004569978','2025-02-23'),(3242010,'NS02012465785','2021-12-23'),(4232017,'NS44120003467','2027-04-22'),(4552013,'NS44023556782','2023-01-04'),(6022012,'NS00396784423','2022-10-27'),(8232011,'NS92355784311','2026-05-12');
/*!40000 ALTER TABLE `nurses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patients`
--

DROP TABLE IF EXISTS `patients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patients` (
  `pid` int(7) NOT NULL,
  `fname` varchar(45) NOT NULL,
  `lname` varchar(45) NOT NULL,
  `gender` varchar(5) NOT NULL DEFAULT 'F',
  `DoB` date NOT NULL,
  `insurance_number` varchar(45) NOT NULL,
  `blood_type` varchar(2) NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `emergency_contact_name` varchar(45) NOT NULL,
  `emergency_contact_phone_number` varchar(20) NOT NULL,
  `emergency_contact_relationship` varchar(45) NOT NULL,
  `referred_by` varchar(45) NOT NULL DEFAULT 'self',
  PRIMARY KEY (`pid`),
  UNIQUE KEY `unique_insurance_number` (`insurance_number`) /*!80000 INVISIBLE */
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patients`
--

LOCK TABLES `patients` WRITE;
/*!40000 ALTER TABLE `patients` DISABLE KEYS */;
INSERT INTO `patients` VALUES (2015321,'Jan','Nickerson','F','1991-02-25','SK034573932506','O','457-732-2211','Helen Nickerson','457-442-2560','Sister','Friend'),(2015415,'Rachael','Sloan','F','1986-12-06','SK025473043393','O','457-924-9351','Kurt Sloan','457-764-7843','Husband','Self'),(2017001,'Meridith','Brown','F','1989-03-02','SK022233581230','A','457-233-4356','John Brown','457-234-4576','Husband','Friend'),(2017248,'Aorohi','Kabra','F','1988-01-25','SK036548799234','AB','457-654-1238','Maya Kabra','457-543-1234','Sister','Friend'),(2017332,'Pamela','Nickerson','F','1986-07-02','SK036458932677','AB','457-234-5621','Michael Nickerson','457-348-3893','Bother','Friend'),(2018034,'Karen','Nickerson','F','1993-11-26','SK023076445987','AB','457-265-4643','Sara Avery','457-563-5686','Friend','Self'),(2018297,'Liliana','Nikererson','F','2018-10-04','SC036458932677','A','457-234-5621','Pamela Nickerson','457-234-5621','Mother','Family'),(2018448,'Erin','Liu','F','1988-08-08','SK004595606673','O','457-936-2409','Chris Liu','457-876-6132','Husband','Family'),(2018478,'David','Thompson','M','2018-01-24','SC025473043393','AB','457-924-9351','Rachael Sloan','457-924-9351','Mother','Family'),(2018561,'Aida','Diop','F','1986-03-02','SK000347663681','O','457-789-2482','Sarah Cisse','457-234-4512','Mother','Self'),(2018653,'Mina','Lee','F','1991-04-21','SK003363457219','O','457-543-2997','Phyllis Duvalle','457-967-8834','Friend','Family'),(2019452,'Angela','Wang','F','1992-03-02','SK030239755636','O','457-256-4322','Julie Wang','457-232-5421','Sister','Friend');
/*!40000 ALTER TABLE `patients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `sid` int(7) NOT NULL,
  `fname` varchar(45) NOT NULL,
  `lname` varchar(45) NOT NULL,
  `gender` varchar(5) NOT NULL,
  `DoB` date NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `email` varchar(45) NOT NULL,
  `emergency_contact_phone_number` varchar(20) NOT NULL,
  `full_time` tinyint(4) NOT NULL DEFAULT '1',
  `join_date` date NOT NULL,
  `left_date` date DEFAULT NULL,
  PRIMARY KEY (`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (1062015,'Liliana','Kepner','F','1988-08-26','457-765-2507','liliana.kepner@cario.ca','647-239-1834',1,'2015-03-12',NULL),(1092012,'Pierre','Yang','M','1969-10-30','607-256-2339','pierre.yang@cario.ca','453-346-1215',1,'2012-02-06',NULL),(1132011,'Wendy','Grey','F','1972-01-14','876-436-7894','Wendy.grey@cario.ca','453-274-1234',1,'2011-02-06',NULL),(2022014,'Fatima','Avery','F','1981-08-22','345-322-1137','fatima.avery@cario.ca','537-267-3499',1,'2014-07-06',NULL),(2462015,'Emma','Shepperd','F','1976-08-20','507-436-5660','emma.shepperd@cario.ca','349-345-1201',1,'2015-12-02',NULL),(3152017,'Lyanna','DeMarc','F','1981-04-01','607-134-3455','lyanna.demarc@cario.ca','453-274-1234',1,'2017-02-06',NULL),(3242010,'Patience','De Luca','F','1976-11-28','620-1142-3321','patience.deluca@cario.ca','673-455-2210',0,'2010-02-25',NULL),(4232017,'Justin','Hall','M','1990-04-12','457-533-1215','justin.hall@cario.ca','457-753-2111',1,'2017-11-24',NULL),(4552013,'Carrie','Nelson','F','1986-07-31','457-432-9233','carrie.nelson@cario.ca','752-344-4062',1,'2013-02-25',NULL),(5082010,'Jeffrey','Morris','M','1985-06-21','564-234-5675','jeffrey.morris@cario.ca','563-345-1234',1,'2010-10-09',NULL),(5232014,'Terri','Miller','F','1984-12-06','743-347-3467','terri.miller@cario.ca','453-274-1234',0,'2014-07-06',NULL),(6022012,'Christiane','Brown','F','1984-12-02','457-934-6203','christiane.brown@cario.ca','844-125-8317',0,'2012-02-25',NULL),(8232011,'Colin','Walker','M','1984-05-23','457-235-0457','colin.walker@cario.ca','457-432-7354',1,'2011-09-03',NULL);
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `treat`
--

DROP TABLE IF EXISTS `treat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `treat` (
  `sid` int(7) NOT NULL,
  `pid` int(7) NOT NULL,
  `treat_datetime` datetime NOT NULL,
  `reason` varchar(100) NOT NULL,
  `treatment` varchar(100) NOT NULL DEFAULT 'N/A',
  `pregnancy stage` varchar(45) NOT NULL DEFAULT 'N/A',
  `notes` varchar(100) NOT NULL DEFAULT 'None',
  PRIMARY KEY (`sid`,`pid`,`treat_datetime`),
  UNIQUE KEY `unique_doctor_datetime` (`sid`,`treat_datetime`),
  KEY `doctor_treat_idx` (`sid`),
  KEY `patient_is_treated_by_idx` (`pid`),
  CONSTRAINT `doctor_treat` FOREIGN KEY (`sid`) REFERENCES `doctors` (`sid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `patient_is_treated` FOREIGN KEY (`pid`) REFERENCES `patients` (`pid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `treat`
--

LOCK TABLES `treat` WRITE;
/*!40000 ALTER TABLE `treat` DISABLE KEYS */;
INSERT INTO `treat` VALUES (1092012,2015415,'2018-01-25 18:20:00','cesarian wound','medication and bandage','after birth','None'),(1092012,2017001,'2017-10-25 12:05:00','abdominal pain','medication','3rd trimester','None'),(1092012,2018034,'2018-04-26 12:30:00','checkin','medication','1st trimester','None'),(1132011,2015321,'2016-09-23 15:30:00','miscarriage','medication','N/A','None'),(1132011,2015321,'2016-09-26 12:30:00','miscarriage','medication','N/A','None'),(2022014,2015415,'2014-02-15 12:30:00','fertility','medication','fertility treatment','None'),(2022014,2015415,'2015-12-07 10:30:00','abdominal pain','medication','3rd trimester','None'),(2022014,2015415,'2017-01-03 12:30:00','fertlity','medication','fertility treatment','None'),(2022014,2018653,'2018-11-23 10:30:00','checkin','medication','1st trimester','None'),(2022014,2019452,'2019-06-19 16:20:00','low blood pressure','medication','after birth','None'),(2462015,2017332,'2018-05-08 17:25:00','checkin','','2nd trimester','None'),(2462015,2018034,'2018-09-02 12:15:00','checkin','','2nd trimester','None'),(2462015,2018297,'2018-10-04 18:55:00','respiratory issues','N/A','N/A','None'),(2462015,2018297,'2018-10-06 18:55:00','respiratory issues','N/A','N/A','None'),(2462015,2018448,'2019-01-28 10:40:00','first checkin','ultrasound','1st trimester','None'),(2462015,2018478,'2018-01-24 09:00:00','respiratory issues','N/A','N/A','None'),(2462015,2018478,'2018-01-25 09:00:00','respiratory issues','N/A','N/A','None');
/*!40000 ALTER TABLE `treat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visits`
--

DROP TABLE IF EXISTS `visits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `visits` (
  `v_number` int(11) NOT NULL AUTO_INCREMENT,
  `adminid` int(7) NOT NULL,
  `pid` int(11) NOT NULL,
  `sid` int(7) NOT NULL,
  `type` varchar(40) NOT NULL,
  `reason` varchar(100) NOT NULL,
  `checkedin_datetime` datetime DEFAULT NULL,
  `scheduled_datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`v_number`),
  UNIQUE KEY `unique_sid_checkedin` (`sid`,`checkedin_datetime`),
  UNIQUE KEY `unique_sid_scheduled` (`sid`,`scheduled_datetime`) /*!80000 INVISIBLE */,
  UNIQUE KEY `unique_pid_checkedin` (`pid`,`checkedin_datetime`) /*!80000 INVISIBLE */,
  UNIQUE KEY `unique_pid_scheduled` (`pid`,`scheduled_datetime`),
  KEY `visit_doctor_idx` (`sid`),
  KEY `visit_patient_idx` (`pid`),
  KEY `visit_admin_idx` (`adminid`),
  CONSTRAINT `visit_admin` FOREIGN KEY (`adminid`) REFERENCES `admins` (`adminid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `visit_doctor` FOREIGN KEY (`sid`) REFERENCES `doctors` (`sid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `visit_patient` FOREIGN KEY (`pid`) REFERENCES `patients` (`pid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visits`
--

LOCK TABLES `visits` WRITE;
/*!40000 ALTER TABLE `visits` DISABLE KEYS */;
INSERT INTO `visits` VALUES (100,4562010,2018448,2022014,'appointement','ultrasound','2019-03-12 10:30:00','2019-03-12 10:30:00'),(101,2002017,2017248,2022014,'walkin','contraception','2019-03-12 14:30:00',NULL),(102,2002017,2017332,2022014,'appointmenet','checkup/followup','2019-03-12 15:30:00','2019-03-12 15:30:00'),(103,2002017,2019452,2022014,'appointment','ultrasound','2019-03-08 14:30:00','2019-03-08 14:30:00'),(104,4562010,2018561,2022014,'walkin','contraception','2019-03-15 14:30:00',NULL),(105,2332014,2015321,1132011,'appointment','checkup/followup','2018-03-12 10:00:00','2018-03-12 10:00:00'),(106,4562010,2017001,1132011,'appointment','checkup/followup','2018-03-24 10:00:00','2018-03-24 10:00:00'),(107,2002017,2015321,1132011,'appointment','other','2017-07-15 14:00:00','2017-07-15 14:00:00'),(108,4562010,2017248,1132011,'appointment','consultation','2018-12-17 09:00:00','2018-12-17 09:00:00'),(109,4562010,2019452,1132011,'walkin','consultation','2019-05-05 10:00:00',NULL),(110,2332014,2019452,1132011,'appointment','checkup/followup','2019-10-15 11:00:00','2017-10-15 11:00:00'),(111,2002017,2018034,1132011,'walkin','pain','2018-10-15 15:00:00',NULL),(112,4562010,2018653,1092012,'walkin','contraception','2018-12-27 15:00:00',NULL),(113,2002017,2017332,1092012,'appointment','checkup/followup','2018-09-12 15:00:00','2018-09-12 15:00:00'),(114,4562010,2015321,2022014,'appointment','checkup/followup','2016-04-02 10:00:00','2016-04-02 10:00:00'),(115,4562010,2018034,2462015,'appointment','ultrasound','2018-09-12 15:00:00','2018-09-12 15:00:00'),(116,2332014,2017332,2462015,'walkin','pain','2017-09-12 10:00:00',NULL),(117,2332014,2015415,2462015,'appointment','consultation',NULL,'2019-03-08 10:00:00');
/*!40000 ALTER TABLE `visits` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-03-25 14:41:03
