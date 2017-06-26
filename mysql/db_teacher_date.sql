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

insert  into `t_account`(`id`,`uid`,`username`,`password`,`name`,`mail`,`role`,`depUid`,`validataCode`,`outDate`) values (827,'a7d31ac6-2576-42f6-af9f-8306abd1e35b','guanliyuan','6a840ecd92279021f868d6dbf70921e1','管理员','184999894@qq.com','admin','b5b8f596-a51d-4823-b8ee-d43b21a2c744',NULL,NULL);

/*Data for the table `t_authorization` */

/*Data for the table `t_character` */

insert  into `t_character`(`id`,`role`,`explanation`) values (1,'admin','管理员'),(2,'leader','领导'),(3,'teacher','教师'),(4,'reviewing','待审核用户');

/*Data for the table `t_department` */

insert  into `t_department`(`id`,`content`,`parent`,`uid`) values (570,'商务系','0','55a1c0ef-392d-4092-9e14-1ef416d7b6f2'),(571,'电子商务','55a1c0ef-392d-4092-9e14-1ef416d7b6f2','de73e554-c602-4e49-859b-a82e693098cd'),(572,'国际商务','55a1c0ef-392d-4092-9e14-1ef416d7b6f2','8cbe52bd-bc68-4215-9250-0084a498a777'),(573,'市场营销','55a1c0ef-392d-4092-9e14-1ef416d7b6f2','5e908705-f0f9-42d1-b844-82288fdf1e91'),(574,'旅游管理','55a1c0ef-392d-4092-9e14-1ef416d7b6f2','752da161-4b72-4d78-968a-cf456041bc3c'),(575,'酒店管理','55a1c0ef-392d-4092-9e14-1ef416d7b6f2','27babd91-9fc3-418c-9751-862451799cb5'),(576,'连锁经营管理','55a1c0ef-392d-4092-9e14-1ef416d7b6f2','82997cfc-40af-4107-8087-b2a255f111b1'),(577,'会展策划与管理','55a1c0ef-392d-4092-9e14-1ef416d7b6f2','f7a43929-395a-4abb-8dfd-29d80d5c44de'),(578,'工商企业管理','55a1c0ef-392d-4092-9e14-1ef416d7b6f2','36b7339e-5eae-4cc4-bd80-968baceb7a5a'),(579,'管理系','0','d283268a-36b3-4ba0-bebc-bb58e742aa3e'),(580,'物业管理','d283268a-36b3-4ba0-bebc-bb58e742aa3e','496d02e8-9c82-40c5-be82-724cbe307d48'),(581,'文秘专业','d283268a-36b3-4ba0-bebc-bb58e742aa3e','c6ab7769-e4fc-4302-b03b-c91306057557'),(582,'法律文秘','d283268a-36b3-4ba0-bebc-bb58e742aa3e','143b591b-3c9e-4b56-9339-f40851926d70'),(583,'物流管理','d283268a-36b3-4ba0-bebc-bb58e742aa3e','ef586a93-12c8-4531-be35-9660617de3cf'),(584,'社会工作','d283268a-36b3-4ba0-bebc-bb58e742aa3e','8373529f-3d49-45e4-b688-ddc6f53b2c1f'),(585,'房地产经营与估计','d283268a-36b3-4ba0-bebc-bb58e742aa3e','4c1e8c7b-cdfd-4db9-99d8-833c9aa8314b'),(586,'热作系','0','27627c7c-79c5-4126-8bd2-2ebd98175e39'),(587,'作物生产技术专业','27627c7c-79c5-4126-8bd2-2ebd98175e39','2db135b7-19a5-4e6c-8132-4a041a8faef4'),(588,'园林技术专业','27627c7c-79c5-4126-8bd2-2ebd98175e39','46a87201-3b76-49b6-9b71-ed1fa44f5dea'),(589,'园艺技术专业','27627c7c-79c5-4126-8bd2-2ebd98175e39','0967ca59-f5d9-418f-b563-98d062e2c69d'),(590,'畜牧兽医专业','27627c7c-79c5-4126-8bd2-2ebd98175e39','24510797-2506-4d07-a110-6e00c8eccbc5'),(591,'农产品质量检测专业','27627c7c-79c5-4126-8bd2-2ebd98175e39','64d282d5-5ac2-49df-8f37-ad879717b560'),(592,'食品加工技术专业','27627c7c-79c5-4126-8bd2-2ebd98175e39','9d30bdf3-4a0d-4d89-bf82-96ab8d218914'),(593,'食品营养与检测专业','27627c7c-79c5-4126-8bd2-2ebd98175e39','31e38cbd-e774-4875-a6a9-c97edaa5cd39'),(594,'食品生物技术专业','27627c7c-79c5-4126-8bd2-2ebd98175e39','9d3e3a59-309a-4f73-b0e4-9f5348c626de'),(595,'财经系','0','cccc15ae-d64c-470f-8e87-ce98ccb69943'),(596,'会计电算化专业','cccc15ae-d64c-470f-8e87-ce98ccb69943','0beb9d0b-b342-4d47-9fb2-0bd6a3a273ed'),(597,'会计与审计专业','cccc15ae-d64c-470f-8e87-ce98ccb69943','3ab61129-fb8d-480c-a6af-ed53e777a318'),(598,'财务管理专业','cccc15ae-d64c-470f-8e87-ce98ccb69943','194182b9-f2f2-4b9d-b730-50a2930b0c24'),(599,'会计（涉外方向、税务方向）专业','cccc15ae-d64c-470f-8e87-ce98ccb69943','37d7151e-930f-447f-b810-1e74461c1a2c'),(600,'资产评估与管理专业','cccc15ae-d64c-470f-8e87-ce98ccb69943','ba30fe55-8d45-4f70-a73b-74cac8cb226d'),(601,'投资与理财专业','cccc15ae-d64c-470f-8e87-ce98ccb69943','cd76b2ea-25a6-49b9-bb83-0192c861edd9'),(602,'国际金融专业','cccc15ae-d64c-470f-8e87-ce98ccb69943','6308cc8e-9bcf-421b-95ae-def21910ba42'),(603,'证券与期货专业','cccc15ae-d64c-470f-8e87-ce98ccb69943','8166ba76-567d-4040-9905-70b16e2195cd'),(604,'外语系','0','3d548a8f-34d0-45e2-9746-0b20c84cd174'),(605,'商务英语','3d548a8f-34d0-45e2-9746-0b20c84cd174','a64a9ef0-0a5c-4094-b98c-0ca85f1b66b4'),(606,'应用英语','3d548a8f-34d0-45e2-9746-0b20c84cd174','95fd1f57-6d15-4600-864f-fbe1cf53b6e1'),(607,'旅游英语','3d548a8f-34d0-45e2-9746-0b20c84cd174','363233d3-cb15-4964-b9ea-e321dad2143c'),(608,'艺术系','0','a386ae5c-ba72-480c-a4d7-f35ed85bdaee'),(609,'产品艺术设计专业','a386ae5c-ba72-480c-a4d7-f35ed85bdaee','9c746978-8beb-43db-b05f-99f21acba4cb'),(610,'环境艺术设计专业','a386ae5c-ba72-480c-a4d7-f35ed85bdaee','9e8eae39-c228-42ff-8d3c-bf3e66f3c2a3'),(611,'数字媒体艺术设计专业','a386ae5c-ba72-480c-a4d7-f35ed85bdaee','d56e1b04-6afd-49c0-a6ff-b14be19227d9'),(612,'广告设计与制作专业','a386ae5c-ba72-480c-a4d7-f35ed85bdaee','33217c0b-15bd-4080-b500-2305b12e01f2'),(613,'公共文化服务与管理专业','a386ae5c-ba72-480c-a4d7-f35ed85bdaee','ea7f9329-05ec-4d21-8b8d-8773b18ff423'),(614,'艺术设计专业（视觉传达设计方向、展示设计方向)','a386ae5c-ba72-480c-a4d7-f35ed85bdaee','b2e52786-5aa9-4007-a770-21ca5946769c'),(615,'计算机系','0','edda68d5-e77d-41bc-98b8-207172b58ac7'),(616,'动漫设计与制作专业','edda68d5-e77d-41bc-98b8-207172b58ac7','b5b8f596-a51d-4823-b8ee-d43b21a2c744'),(617,'计算机网络技术专业','edda68d5-e77d-41bc-98b8-207172b58ac7','f5112e9c-7d48-4e56-8bd4-f16d6a07b0c8'),(618,'计算机信息管理专业','edda68d5-e77d-41bc-98b8-207172b58ac7','450be1eb-5b6d-4ec8-ba59-649a76439846'),(619,'计算机应用技术专业','edda68d5-e77d-41bc-98b8-207172b58ac7','9841b63b-e420-4166-ad35-71b8f3119999'),(620,'计算机多媒体技术专业','edda68d5-e77d-41bc-98b8-207172b58ac7','aa30585b-0c91-41c0-a86a-ec2d09721660'),(621,'移动互联网应用技术专业','edda68d5-e77d-41bc-98b8-207172b58ac7','2a548063-a846-4921-b827-8a3eeb93dfb5'),(622,'机电系','0','23ce0a3b-87ab-40fd-9f73-9b7c1fc7e2e1'),(623,'电子信息工程技术','23ce0a3b-87ab-40fd-9f73-9b7c1fc7e2e1','34f1aea9-88b6-4bdc-a427-19c443e9a9dc'),(624,'通信技术','23ce0a3b-87ab-40fd-9f73-9b7c1fc7e2e1','770708f2-7746-4766-b9fb-e0631f01c49b'),(625,'电气自动化技术','23ce0a3b-87ab-40fd-9f73-9b7c1fc7e2e1','8b23ccbf-1a74-45fb-b201-e19c3ab53fc6'),(626,'应用电子技术','23ce0a3b-87ab-40fd-9f73-9b7c1fc7e2e1','ed0a7a23-a421-4f3f-bd5a-39b6de2ad98f'),(627,'汽车电子技术','23ce0a3b-87ab-40fd-9f73-9b7c1fc7e2e1','53666abe-cf7b-44f0-a36a-bf2ad3745271'),(628,'汽车技术服务与营销','23ce0a3b-87ab-40fd-9f73-9b7c1fc7e2e1','c19781d2-14f3-425f-95c3-325303b50e0f'),(629,'汽车检测与维修技术','23ce0a3b-87ab-40fd-9f73-9b7c1fc7e2e1','b254a6ce-8d18-460b-9c22-461cd20cebf5'),(630,'物联网应用技术','23ce0a3b-87ab-40fd-9f73-9b7c1fc7e2e1','f23adf39-8585-4e02-af12-1c12f2ba4d8f'),(631,'国际交流学院','0','a9bbd10a-0920-4438-8f16-daefa4960c62'),(632,'市场营销专业(BTEC商业方向)','a9bbd10a-0920-4438-8f16-daefa4960c62','eb807015-5c76-44dc-8821-95c6c175e7d4'),(633,'市场营销专业(BTEC会计方向)','a9bbd10a-0920-4438-8f16-daefa4960c62','93ad6aeb-423d-4de0-8e8f-5d2f93889873'),(634,'市场营销专业（BTEC人力资源管理方向）','a9bbd10a-0920-4438-8f16-daefa4960c62','a18e6ce6-abda-4a40-9d8c-f8de96b6ca1a'),(635,'市场营销专业（BTEC工商管理方向）','a9bbd10a-0920-4438-8f16-daefa4960c62','7d085b88-8cfa-46f9-9b48-f2910ea99b16'),(636,'市场营销专业（BTEC酒店管理方向）','a9bbd10a-0920-4438-8f16-daefa4960c62','ceffb6e7-010c-4654-aafb-6fa21fbc2866'),(637,'计算机应用技术专业（BTEC商务信息技术方向）','a9bbd10a-0920-4438-8f16-daefa4960c62','dbcca06a-addb-4368-ae4a-66c0da1aa565');

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
