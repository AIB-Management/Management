/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50718
Source Host           : localhost:3306
Source Database       : db_test

Target Server Type    : MYSQL
Target Server Version : 50718
File Encoding         : 65001

Date: 2017-05-08 14:32:11
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_account
-- ----------------------------
DROP TABLE IF EXISTS `t_account`;
CREATE TABLE `t_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `username` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '账号',
  `password` varchar(40) COLLATE utf8_bin NOT NULL COMMENT '密码',
  `name` varchar(10) COLLATE utf8_bin NOT NULL COMMENT '姓名',
  `mail` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '邮件',
  `dp_id` int(11) NOT NULL DEFAULT '1' COMMENT '系别专业id',
  `character` varchar(20) COLLATE utf8_bin DEFAULT 'reviewing' COMMENT '角色',
  `validataCode` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '找回密码的UUID',
  `outDate` datetime DEFAULT NULL COMMENT '找回密码的过期时间',
  PRIMARY KEY (`id`,`username`),
  KEY `FK_t_account_dp_id` (`dp_id`),
  KEY `account` (`username`),
  KEY `account_2` (`username`),
  KEY `FK_t_account_character` (`character`),
  CONSTRAINT `FK_t_account_character` FOREIGN KEY (`character`) REFERENCES `t_character` (`character`),
  CONSTRAINT `FK_t_account_dp_id` FOREIGN KEY (`dp_id`) REFERENCES `t_profession` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='账号表';

-- ----------------------------
-- Records of t_account
-- ----------------------------
INSERT INTO `t_account` VALUES ('1', 'account', 'pass', 'Admin', 'K@gdaib.com', '1', 'admin', null, null);
INSERT INTO `t_account` VALUES ('2', 'znho', '49e002d5a8ea93420d30a2978b2c565e', 'znho', 'wsxzh22@163.com', '1', 'admin', null, null);

-- ----------------------------
-- Table structure for t_character
-- ----------------------------
DROP TABLE IF EXISTS `t_character`;
CREATE TABLE `t_character` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `character` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '角色',
  `explanation` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '解释',
  PRIMARY KEY (`id`,`character`),
  KEY `character` (`character`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='角色表';

-- ----------------------------
-- Records of t_character
-- ----------------------------
INSERT INTO `t_character` VALUES ('1', 'admin', '管理员');
INSERT INTO `t_character` VALUES ('2', 'leader', '领导');
INSERT INTO `t_character` VALUES ('3', 'teacher', '教师');
INSERT INTO `t_character` VALUES ('4', 'reviewing', '待审核用户');

-- ----------------------------
-- Table structure for t_department
-- ----------------------------
DROP TABLE IF EXISTS `t_department`;
CREATE TABLE `t_department` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `department` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '系别',
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDXU_t_department_department` (`department`)
) ENGINE=InnoDB AUTO_INCREMENT=401 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='系别';

-- ----------------------------
-- Records of t_department
-- ----------------------------
INSERT INTO `t_department` VALUES ('1', 'ALL');
INSERT INTO `t_department` VALUES ('300', '商英系');
INSERT INTO `t_department` VALUES ('400', '机电系');
INSERT INTO `t_department` VALUES ('200', '管理系');
INSERT INTO `t_department` VALUES ('100', '计算机系');

-- ----------------------------
-- Table structure for t_file_info
-- ----------------------------
DROP TABLE IF EXISTS `t_file_info`;
CREATE TABLE `t_file_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `account` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '账号',
  `navigation_id` int(11) NOT NULL COMMENT '系别模块id',
  `up_time` datetime NOT NULL COMMENT '时间',
  `title` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '文本标题',
  `url` varchar(200) COLLATE utf8_bin NOT NULL COMMENT '操作标识',
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDXU_t_file_info_action_code` (`url`),
  KEY `FK_t_file_info_dn_id` (`navigation_id`),
  KEY `FK_t_file_info_account` (`account`),
  CONSTRAINT `FK_t_file_info_account` FOREIGN KEY (`account`) REFERENCES `t_account` (`username`),
  CONSTRAINT `FK_t_file_info_navigation` FOREIGN KEY (`navigation_id`) REFERENCES `t_navigation` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='数据表9';

-- ----------------------------
-- Records of t_file_info
-- ----------------------------

