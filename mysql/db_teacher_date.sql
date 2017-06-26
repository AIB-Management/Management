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

/*Data for the table `t_account` */

/*Data for the table `t_authorization` */

/*Data for the table `t_character` */

insert  into `t_character`(`id`,`role`,`explanation`) values (1,'admin','管理员'),(2,'leader','领导'),(3,'teacher','教师'),(4,'reviewing','待审核用户');

/*Data for the table `t_department` */

/*Data for the table `t_file` */

/*Data for the table `t_file_item` */

/*Data for the table `t_navigation` */

/*Data for the table `t_permission` */

insert  into `t_permission`(`id`,`role`,`permission`) values (16,'admin','admin:query'),(17,'admin','department:query'),(18,'admin','accountType:query'),(19,'admin','accountType:update'),(20,'admin','department:add'),(21,'admin','department:delete'),(22,'admin','department:update'),(23,'admin','navigation:add'),(24,'admin','navigation:delete'),(25,'admin','navigation:update'),(26,'leader','leader:query'),(27,'leader','leaderDep:update'),(28,'leader','page:query'),(29,'leader','file:query'),(30,'teacher','runas:query'),(31,'teacher','runas:add'),(32,'teacher','runas:delete'),(33,'teacher','page:query'),(34,'teacher','file:query'),(35,'teacher','file:delete'),(36,'teacher','file:update'),(37,'reviewing','page:query'),(38,'reviewing','file:query'),(39,'leader','depAndPro:query'),(40,'teacher','file:add'),(41,'admin','depAndPro:query'),(42,'admin','file:query');

/*Data for the table `t_power` */

insert  into `t_power`(`id`,`permission`,`explanation`) values (6,'admin:query','访问管理员页面'),(7,'leader:query','领导选择系页面'),(8,'department:query','查找所有系'),(9,'accountType:query','查看各角色的账户'),(10,'accountType:update','改变用户的角色'),(11,'department:add','增加系别专业'),(12,'department:delete','删除系别专业'),(13,'department:update','修改系别专业'),(14,'navigation:add','增加导航'),(15,'navigation:delete','删除导航'),(16,'navigation:update','修改导航'),(17,'runas:query','查询授权信息'),(18,'runas:add','增加授权'),(19,'runas:delete','取消授权'),(20,'leaderDep:update','更改领导的系别'),(21,'page:query','访问主页'),(22,'file:query','找到文件夹和文件'),(23,'depAndPro:query','查找系和专业'),(24,'fileItem:query','查找文件条目'),(25,'file:delete','删除文件'),(26,'file:update','修改文件'),(27,'file:add','增加文件');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
