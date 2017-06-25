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

/*Data for the table `t_permission` */

insert  into `t_permission`(`id`,`role`,`permission`) values (16,'admin','admin:query'),(17,'admin','department:query'),(18,'admin','accountType:query'),(19,'admin','accountType:update'),(20,'admin','department:add'),(21,'admin','department:delete'),(22,'admin','department:update'),(23,'admin','navigation:add'),(24,'admin','navigation:delete'),(25,'admin','navigation:update'),(26,'leader','leader:query'),(27,'leader','leaderDep:update'),(28,'leader','page:query'),(29,'leader','file:query'),(30,'teacher','runas:query'),(31,'teacher','runas:add'),(32,'teacher','runas:delete'),(33,'teacher','page:query'),(34,'teacher','file:query'),(35,'teacher','file:delete'),(36,'teacher','file:update'),(37,'reviewing','page:query'),(38,'reviewing','file:query'),(39,'leader','depAndPro:query'),(40,'teacher','file:add'),(41,'admin','depAndPro:query'),(42,'admin','file:query');

/*Table structure for table `t_power` */

DROP TABLE IF EXISTS `t_power`;

CREATE TABLE `t_power` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `permission` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '权限',
  `explanation` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '解释',
  PRIMARY KEY (`id`,`permission`),
  KEY `character` (`permission`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='角色表';

/*Data for the table `t_power` */

insert  into `t_power`(`id`,`permission`,`explanation`) values (6,'admin:query','访问管理员页面'),(7,'leader:query','领导选择系页面'),(8,'department:query','查找所有系'),(9,'accountType:query','查看各角色的账户'),(10,'accountType:update','改变用户的角色'),(11,'department:add','增加系别专业'),(12,'department:delete','删除系别专业'),(13,'department:update','修改系别专业'),(14,'navigation:add','增加导航'),(15,'navigation:delete','删除导航'),(16,'navigation:update','修改导航'),(17,'runas:query','查询授权信息'),(18,'runas:add','增加授权'),(19,'runas:delete','取消授权'),(20,'leaderDep:update','更改领导的系别'),(21,'page:query','访问主页'),(22,'file:query','找到文件夹和文件'),(23,'depAndPro:query','查找系和专业'),(24,'fileItem:query','查找文件条目'),(25,'file:delete','删除文件'),(26,'file:update','修改文件'),(27,'file:add','增加文件');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
