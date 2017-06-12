-- MySQL dump 10.13  Distrib 5.6.23, for Linux (x86_64)
--
-- Host: localhost    Database: test
-- ------------------------------------------------------
-- Server version	5.6.23

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `system_account`
--

DROP TABLE IF EXISTS `system_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system_account` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `role_id` int(11) NOT NULL DEFAULT '0' COMMENT '角色id',
  `account_name` varchar(100) NOT NULL DEFAULT '' COMMENT '登录账号',
  `passwd` varchar(100) NOT NULL DEFAULT '' COMMENT '密码',
  `email` varchar(50) NOT NULL DEFAULT '' COMMENT 'email',
  `phone` varchar(20) NOT NULL DEFAULT '' COMMENT 'phone',
  `status` tinyint(1) NOT NULL DEFAULT '2' COMMENT '状态[1:启用, 2:禁用]',
  `note` varchar(200) NOT NULL DEFAULT '' COMMENT '备注信息',
  `created_at` int(11) NOT NULL DEFAULT '0',
  `updated_at` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_account`
--

LOCK TABLES `system_account` WRITE;
/*!40000 ALTER TABLE `system_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_menu`
--

DROP TABLE IF EXISTS `system_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system_menu` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `parent_id` int(11) NOT NULL DEFAULT '0' COMMENT '父级id',
  `menu_name` varchar(100) NOT NULL DEFAULT '' COMMENT '名称',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '链接',
  `icon` varchar(100) NOT NULL DEFAULT '' COMMENT '图标',
  `status` tinyint(1) NOT NULL DEFAULT '2' COMMENT '状态[1:启用, 2:禁用]',
  `note` varchar(200) NOT NULL DEFAULT '' COMMENT '备注信息',
  `created_at` int(11) NOT NULL DEFAULT '0',
  `updated_at` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_menu`
--

LOCK TABLES `system_menu` WRITE;
/*!40000 ALTER TABLE `system_menu` DISABLE KEYS */;
INSERT INTO `system_menu` VALUES (1,0,'系统管理123','','icon-plus',1,'xxxx',0,2017),(2,1,'导航管理','/system/index/','icon-plus',1,'123',0,2017),(3,1,'账号管理','/system/account/','icon-plus',1,'',0,0),(4,1,'角色管理','/system/role/','icon-plus',1,'',0,2017),(5,0,'任务分析','','icon-plus',1,'xx',0,0),(6,5,'分析示例','/socket/index','icon-plus',1,'',0,0),(7,5,'socketIO','/socket/socketIO','icon-plus',1,'',0,2017),(8,0,'test1111','','icon-plus',1,'',0,2017),(9,0,'test222','','icon-plus',1,'',0,2017),(10,0,'test333','','icon-plus',1,'',0,2017),(11,10,'bbb','/test/test','icon-plus',1,'',0,0),(12,0,'test123','','icon-plus',1,'',0,0),(13,12,'xxxxssssgg','xxx','icon-plus',1,'xxxx',0,2017);
/*!40000 ALTER TABLE `system_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_role`
--

DROP TABLE IF EXISTS `system_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system_role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `role_name` varchar(100) NOT NULL DEFAULT '' COMMENT '角色名称',
  `menu_ids` varchar(1000) NOT NULL DEFAULT '' COMMENT '对menu查看权限，{1,2,3}',
  `status` tinyint(1) NOT NULL DEFAULT '2' COMMENT '状态[1:启用, 2:禁用]',
  `note` varchar(200) NOT NULL DEFAULT '' COMMENT '备注信息',
  `created_at` int(11) NOT NULL DEFAULT '0',
  `updated_at` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_role`
--

LOCK TABLES `system_role` WRITE;
/*!40000 ALTER TABLE `system_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (5,'xiaomin1496374477','xiaomin@foxmail.com1496374477','0000-00-00 00:00:00','0000-00-00 00:00:00'),(6,'xiaomin1496374478','john@foo.com','0000-00-00 00:00:00','2017-06-02 05:25:33'),(7,'xiaomin1496374574','xiaomin@foxmail.com1496374574','0000-00-00 00:00:00','0000-00-00 00:00:00'),(8,'xiaomin1496374615','xiaomin@foxmail.com1496374615','0000-00-00 00:00:00','0000-00-00 00:00:00'),(9,'xiaomin1496374644','xiaomin@foxmail.com1496374644','0000-00-00 00:00:00','0000-00-00 00:00:00'),(10,'xiaomin1496374656','xiaomin@foxmail.com1496374656','0000-00-00 00:00:00','0000-00-00 00:00:00'),(11,'xiaomin1496374686','xiaomin@foxmail.com1496374686','0000-00-00 00:00:00','0000-00-00 00:00:00'),(12,'xiaomin1496374698','xiaomin@foxmail.com1496374698','0000-00-00 00:00:00','0000-00-00 00:00:00'),(13,'xiaomin1496374738','xiaomin@foxmail.com1496374738','0000-00-00 00:00:00','0000-00-00 00:00:00'),(14,'xiaomin1496378347','xiaomin@foxmail.com1496378347','2017-06-02 04:39:07','0000-00-00 00:00:00'),(15,'xiaomin1496378442','xiaomin@foxmail.com1496378442','2017-06-02 04:40:42','2017-06-02 04:40:42'),(16,'xiaomin1496378443','xiaomin@foxmail.com1496378443','2017-06-02 04:40:43','2017-06-02 04:40:43'),(17,'xiaomin1496378587','xiaomin@foxmail.com1496378587','2017-06-02 04:43:07','2017-06-02 04:43:07'),(18,'xiaomin1496378699','xiaomin@foxmail.com1496378699','2017-06-02 04:44:59','2017-06-02 04:44:59'),(19,'xiaomin1496378770','xiaomin@foxmail.com1496378770','2017-06-02 04:46:10','2017-06-02 04:46:10'),(20,'xiaomin1496378818','xiaomin@foxmail.com1496378818','2017-06-02 04:46:58','2017-06-02 04:46:58');
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

-- Dump completed on 2017-06-12 13:07:39