-- ----------------------------
-- Table structure for t_mapping_com
-- ----------------------------
DROP TABLE IF EXISTS `t_mapping_com`;
CREATE TABLE `t_mapping_com` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `om_id` int(11) NOT NULL COMMENT '名称',
  `character` varchar(20) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_t_mapping_COM_om_id` (`om_id`),
  KEY `FK_t_mapping_COM_character` (`character`),
  CONSTRAINT `FK_t_mapping_COM_character` FOREIGN KEY (`character`) REFERENCES `t_character` (`character`),
  CONSTRAINT `FK_t_mapping_COM_om_id` FOREIGN KEY (`om_id`) REFERENCES `t_mapping_om` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='数据表18';

-- ----------------------------
-- Records of t_mapping_com
-- ----------------------------
INSERT INTO `t_mapping_com` VALUES ('1', '6', 'admin');
INSERT INTO `t_mapping_com` VALUES ('2', '7', 'admin');
INSERT INTO `t_mapping_com` VALUES ('3', '8', 'admin');
INSERT INTO `t_mapping_com` VALUES ('4', '9', 'admin');
INSERT INTO `t_mapping_com` VALUES ('5', '10', 'admin');
INSERT INTO `t_mapping_com` VALUES ('6', '11', 'admin');
INSERT INTO `t_mapping_com` VALUES ('7', '12', 'admin');
INSERT INTO `t_mapping_com` VALUES ('8', '13', 'admin');
INSERT INTO `t_mapping_com` VALUES ('9', '4', 'leader');
INSERT INTO `t_mapping_com` VALUES ('10', '5', 'leader');
INSERT INTO `t_mapping_com` VALUES ('11', '1', 'teacher');
INSERT INTO `t_mapping_com` VALUES ('12', '2', 'teacher');
INSERT INTO `t_mapping_com` VALUES ('13', '3', 'teacher');
INSERT INTO `t_mapping_com` VALUES ('14', '4', 'teacher');
INSERT INTO `t_mapping_com` VALUES ('15', '5', 'teacher');
INSERT INTO `t_mapping_com` VALUES ('16', '4', 'reviewing');
INSERT INTO `t_mapping_com` VALUES ('17', '2', 'admin');

-- ----------------------------
-- Table structure for t_mapping_om
-- ----------------------------
DROP TABLE IF EXISTS `t_mapping_om`;
CREATE TABLE `t_mapping_om` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `module` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '模块',
  `operate` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '权限',
  PRIMARY KEY (`id`),
  KEY `FK_t_mapping_OM_module` (`module`),
  KEY `FK_t_mapping_OM_operate` (`operate`),
  CONSTRAINT `FK_t_mapping_OM_module` FOREIGN KEY (`module`) REFERENCES `t_module` (`module`),
  CONSTRAINT `FK_t_mapping_OM_operate` FOREIGN KEY (`operate`) REFERENCES `t_operate` (`operate`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='模块权限表';

-- ----------------------------
-- Records of t_mapping_om
-- ----------------------------
INSERT INTO `t_mapping_om` VALUES ('1', 'content', 'add');
INSERT INTO `t_mapping_om` VALUES ('2', 'content', 'delete');
INSERT INTO `t_mapping_om` VALUES ('3', 'content', 'update');
INSERT INTO `t_mapping_om` VALUES ('4', 'content', 'access');
INSERT INTO `t_mapping_om` VALUES ('5', 'content', 'down');
INSERT INTO `t_mapping_om` VALUES ('6', 'account', 'add');
INSERT INTO `t_mapping_om` VALUES ('7', 'account', 'delete');
INSERT INTO `t_mapping_om` VALUES ('8', 'account', 'update');
INSERT INTO `t_mapping_om` VALUES ('9', 'account', 'access');
INSERT INTO `t_mapping_om` VALUES ('10', 'navigation', 'delete');
INSERT INTO `t_mapping_om` VALUES ('11', 'navigation', 'access');
INSERT INTO `t_mapping_om` VALUES ('12', 'navigation', 'update');
INSERT INTO `t_mapping_om` VALUES ('13', 'navigation', 'add');

-- ----------------------------
-- Table structure for t_mapping_ugom
-- ----------------------------
DROP TABLE IF EXISTS `t_mapping_ugom`;
CREATE TABLE `t_mapping_ugom` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `account` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '授权账号',
  `be_acco` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '被授权账号',
  `om_id` int(11) NOT NULL COMMENT '模块权限id',
  PRIMARY KEY (`id`),
  KEY `FK_t_mapping_UGOM_om_id` (`om_id`),
  KEY `FK_t_mapping_UGOM_account` (`account`),
  KEY `FK_t_mapping_UGOM_be_acco` (`be_acco`),
  CONSTRAINT `FK_t_mapping_UGOM_account` FOREIGN KEY (`account`) REFERENCES `t_account` (`username`),
  CONSTRAINT `FK_t_mapping_UGOM_be_acco` FOREIGN KEY (`be_acco`) REFERENCES `t_account` (`username`),
  CONSTRAINT `FK_t_mapping_UGOM_om_id` FOREIGN KEY (`om_id`) REFERENCES `t_mapping_om` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='上传权限组';

-- ----------------------------
-- Records of t_mapping_ugom
-- ----------------------------

-- ----------------------------
-- Table structure for t_module
-- ----------------------------
DROP TABLE IF EXISTS `t_module`;
CREATE TABLE `t_module` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `module` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `explanation` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '解释',
  PRIMARY KEY (`id`,`module`),
  KEY `module` (`module`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='模块表';

-- ----------------------------
-- Records of t_module
-- ----------------------------
INSERT INTO `t_module` VALUES ('1', 'content', '内容');
INSERT INTO `t_module` VALUES ('2', 'account', '账号');
INSERT INTO `t_module` VALUES ('3', 'navigation', '导航');

-- ----------------------------
-- Table structure for t_navigation
-- ----------------------------
DROP TABLE IF EXISTS `t_navigation`;
CREATE TABLE `t_navigation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `department_id` int(11) NOT NULL,
  `parent` int(11) unsigned zerofill NOT NULL,
  `title` varchar(30) COLLATE utf8_bin NOT NULL,
  `url` varchar(200) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_t_nacigation_department` (`department_id`),
  CONSTRAINT `FK_t_nacigation_department` FOREIGN KEY (`department_id`) REFERENCES `t_department` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of t_navigation
-- ----------------------------

-- ----------------------------
-- Table structure for t_operate
-- ----------------------------
DROP TABLE IF EXISTS `t_operate`;
CREATE TABLE `t_operate` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `operate` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '操作',
  `explanation` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '解释',
  PRIMARY KEY (`id`,`operate`),
  KEY `operate` (`operate`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='操作表';

-- ----------------------------
-- Records of t_operate
-- ----------------------------
INSERT INTO `t_operate` VALUES ('1', 'add', '增加');
INSERT INTO `t_operate` VALUES ('2', 'delete', '删除');
INSERT INTO `t_operate` VALUES ('3', 'access', '查阅');
INSERT INTO `t_operate` VALUES ('4', 'update', '修改更新');
INSERT INTO `t_operate` VALUES ('5', 'down', '下载');

-- ----------------------------
-- Table structure for t_profession
-- ----------------------------
DROP TABLE IF EXISTS `t_profession`;
CREATE TABLE `t_profession` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `department_id` int(11) DEFAULT NULL COMMENT '系别id',
  `profession` varchar(40) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_t_mapping_DP_departmen_id` (`department_id`),
  CONSTRAINT `FK_t_mapping_DP_departmen_id` FOREIGN KEY (`department_id`) REFERENCES `t_department` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=302 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='系别导航表';

