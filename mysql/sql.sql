/*
SQLyog Ultimate v11.11 (64 bit)
MySQL - 5.7.17 : Database - db_teacher
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
  CONSTRAINT `FK_depUid_dep_uid` FOREIGN KEY (`depUid`) REFERENCES `t_department` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=219 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='账号表';

/*Data for the table `t_account` */

insert  into `t_account`(`id`,`uid`,`username`,`password`,`name`,`mail`,`role`,`depUid`,`validataCode`,`outDate`) values (209,'9c138227-4015-4ab1-979b-ffd54348cfb3','znhoznho','e0bbb65e628dd40297ee1ef12198427c','znhoznho','wsxzh22@163.com','admin','7020304c-cc1d-41ea-bf17-d4b154378ae4','6d9b3825-3131-48c3-86b0-6630a72251ed','2017-06-06 17:53:37'),(217,'741d2f58-3e0c-466b-bc4c-1bda2580f60c','wqeqweqw','070a8b2181f8486e17d2340f5474c99b','sddasdasd','850582531@qq.com','reviewing','29948d32-7d3a-4ada-8047-aebbd15e8636',NULL,NULL),(218,'835b8a58-f545-41ef-97b4-a561ef72c7d4','wewewsewew','f26a60621dd9f0262a919380fce469e2','sdasdsad','qweqwe@163.com','reviewing','7020304c-cc1d-41ea-bf17-d4b154378ae4',NULL,NULL);

/*Table structure for table `t_authorization` */

DROP TABLE IF EXISTS `t_authorization`;

