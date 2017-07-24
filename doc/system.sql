-- MySQL dump 10.13  Distrib 5.6.23, for Linux (x86_64)
--
-- Host: localhost    Database: system
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
  `role_id` varchar(300) NOT NULL DEFAULT '' COMMENT '角色',
  `account_name` varchar(100) NOT NULL DEFAULT '' COMMENT '登录账号',
  `passwd` varchar(100) NOT NULL DEFAULT '' COMMENT '密码',
  `email` varchar(50) NOT NULL DEFAULT '' COMMENT 'email',
  `phone` varchar(20) NOT NULL DEFAULT '' COMMENT 'phone',
  `status` tinyint(1) NOT NULL DEFAULT '2' COMMENT '状态[1:启用, 2:禁用]',
  `note` varchar(200) NOT NULL DEFAULT '' COMMENT '备注信息',
  `created_at` int(11) NOT NULL DEFAULT '0',
  `updated_at` int(11) NOT NULL DEFAULT '0',
  `nickname` varchar(30) NOT NULL DEFAULT '' COMMENT '昵称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_account`
--

LOCK TABLES `system_account` WRITE;
/*!40000 ALTER TABLE `system_account` DISABLE KEYS */;
INSERT INTO `system_account` VALUES (1,'1,3','admin','e10adc3949ba59abbe56e057f20f883e','123456@qq.com','13812341234',2,'xxx',0,2017,'管理员'),(2,'1,2,3','superadmin','e10adc3949ba59abbe56e057f20f883e','513413@qq.com','123412341235',1,'xxx',0,2017,'超级管理员'),(3,'4','test','e10adc3949ba59abbe56e057f20f883e','test@qq.com','13812341256',1,'test',0,0,'测试账号');
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
  `type` tinyint(1) NOT NULL DEFAULT '2' COMMENT '类别[1:导航, 2:功能]',
  `controller` varchar(100) NOT NULL DEFAULT '' COMMENT '控制器',
  `action` varchar(100) NOT NULL DEFAULT '' COMMENT '方法',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_menu`
--

LOCK TABLES `system_menu` WRITE;
/*!40000 ALTER TABLE `system_menu` DISABLE KEYS */;
INSERT INTO `system_menu` VALUES (1,0,'系统管理','','icon-plus',1,'xxxx',0,2017,2,'',''),(2,1,'导航管理','/system/index/','icon-plus',1,'123',0,2017,1,'system','index'),(3,1,'账号管理','/system/account/','icon-plus',1,'',0,2017,1,'system','account'),(4,1,'角色管理','/system/role/','icon-plus',1,'',0,2017,1,'system','role'),(5,0,'任务分析','','icon-plus',1,'xx',0,0,2,'',''),(6,5,'分析示例','/socket/index','icon-plus',1,'',0,2017,1,'socket','index'),(7,5,'socketIO','/socket/socketIO','icon-plus',1,'',0,2017,1,'socket','socketIO'),(8,5,'测试','','icon-plus',1,'',0,2017,2,'test','index'),(9,0,'test222','','icon-plus',1,'',0,2017,2,'',''),(10,0,'各种示例','','icon-plus',1,'',0,2017,1,'',''),(11,10,'bbb','/test/test','icon-plus',1,'',0,0,2,'',''),(12,0,'test123','','icon-plus',1,'',0,0,2,'',''),(13,12,'xxxxssssgg','xxx','icon-plus',1,'xxxx',0,2017,2,'',''),(14,5,'ws','','',1,'swoole websocket',0,0,1,'socket','ws'),(15,5,'历史数据','','',1,'gp',0,2017,1,'shares','index'),(16,5,'elasticsearch','','',1,'',0,0,1,'search','index'),(17,5,'列表','','',1,'',0,2017,1,'shares','list'),(18,5,'详情','','',1,'',0,0,2,'shares','detail'),(19,10,'ztree','','',1,'',0,0,1,'ztree','index');
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_role`
--

LOCK TABLES `system_role` WRITE;
/*!40000 ALTER TABLE `system_role` DISABLE KEYS */;
INSERT INTO `system_role` VALUES (1,'管理员','3,4,6,8',1,'nnnnnnnnnnn',0,2017),(2,'超级管理员','2,3,4,6,7,14,15,16,17,18,11,19,13',1,'xxx123',0,2017),(3,'一般管理员','4',1,'ss',0,2017),(4,'test','2,3,4',1,'tet',0,0);
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
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (21,'xx','yy'),(22,'xx','yy'),(24,'lily','78910@qq.com'),(26,'lily','78910@qq.com'),(28,'lily','78910@qq.com'),(30,'lily','78910@qq.com');
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

-- Dump completed on 2017-07-24 10:58:07
