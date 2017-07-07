-- MySQL dump 10.13  Distrib 5.6.23, for Linux (x86_64)
--
-- Host: localhost    Database: gp
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
-- Table structure for table `gp_history`
--

DROP TABLE IF EXISTS `gp_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gp_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `openPrice` float(9,3) DEFAULT '0.000' COMMENT '开盘价',
  `closePrice` float(9,3) DEFAULT '0.000' COMMENT '收盘价',
  `highPrice` float(9,3) DEFAULT '0.000' COMMENT '当天最高价',
  `lowerPrice` float(9,3) DEFAULT '0.000' COMMENT '当天最低价',
  `time` int(11) DEFAULT '0' COMMENT '时间',
  `str_time` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'str_time',
  `code` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'code',
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_code_time` (`code`,`str_time`)
) ENGINE=InnoDB AUTO_INCREMENT=1301109 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='历年股票数据';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `m_gp_list`
--

DROP TABLE IF EXISTS `m_gp_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_gp_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `code` varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'code',
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '名称',
  `category` set('normal','c300') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'normal' COMMENT 'normal:普通，c300:沪深300',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2855 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='股票列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `parse_json`
--

DROP TABLE IF EXISTS `parse_json`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parse_json` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `code` varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'code',
  `data` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=8566 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='分析结果';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sina_web_page`
--

DROP TABLE IF EXISTS `sina_web_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sina_web_page` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `info_key` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '股票名称:code:year:jd',
  `url` varchar(200) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '页面链接',
  `http_code` int(11) DEFAULT '0' COMMENT 'http code',
  `html_page` longtext COLLATE utf8_unicode_ci COMMENT 'html page',
  `flg` int(11) DEFAULT '0' COMMENT 'flg|1:已解析,0:未解析',
  PRIMARY KEY (`id`),
  KEY `IDX_tesinx_info_key` (`info_key`),
  KEY `IDX_flg` (`flg`),
  KEY `IDX_url` (`url`)
) ENGINE=InnoDB AUTO_INCREMENT=20171 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='新浪采集的页面｛k线数据原始页面｝';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-07-07 16:18:37