CREATE TABLE `t_authorization` (
  `id` int(11) NOT NULL,
  `accUid` varchar(40) COLLATE utf8_bin NOT NULL,
  `beAccUid` varchar(40) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_accUid` (`accUid`),
  KEY `FK_beAccUid` (`beAccUid`),
  CONSTRAINT `FK_accUid` FOREIGN KEY (`accUid`) REFERENCES `t_account` (`uid`),
  CONSTRAINT `FK_beAccUid` FOREIGN KEY (`beAccUid`) REFERENCES `t_account` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `t_authorization` */

/*Table structure for table `t_character` */

DROP TABLE IF EXISTS `t_character`;

CREATE TABLE `t_character` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `role` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '角色',
  `explanation` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '解释',
  PRIMARY KEY (`id`,`role`),
  KEY `character` (`role`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='角色表';

/*Data for the table `t_character` */

insert  into `t_character`(`id`,`role`,`explanation`) values (1,'admin','管理员'),(2,'leader','领导'),(3,'teacher','教师'),(4,'reviewing','待审核用户');

/*Table structure for table `t_department` */

DROP TABLE IF EXISTS `t_department`;

CREATE TABLE `t_department` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `content` varchar(40) COLLATE utf8_bin DEFAULT NULL,
  `parent` varchar(40) COLLATE utf8_bin DEFAULT NULL COMMENT '为0时是系别，等于id时是专业',
  `uid` varchar(40) COLLATE utf8_bin NOT NULL COMMENT '操作标识',
  PRIMARY KEY (`id`,`uid`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=415 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='系别';

/*Data for the table `t_department` */

insert  into `t_department`(`id`,`content`,`parent`,`uid`) values (401,'计算机系','0','a434d90d-a267-457c-8e10-89028ce6ed27'),(402,'软件技术','a434d90d-a267-457c-8e10-89028ce6ed27','29948d32-7d3a-4ada-8047-aebbd15e8636'),(403,'移动应用','a434d90d-a267-457c-8e10-89028ce6ed27','b036d42e-1110-4d3e-84b2-87a07c95b422'),(404,'管理系','0','c72c7b69-5770-47fb-bb25-51b476e55373'),(405,'财经系','0','b3964e6b-89eb-4dac-9b8e-f290070fa877'),(406,'艺术系','0','cb6b88e6-de96-4d73-894e-2b80b8693105'),(407,'机电系','0','cf39e05d-8cc0-4591-9ed7-ce0146b7e94b'),(408,'信管','a434d90d-a267-457c-8e10-89028ce6ed27','6f5d85b2-2de0-4e09-a233-1fda040f228b'),(409,'物流','c72c7b69-5770-47fb-bb25-51b476e55373','7020304c-cc1d-41ea-bf17-d4b154378ae4'),(410,'金融','b3964e6b-89eb-4dac-9b8e-f290070fa877','15fc2163-3bb6-4f61-bf60-abcd1136a4d5'),(411,'数控','cf39e05d-8cc0-4591-9ed7-ce0146b7e94b','4a7daf02-f09f-43d3-904f-71c1fe632ef5'),(412,'产品造型设计','cb6b88e6-de96-4d73-894e-2b80b8693105','192cab96-5956-418b-a883-19519f99e2c5'),(413,'多媒体设计与制作','cb6b88e6-de96-4d73-894e-2b80b8693105','c6cc4472-d330-4fe0-b5f3-ef349029a7ad'),(414,'环境艺术设计','cb6b88e6-de96-4d73-894e-2b80b8693105','35624ca7-2e71-4c62-8dc8-ddb36686b84d');

/*Table structure for table `t_file` */

DROP TABLE IF EXISTS `t_file`;

CREATE TABLE `t_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `accUid` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '账号标识',
  `navUid` varchar(40) COLLATE utf8_bin NOT NULL COMMENT '系别模块id',
  `upTime` datetime NOT NULL COMMENT '时间',
  `title` varchar(40) COLLATE utf8_bin NOT NULL COMMENT '文本标题',
  `url` varchar(200) COLLATE utf8_bin NOT NULL COMMENT '操作标识',
  `filePath` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '文件实体路径',
  `uid` varchar(40) COLLATE utf8_bin NOT NULL COMMENT '查询标识',
  PRIMARY KEY (`id`,`uid`),
  KEY `FK_t_file_info_account` (`accUid`),
  KEY `FK_t_file_info_navigation_id` (`navUid`) USING BTREE,
  CONSTRAINT `FK_accUid_t_account_uid` FOREIGN KEY (`accUid`) REFERENCES `t_account` (`uid`),
  CONSTRAINT `Fk_navUid_t_nav_Uid` FOREIGN KEY (`navUid`) REFERENCES `t_navigation` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='数据表9';

/*Data for the table `t_file` */

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `t_navigation` */

/*Table structure for table `t_permission` */

DROP TABLE IF EXISTS `t_permission`;

CREATE TABLE `t_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `role` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '角色',
  `permission` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '分类:操作',
  PRIMARY KEY (`id`),
  KEY `FK_role_cha_role` (`role`),
  CONSTRAINT `FK_role_cha_role` FOREIGN KEY (`role`) REFERENCES `t_character` (`role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `t_permission` */

/* Procedure structure for procedure `test` */

/*!50003 DROP PROCEDURE IF EXISTS  `test` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `test`()
BEGIN
    declare c int default 0;
    select c ;
END */$$
DELIMITER ;

/*Table structure for table `v_account_info` */

DROP TABLE IF EXISTS `v_account_info`;

/*!50001 DROP VIEW IF EXISTS `v_account_info` */;
/*!50001 DROP TABLE IF EXISTS `v_account_info` */;

/*!50001 CREATE TABLE  `v_account_info`(
 `id` int(11) ,
 `username` varchar(20) ,
 `name` varchar(10) ,
 `mail` varchar(30) ,
 `role` varchar(20) ,
 `department_id` varchar(40) ,
 `dep_content` varchar(40) ,
 `profession_id` varchar(40) ,
 `content` varchar(40) 
)*/;

/*View structure for view v_account_info */

/*!50001 DROP TABLE IF EXISTS `v_account_info` */;
/*!50001 DROP VIEW IF EXISTS `v_account_info` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_account_info` AS select `t_account`.`id` AS `id`,`t_account`.`username` AS `username`,`t_account`.`name` AS `name`,`t_account`.`mail` AS `mail`,`t_account`.`role` AS `role`,`t_department`.`parent` AS `department_id`,(select `t_department`.`content` from `t_department` where (`t_department`.`id` = `department_id`)) AS `dep_content`,`t_department`.`uid` AS `profession_id`,`t_department`.`content` AS `content` from (`t_account` join `t_department` on((`t_account`.`depUid` = `t_department`.`uid`))) */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
