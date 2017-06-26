/*
SQLyog Professional v12.08 (64 bit)
MySQL - 5.7.18 : Database - db_teacher
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`db_teacher` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `db_teacher`;

/*Table structure for table `t_account` */

DROP TABLE IF EXISTS `t_account`;

CREATE TABLE `t_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `uid` varchar(40) COLLATE utf8_bin NOT NULL COMMENT '操作标识',
  `username` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '账号',
  `password` varchar(40) COLLATE utf8_bin NOT NULL COMMENT '密码',
  `name` varchar(10) COLLATE utf8_bin NOT NULL COMMENT '姓名',
  `mail` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '邮件',
  `role` varchar(20) COLLATE utf8_bin DEFAULT 'reviewing' COMMENT '角色',
  `depUid` varchar(40) COLLATE utf8_bin DEFAULT NULL,
  `validataCode` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '找回密码的UUID',
  `outDate` datetime DEFAULT NULL COMMENT '找回密码的过期时间',
  PRIMARY KEY (`id`,`username`,`uid`),
  KEY `account` (`username`),
  KEY `account_2` (`username`),
  KEY `FK_t_account_character` (`role`),
  KEY `uid` (`uid`),
  KEY `FK_depUid_dep_uid` (`depUid`),
  CONSTRAINT `FK_ROLE` FOREIGN KEY (`role`) REFERENCES `t_character` (`role`),
  CONSTRAINT `FK_depUid_dep_uid` FOREIGN KEY (`depUid`) REFERENCES `t_department` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=828 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='账号表';

/*Table structure for table `t_authorization` */

DROP TABLE IF EXISTS `t_authorization`;

CREATE TABLE `t_authorization` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accUid` varchar(40) COLLATE utf8_bin NOT NULL,
  `beAccUid` varchar(40) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_accUid` (`accUid`),
  KEY `FK_beAccUid` (`beAccUid`),
  CONSTRAINT `FK_accUid` FOREIGN KEY (`accUid`) REFERENCES `t_account` (`uid`),
  CONSTRAINT `FK_beAccUid` FOREIGN KEY (`beAccUid`) REFERENCES `t_account` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Table structure for table `t_character` */

DROP TABLE IF EXISTS `t_character`;

CREATE TABLE `t_character` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `role` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '角色',
  `explanation` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '解释',
  PRIMARY KEY (`id`,`role`),
  KEY `character` (`role`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='角色表';

/*Table structure for table `t_department` */

DROP TABLE IF EXISTS `t_department`;

CREATE TABLE `t_department` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `content` varchar(40) COLLATE utf8_bin DEFAULT NULL,
  `parent` varchar(40) COLLATE utf8_bin DEFAULT NULL COMMENT '为0时是系别，等于id时是专业',
  `uid` varchar(40) COLLATE utf8_bin NOT NULL COMMENT '操作标识',
  PRIMARY KEY (`id`,`uid`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=638 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='系别';

/*Table structure for table `t_file` */

DROP TABLE IF EXISTS `t_file`;

CREATE TABLE `t_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `accUid` varchar(40) COLLATE utf8_bin NOT NULL COMMENT '账号标识',
  `navUid` varchar(40) COLLATE utf8_bin NOT NULL COMMENT '系别模块id',
  `upTime` datetime NOT NULL COMMENT '时间',
  `title` varchar(40) COLLATE utf8_bin NOT NULL COMMENT '文本标题',
  `url` varchar(200) COLLATE utf8_bin NOT NULL COMMENT '操作标识',
  `filePath` text COLLATE utf8_bin NOT NULL COMMENT '文件实体路径',
  `uid` varchar(40) COLLATE utf8_bin NOT NULL COMMENT '查询标识',
  PRIMARY KEY (`id`,`uid`),
  KEY `FK_t_file_info_account` (`accUid`),
  KEY `FK_t_file_info_navigation_id` (`navUid`) USING BTREE,
  KEY `uid` (`uid`),
  CONSTRAINT `FK_accUid_t_account_uid` FOREIGN KEY (`accUid`) REFERENCES `t_account` (`uid`),
  CONSTRAINT `Fk_navUid_t_nav_Uid` FOREIGN KEY (`navUid`) REFERENCES `t_navigation` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='数据表9';

/*Table structure for table `t_file_item` */

DROP TABLE IF EXISTS `t_file_item`;

CREATE TABLE `t_file_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `uid` varchar(40) COLLATE utf8_bin NOT NULL COMMENT '查询标识',
  `filename` varchar(200) COLLATE utf8_bin NOT NULL COMMENT '文件名',
  `fileUid` varchar(40) COLLATE utf8_bin DEFAULT NULL,
  `datatype` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `showing` int(11) unsigned zerofill NOT NULL,
  `position` int(11) NOT NULL COMMENT '在文章中的位置',
  `prefix` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '后缀',
  PRIMARY KEY (`id`,`uid`),
  KEY `uid` (`uid`),
  KEY `FK_fileUId_t_file_uId` (`fileUid`),
  CONSTRAINT `FK_fileUId_t_file_uId` FOREIGN KEY (`fileUid`) REFERENCES `t_file` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='数据表9';

/*Table structure for table `t_navigation` */

DROP TABLE IF EXISTS `t_navigation`;

CREATE TABLE `t_navigation` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `parent` varchar(40) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '等于0一级，等于Uid的为UID子目录',
  `title` varchar(30) COLLATE utf8_bin NOT NULL,
  `url` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `extend` int(11) NOT NULL DEFAULT '0',
  `uid` varchar(40) COLLATE utf8_bin NOT NULL COMMENT '查询的唯一标识',
  `depUid` varchar(40) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`,`uid`),
  KEY `uid` (`uid`),
  KEY `FK_depUid` (`depUid`),
  CONSTRAINT `FK_depUid` FOREIGN KEY (`depUid`) REFERENCES `t_department` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Table structure for table `t_permission` */

DROP TABLE IF EXISTS `t_permission`;

CREATE TABLE `t_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `role` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '角色',
  `permission` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '分类:操作',
  PRIMARY KEY (`id`),
  KEY `FK_role_cha_role` (`role`),
  KEY `FK_per_cha_per` (`permission`),
  CONSTRAINT `FK_per_cha_per` FOREIGN KEY (`permission`) REFERENCES `t_power` (`permission`),
  CONSTRAINT `FK_role_cha_role` FOREIGN KEY (`role`) REFERENCES `t_character` (`role`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Table structure for table `t_power` */

DROP TABLE IF EXISTS `t_power`;

CREATE TABLE `t_power` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `permission` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '权限',
  `explanation` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '解释',
  PRIMARY KEY (`id`,`permission`),
  KEY `character` (`permission`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='角色表';

/* Trigger structure for table `t_account` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `delete_author_accUid_by_uid` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'%' */ /*!50003 TRIGGER `delete_author_accUid_by_uid` BEFORE DELETE ON `t_account` FOR EACH ROW DELETE FROM `t_authorization` WHERE `accUid`=old.uid */$$


DELIMITER ;

/* Trigger structure for table `t_account` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `delete_author_beAccUid_by_uid` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'%' */ /*!50003 TRIGGER `delete_author_beAccUid_by_uid` BEFORE DELETE ON `t_account` FOR EACH ROW DELETE FROM `t_authorization` WHERE `beAccUid`=old.uid */$$


DELIMITER ;

/* Trigger structure for table `t_file` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `delete_file_item_before` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'%' */ /*!50003 TRIGGER `delete_file_item_before` BEFORE DELETE ON `t_file` FOR EACH ROW DELETE FROM `t_file_item` WHERE (`fileUid`=old.uid) */$$


DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
