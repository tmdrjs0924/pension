-- MariaDB dump 10.19  Distrib 10.5.11-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: pension
-- ------------------------------------------------------
-- Server version	10.5.11-MariaDB

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
-- Table structure for table `board`
--

DROP TABLE IF EXISTS `board`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `board` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` char(10) DEFAULT NULL,
  `content` text DEFAULT NULL,
  `pwd` char(10) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `writeday` date DEFAULT NULL,
  `readnum` int(11) DEFAULT 0,
  `dest` char(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3244 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board`
--

LOCK TABLES `board` WRITE;
/*!40000 ALTER TABLE `board` DISABLE KEYS */;
INSERT INTO `board` VALUES (1,'sg','하하하','1','오늘은 목요일','2023-01-12',4,'0'),(2,'sg','ㅎㅎ','1','TT','2023-01-12',6,'0'),(12,'관리자','ㅎㅎ','1','Today Is Friday!!!!!','2023-01-13',2,'0'),(2535,'관리자','ㅎㅎㅎ','1','오늘은 즐거운 금요일!2522','2023-01-13',1,'0'),(2579,'관리자2','ㅎㅎㅎ','1','오늘은 즐거운 금요일!2566','2023-01-13',13,'0'),(2581,'관리자','ㅎ','1','공지','2023-01-16',3,'0'),(2582,'gg','ggggg','1','redirect error','2023-01-16',3,'0'),(2585,'하하','하하','1','하하','2023-01-17',7,'0'),(2586,'ㅁㅁ','ㅁ','1','오늘은 화요일','2023-01-17',0,'0'),(2587,'ㅎㅎ','ㅎ','1','내일은 수요일','2023-01-17',0,'0'),(2588,'ㅎ','ㅎ','1','이번주 설연휴','2023-01-17',0,'0'),(2621,'관리자','ㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎ','1234','<공지사항> 설 연휴 휴무안내','2023-01-17',13,'0'),(3224,'ㅎ@','ㅎ@','1','비밀글!@','2023-01-18',8,'1'),(3225,'ㅎ','ㅎ','1','하하하','2023-01-18',5,'1'),(3226,'ㅎㅎ','ㅎㅎ','1','gggggg','2023-01-19',1,'0'),(3227,'aaaaaaaaa','aaaaa','1','aaaaa','2023-01-26',0,'1,6,'),(3243,'ㅎㅎ','gg','a','오늘은 목요일','2023-01-26',0,'0,2,4,7,');
/*!40000 ALTER TABLE `board` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) DEFAULT NULL,
  `img` varchar(500) DEFAULT NULL,
  `writeday` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
INSERT INTO `event` VALUES (1,'gg','e11.png','2023-04-03'),(2,'dd','e31.png','2023-04-03'),(3,'ss','e21.png','2023-04-03'),(4,'aa','e41.png','2023-04-03');
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gongji`
--

DROP TABLE IF EXISTS `gongji`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gongji` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL,
  `content` text DEFAULT NULL,
  `readnum` int(11) DEFAULT 0,
  `chk` int(11) DEFAULT NULL,
  `writeday` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gongji`
--

LOCK TABLES `gongji` WRITE;
/*!40000 ALTER TABLE `gongji` DISABLE KEYS */;
/*!40000 ALTER TABLE `gongji` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manto`
--

DROP TABLE IF EXISTS `manto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `que` int(11) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `content` text DEFAULT NULL,
  `userid` char(10) DEFAULT NULL,
  `writeday` date DEFAULT NULL,
  `answer` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manto`
--

LOCK TABLES `manto` WRITE;
/*!40000 ALTER TABLE `manto` DISABLE KEYS */;
/*!40000 ALTER TABLE `manto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `member` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `state` int(11) DEFAULT NULL,
  `name` char(10) DEFAULT NULL,
  `userid` char(10) DEFAULT NULL,
  `pwd` char(10) DEFAULT NULL,
  `phone` char(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `writeday` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES (1,1,'승건\n','ksg','123','010-1234-1234','tmdrjs@naver.com','2023-04-04'),(2,0,'관리자','admin','123',NULL,NULL,NULL);
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reserve`
--

DROP TABLE IF EXISTS `reserve`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reserve` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `room_id` int(11) DEFAULT NULL,
  `chacol` int(11) DEFAULT NULL,
  `bbq` int(11) DEFAULT NULL,
  `inwon` int(11) DEFAULT NULL,
  `tprice` int(11) DEFAULT NULL,
  `inday` date DEFAULT NULL,
  `outday` date DEFAULT NULL,
  `userid` char(10) DEFAULT NULL,
  `jcode` char(12) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `writeday` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reserve`
--

LOCK TABLES `reserve` WRITE;
/*!40000 ALTER TABLE `reserve` DISABLE KEYS */;
INSERT INTO `reserve` VALUES (1,1,1,4,3,260000,'2023-04-22','2023-04-23','ksg','j202340101',NULL,'2023-04-03');
/*!40000 ALTER TABLE `reserve` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `room` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `price` int(11) DEFAULT NULL,
  `min` int(11) DEFAULT NULL,
  `max` int(11) DEFAULT NULL,
  `name` char(10) DEFAULT NULL,
  `img` varchar(500) DEFAULT NULL,
  `content` text DEFAULT NULL,
  `writeday` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room`
--

LOCK TABLES `room` WRITE;
/*!40000 ALTER TABLE `room` DISABLE KEYS */;
INSERT INTO `room` VALUES (6,120000,2,4,'프리미엄','pic_009.jpg1.jpg,pic_006.jpg1.jpg,pic_020.jpg1.jpg,','- 일반\r\n55” HD TV, 60” HD TV, 미니바, 티포트, 사무용 데스크 (문구류 포함), 전화기, 우산, 구둣주걱\r\n\r\n- 욕실\r\n세면대 2개, 면봉, 비데, 샤워 캡, 슬리퍼, 욕실용품 (Diptyque), 욕조, 목욕 가운, 헤어드라이어\r\n\r\n- 기타\r\n케이블 위성 TV 채널, 무료 생수 1일 2병, 커피 및 티 메이커, 무료 일간 신문, 옷솔, 무료 다림질 서비스 (1일 2점)','2023-04-04'),(7,240000,4,6,'스위트','pic_008.jpg.jpg,pic_018.jpg.jpg,pic_017.jpg.jpg,','- 일반\r\n55” HD TV, 60” HD TV, 미니바, 티포트, 사무용 데스크 (문구류 포함), 전화기, 우산, 구둣주걱\r\n\r\n- 욕실\r\n세면대 4개, 면봉, 비데, 샤워 캡, 슬리퍼, 욕실용품 (Diptyque), 욕조, 목욕 가운, 헤어드라이어\r\n\r\n- 기타\r\n케이블 위성 TV 채널, 무료 생수 1일 4병, 커피 및 티 메이커, 무료 일간 신문, 옷솔, 무료 다림질 서비스 (1일 4점)','2023-04-04');
/*!40000 ALTER TABLE `room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tour`
--

DROP TABLE IF EXISTS `tour`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tour` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL,
  `content` text DEFAULT NULL,
  `fname` varchar(100) DEFAULT NULL,
  `readnum` int(11) DEFAULT 0,
  `userid` char(10) DEFAULT NULL,
  `writeday` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tour`
--

LOCK TABLES `tour` WRITE;
/*!40000 ALTER TABLE `tour` DISABLE KEYS */;
/*!40000 ALTER TABLE `tour` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-04-04 13:24:38