-- ----------------------------
-- Records of t_profession
-- ----------------------------
INSERT INTO `t_profession` VALUES ('1', '1', 'all');
INSERT INTO `t_profession` VALUES ('100', '100', '软件技术');
INSERT INTO `t_profession` VALUES ('101', '100', '移动应用');
INSERT INTO `t_profession` VALUES ('102', '100', '信管');
INSERT INTO `t_profession` VALUES ('200', '200', '物流');
INSERT INTO `t_profession` VALUES ('300', '300', '旅游英语');
INSERT INTO `t_profession` VALUES ('301', '300', '商务英语');

-- ----------------------------
-- View structure for v_role_permissions
-- ----------------------------
DROP VIEW IF EXISTS `v_role_permissions`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_role_permissions` AS select `t_mapping_com`.`id` AS `id`,`t_character`.`character` AS `character`,`t_module`.`module` AS `module`,`t_operate`.`operate` AS `operate` from ((((`t_character` join `t_mapping_com` on((`t_mapping_com`.`character` = `t_character`.`character`))) join `t_mapping_om` on((`t_mapping_com`.`om_id` = `t_mapping_om`.`id`))) join `t_module` on((`t_mapping_om`.`module` = `t_module`.`module`))) join `t_operate` on((`t_mapping_om`.`operate` = `t_operate`.`operate`))) order by `t_mapping_com`.`id` ;
