/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50718
Source Host           : localhost:3306
Source Database       : db_teacher

Target Server Type    : MYSQL
Target Server Version : 50718
File Encoding         : 65001

Date: 2017-05-24 16:03:57
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
  `profession_id` int(11) NOT NULL DEFAULT '1' COMMENT '系别专业id',
  `role` varchar(20) COLLATE utf8_bin DEFAULT 'reviewing' COMMENT '角色',
  `validataCode` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '找回密码的UUID',
  `outDate` datetime DEFAULT NULL COMMENT '找回密码的过期时间',
  PRIMARY KEY (`id`,`username`),
  KEY `FK_t_account_dp_id` (`profession_id`),
  KEY `account` (`username`),
  KEY `account_2` (`username`),
  KEY `FK_t_account_character` (`role`),
  CONSTRAINT `FK_t_account_character` FOREIGN KEY (`role`) REFERENCES `t_character` (`role`),
  CONSTRAINT `FK_t_account_dp_id` FOREIGN KEY (`profession_id`) REFERENCES `t_profession` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=206 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='账号表';

-- ----------------------------
-- Records of t_account
-- ----------------------------
INSERT INTO `t_account` VALUES ('1', 'accounttt', 'pass', 'Admin', '184999894@qq.com', '1', 'admin', 'fa5956b1-eebe-41c5-a42b-ee39906e4660', '2017-05-16 13:24:33');
INSERT INTO `t_account` VALUES ('2', 'znhoznho', 'e0bbb65e628dd40297ee1ef12198427c', 'znho', 'wsxzh22@163.com', '1', 'admin', 'b0d3e29d-d423-4f8f-adbe-e1ee56bb482a', '2017-05-14 21:50:31');
INSERT INTO `t_account` VALUES ('3', 'lalalala', '4a2a2fa3f04dd5f37f2684e37ddf5da3', 'eqweqwe', 'weqw@163.com', '300', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('4', 'hahahaha', '3506bdfb51bc84054c742887b86d82f8', '轻松的企鹅', 'wweq@14.com', '300', 'teacher', null, null);
INSERT INTO `t_account` VALUES ('6', 'fb270fb270', '61cac7309ebb6bcd8ef9336a2d8f7be1', '机器人fb270', 'fb270@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('7', '9b30d9b30d', '46b8906d38eac3462e74cb864fcefea6', '机器人9b30d', '9b30d@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('8', '81b9081b90', 'a1bbc1c1ecd5db0aaf70803b3b8b304b', '机器人81b90', '81b90@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('9', '5edbf5edbf', '6e1b73c7f7a2d0732b8ea9206f925295', '机器人5edbf', '5edbf@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('10', 'ca13dca13d', 'a6157419779120ff80678dfda474bba3', '机器人ca13d', 'ca13d@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('11', 'b7a41b7a41', 'af7003c2ceb724b0b097bf921a0c7f8c', '机器人b7a41', 'b7a41@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('12', 'e051ee051e', '29faf3a36db028e76662ba404ac6977d', '机器人e051e', 'e051e@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('13', '5a44f5a44f', '8467f316933d56915600fb667546d1f1', '机器人5a44f', '5a44f@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('14', '927d5927d5', '2b74b0624247bfc8be31791efde72b0b', '机器人927d5', '927d5@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('15', 'f64def64de', '897d8ff4884bf12bbbe0e0a04ef3670b', '机器人f64de', 'f64de@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('16', '1438d1438d', '03ac9db2cdf795c19e5834e3755a88dc', '机器人1438d', '1438d@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('17', '0f70e0f70e', '62b5ae9609e08f879ef08896f3193cf5', '机器人0f70e', '0f70e@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('18', '91b3b91b3b', '6744edf26a821c91b95c5980ab3d352b', '机器人91b3b', '91b3b@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('19', 'e0cb2e0cb2', 'cf590f92e4f8085a5ff20d7a81c3c4a7', '机器人e0cb2', 'e0cb2@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('20', '520b3520b3', '5284a40cc5844e76f2bf7334478ac1ad', '机器人520b3', '520b3@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('22', '6ca066ca06', 'd9208d6e4717847b6f68f4718e54e29f', '机器人6ca06', '6ca06@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('23', 'e1723e1723', '8e8517cbbf9f61a7c8fed38ae2b94011', '机器人e1723', 'e1723@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('24', '096da096da', '7d07faff4bbeeea513158826e7f72934', '机器人096da', '096da@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('25', '79c3279c32', 'c9317f36b2b6018d7d63551fa21b0522', '机器人79c32', '79c32@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('26', '2cd6e2cd6e', '3a9584080a551be0e3f0b9423b85de6d', '机器人2cd6e', '2cd6e@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('27', '8c2ee8c2ee', 'd89e3a3611e59609a94d76fc13e2b050', '机器人8c2ee', '8c2ee@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('28', 'bf76dbf76d', 'a45bc829b75cfd4a846772e535b243f2', '机器人bf76d', 'bf76d@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('29', 'c47e0c47e0', 'da2a48d55dda6b222c22d73645dbfb90', '机器人c47e0', 'c47e0@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('30', '406ee406ee', '0ba82dbaa6ca2266f4bcad4eed422040', '机器人406ee', '406ee@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('31', 'f08c4f08c4', '841b3234849398a437e4cf431d63f8d3', '机器人f08c4', 'f08c4@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('32', 'a6555a6555', 'aba701579b947f0b57ad89af6aadc4f6', '机器人a6555', 'a6555@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('33', '1813018130', '9cb31bd75fa035faf99e4025b4f06c65', '机器人18130', '18130@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('34', '039c0039c0', 'f672cc9315017a4952a19fcccd0fef7c', '机器人039c0', '039c0@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('35', '682c0682c0', 'f0f282fe2ca85f5e512055ffd817a9dd', '机器人682c0', '682c0@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('36', '9cd899cd89', '3b54d7a9a28fa555e05056a1ca3de298', '机器人9cd89', '9cd89@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('37', '1d2731d273', '129c6a0d459139c6a309a9c070fd711a', '机器人1d273', '1d273@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('38', '0f24f0f24f', 'e93065300e3fe0c8c20a425c62f96213', '机器人0f24f', '0f24f@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('39', '45b9345b93', '13b7ebf69c03b287a6a4498780deada3', '机器人45b93', '45b93@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('40', '6f7af6f7af', '55d81fdccb365bcf5c7c0fc9547833a8', '机器人6f7af', '6f7af@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('41', 'ea812ea812', '7764329a99b3d8bab8806dd322bbd94f', '机器人ea812', 'ea812@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('42', '32fd732fd7', 'b88bcd496f2720c1a24c90867740bc3a', '机器人32fd7', '32fd7@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('43', '1eff21eff2', 'a3113880c02afe5834778864e26effb6', '机器人1eff2', '1eff2@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('44', '160c2160c2', '918e006df7d136c5dbb126f8211577c3', '机器人160c2', '160c2@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('45', 'aaec2aaec2', '20675089626d9d4294eedfb0b84aa28a', '机器人aaec2', 'aaec2@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('46', '94a0594a05', 'd4e7378a15c1a0467b35ba902616b2a6', '机器人94a05', '94a05@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('47', 'fb213fb213', '5f77a74183115771db46fbc274852b1b', '机器人fb213', 'fb213@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('48', '29c0a29c0a', '1fd7bb936894b84cb3e656d60d339ff5', '机器人29c0a', '29c0a@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('49', '42f5342f53', '9710c41a8ec9394b749fed439f5e189e', '机器人42f53', '42f53@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('50', '43b8943b89', '40cdb36227d230369b1aae85d6cdab1c', '机器人43b89', '43b89@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('51', '17e9017e90', '01a896a0dac5d97e8faf8299df002225', '机器人17e90', '17e90@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('52', '85ba185ba1', '60084c477252dfa273ae889e076b9e4a', '机器人85ba1', '85ba1@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('53', 'e8512e8512', '5532d22500e422d9ce76693b4527dd62', '机器人e8512', 'e8512@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('54', '5d7cb5d7cb', '4480e37392fa3b23cfa51d255a5a6ea4', '机器人5d7cb', '5d7cb@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('55', '7a93d7a93d', '057cfbe0a302f909b19d9c811ef7a8af', '机器人7a93d', '7a93d@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('56', '53c9253c92', 'f7c8a93d2b551f17f689aa7485a290a3', '机器人53c92', '53c92@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('57', '9b5cf9b5cf', '8ed1c76b1acb896deccbbd4a17c5b6bb', '机器人9b5cf', '9b5cf@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('58', '3089830898', '650c622eb97dbe86db12ec224c53da69', '机器人30898', '30898@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('59', '4594b4594b', '71c9d5600ca3fc116e9dccddab15cd17', '机器人4594b', '4594b@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('60', '2a8a62a8a6', '143db51cbfb8b04bd2d45457d9e6f5a9', '机器人2a8a6', '2a8a6@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('61', '879d3879d3', '1bbbe7e68ee6234867222a6a80ec10af', '机器人879d3', '879d3@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('62', 'd4ee7d4ee7', '456f9b3b8070f2c1725b9b093571ad5b', '机器人d4ee7', 'd4ee7@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('63', '7e2d67e2d6', 'd911bdac998e73d35b072c8d04a238c5', '机器人7e2d6', '7e2d6@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('64', 'e5b29e5b29', '8c807415ea332755f50ccde7ade2dc83', '机器人e5b29', 'e5b29@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('65', 'df2cedf2ce', 'eca3b7af895b923d098aa25923ef1dda', '机器人df2ce', 'df2ce@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('66', '0560305603', '0f52e66e55e5fe575d74947317b57411', '机器人05603', '05603@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('67', '7c56d7c56d', '58c1faf61f9b86df341df6a33a9d40a6', '机器人7c56d', '7c56d@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('68', '2cb932cb93', '1aa8b1159e8e49d42aaa40d42233d648', '机器人2cb93', '2cb93@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('69', '50fd550fd5', '0c5ff658ecf09a021819f9593fc58ebb', '机器人50fd5', '50fd5@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('70', '2041320413', '0d90a70210ae7339e14bc4426fbc5b20', '机器人20413', '20413@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('71', '6cf7d6cf7d', '8026174ebe0856f1db6b3c70b5d02506', '机器人6cf7d', '6cf7d@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('72', '7392873928', '94e18177f306ddb9d4e5e442b60e0bd9', '机器人73928', '73928@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('73', '1027010270', '335a4a8000d858a959b50efc03e993d5', '机器人10270', '10270@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('74', '8798287982', 'fe8203ec0f9e8ff6c01fb4e027958e59', '机器人87982', '87982@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('75', 'b0c5bb0c5b', '2331ecc9dbf14f7c0e73857e8d2e62b5', '机器人b0c5b', 'b0c5b@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('76', '3893538935', '46e45a68af7216d34aed7b0cdc43f793', '机器人38935', '38935@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('77', 'b4a47b4a47', 'afa3b31024f783ba47f236b5e765ea8a', '机器人b4a47', 'b4a47@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('78', '7119f7119f', '629b52b215c4adef2a93b0ae4612a3eb', '机器人7119f', '7119f@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('79', '04bc104bc1', 'd668952f4e4f82dc38afc8e8b55b3fe7', '机器人04bc1', '04bc1@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('80', '40b2b40b2b', '031b2829697a266da0c3918ab7c32557', '机器人40b2b', '40b2b@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('81', '5939f5939f', 'b4495d14425f5adafd2b9135e2a44e35', '机器人5939f', '5939f@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('82', 'bb0afbb0af', '436fcab14a8797cbbeae91e008de9883', '机器人bb0af', 'bb0af@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('83', '4f8af4f8af', 'd0eee770a1415ddb1ccba64a73c183cf', '机器人4f8af', '4f8af@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('84', '89fd589fd5', 'f0079567433fffea63e8b8c8669426a3', '机器人89fd5', '89fd5@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('85', '3c5d63c5d6', 'e29948bbcadf1b56a1335f515d0d5ef5', '机器人3c5d6', '3c5d6@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('86', '9769a9769a', '7569759775a703bc2a3b27514ec5036a', '机器人9769a', '9769a@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('87', 'abcdbabcdb', '847dfdbb2d61d03597496a3d55318b40', '机器人abcdb', 'abcdb@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('88', '498ea498ea', '9622468be879a95eb170ecadbeac34bc', '机器人498ea', '498ea@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('89', '570d5570d5', 'e5598b092a162c053a5087889011022f', '机器人570d5', '570d5@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('90', '9204692046', '2b165ba3f7eec163bceda998e5d8c580', '机器人92046', '92046@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('91', '7903879038', 'cd86ac11896a28d2b9c71b06aae0cc95', '机器人79038', '79038@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('92', 'cdeb0cdeb0', '2fd7eb611e6d2f94f3d586a026c14e25', '机器人cdeb0', 'cdeb0@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('93', 'fbc32fbc32', '7dfad188f0008e82f7e6e2de72522cb4', '机器人fbc32', 'fbc32@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('94', '4842548425', '87a8feef93625db3351e49d5b3843533', '机器人48425', '48425@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('95', 'f4091f4091', '9929491cd66147658b040f99d61a6076', '机器人f4091', 'f4091@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('96', '8359483594', '1ea2b43ee11a0b69d44fc20c443f3959', '机器人83594', '83594@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('97', '94ace94ace', '51111e819b31bc8e9988e77e2218db08', '机器人94ace', '94ace@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('98', '9d0339d033', '590e5260a1b68338ca63dde4aad3a874', '机器人9d033', '9d033@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('99', 'd9c0ed9c0e', '2d9600ecfdda9a30784b697609bdbd46', '机器人d9c0e', 'd9c0e@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('100', '45b7b45b7b', '97639d257f694adc65b3f3b7421315e5', '机器人45b7b', '45b7b@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('101', '3118b3118b', '10617a75cdd44d59ea0ae22fdd24be4b', '机器人3118b', '3118b@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('102', '4d1104d110', '3b272ee8446d1f917542ae1e648a7837', '机器人4d110', '4d110@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('103', '4d7514d751', 'cd5cad5d2e5de44d88f686a8b6f1522c', '机器人4d751', '4d751@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('104', '3067f3067f', '6b77b501f315a30be16264149cdfa555', '机器人3067f', '3067f@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('105', 'a8c22a8c22', 'cda209bedd8d17270c1b77760cff172c', '机器人a8c22', 'a8c22@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('106', '9f8169f816', '29b617936814d814e80858a6ccbd7603', '机器人9f816', '9f816@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('107', '15a8a15a8a', '05c4e9ad59a3db58998068587c68027b', '机器人15a8a', '15a8a@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('108', '1742e1742e', 'd163cea97fcbead05ceb6ac12feb75fd', '机器人1742e', '1742e@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('109', '6036860368', '6974df0456d6c5839f422d0abc4a0c68', '机器人60368', '60368@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('110', '76abe76abe', 'e2c551e34b8909bafee2cf2466efb64a', '机器人76abe', '76abe@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('111', 'e397ce397c', '8f5e4c683aa3627d2cd55db86e8041fc', '机器人e397c', 'e397c@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('112', '1d4fc1d4fc', '1e76f426db2624b165ab3572a891241d', '机器人1d4fc', '1d4fc@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('113', 'e38f2e38f2', '548a7b20a9c587ec5212cf73884d3bac', '机器人e38f2', 'e38f2@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('114', '477b3477b3', '2d1dc345e8ff9367a55a9ab1eb6669d0', '机器人477b3', '477b3@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('115', 'd4140d4140', 'abd9b601bc4432d5db2e708204ed88aa', '机器人d4140', 'd4140@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('116', 'f37d8f37d8', '499a8604d71c778f0c23810ee23f3b94', '机器人f37d8', 'f37d8@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('117', '9f3bc9f3bc', '2b37ad45ffdf2b4b190c23a45f70af9b', '机器人9f3bc', '9f3bc@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('118', '1b3b91b3b9', 'e615fcc0b7d391b2cd8a3cc4b19626b3', '机器人1b3b9', '1b3b9@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('119', '74d8574d85', '099618c51232082e8134908f0ab29039', '机器人74d85', '74d85@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('120', '9dd809dd80', '2a1128095f1ba8c8f9ad591547dbc13a', '机器人9dd80', '9dd80@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('121', '6f8aa6f8aa', 'cd660ed1d5987da5b8a5d545f1f8af87', '机器人6f8aa', '6f8aa@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('122', '3aea63aea6', 'a3cdda40d1d55397d9838eafea96b694', '机器人3aea6', '3aea6@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('123', '4ffc04ffc0', 'b38488432a21d729be44dd36b2c191fa', '机器人4ffc0', '4ffc0@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('124', '4529445294', '54ef3edeb02f8c7dd3307ac298640dd0', '机器人45294', '45294@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('125', '095e8095e8', 'd330d165a4f69c601bf79349ba4ec14c', '机器人095e8', '095e8@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('126', 'ee39dee39d', '489beccadcc35f2a92ebc3fe4a6b4114', '机器人ee39d', 'ee39d@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('127', '4a2a14a2a1', '88108e4e9eb629cca1584cdea84cfefc', '机器人4a2a1', '4a2a1@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('128', '7ccfd7ccfd', '038240f21e3ca162d5ff2a7d47978b9a', '机器人7ccfd', '7ccfd@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('129', 'b8630b8630', '96dd4e89a38319c2397711c314018c76', '机器人b8630', 'b8630@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('130', 'ec8e0ec8e0', 'd608704bfec721f927fe4ec5bb40bfdd', '机器人ec8e0', 'ec8e0@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('131', 'dce14dce14', '91f8c51d0a2af9a94167cb0d286e4795', '机器人dce14', 'dce14@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('132', 'ce653ce653', '17186233e65afda5df2f7d4668a3da22', '机器人ce653', 'ce653@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('133', 'eb546eb546', '3a2c8c86de32e3a3689f6e786a9acb9b', '机器人eb546', 'eb546@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('134', '6699f6699f', '4fc5df1cc29d118fcfb1feb370af37f5', '机器人6699f', '6699f@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('135', 'deb91deb91', '9dfcca623eaed5774a87cf5171bc4c8a', '机器人deb91', 'deb91@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('136', 'db4b6db4b6', '19500c963e8d4968e0111216bb99fc3f', '机器人db4b6', 'db4b6@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('137', 'd5379d5379', '8ec9040a26538be01437aa62ee3a1d45', '机器人d5379', 'd5379@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('138', 'd3565d3565', '9892405696d5e8696d2c190462176858', '机器人d3565', 'd3565@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('139', '86c7286c72', '1cf7db831c27843af8e0dec0c3ad0976', '机器人86c72', '86c72@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('140', '675c9675c9', '5d99e14783d4181457b25adf0e042186', '机器人675c9', '675c9@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('141', 'cfad1cfad1', '1d5435003010e2f8d314f39aebc8f0a0', '机器人cfad1', 'cfad1@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('142', '9799797997', '2ed5386ffd9f22fdf4ccc5e2a11761e6', '机器人97997', '97997@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('143', 'f3e41f3e41', 'ef37f1ef6153ceb922a239fb771c1949', '机器人f3e41', 'f3e41@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('144', 'e6813e6813', '1c113cbdff2b3190eb3666e058d454f4', '机器人e6813', 'e6813@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('145', '45c5745c57', '541c3d687de755171e48f7287c65cef6', '机器人45c57', '45c57@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('146', '166b8166b8', 'ef78b0170071248000ac12b7b2f6694f', '机器人166b8', '166b8@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('147', 'ca12aca12a', 'b818cae5ab4992fa6c3f05b236102529', '机器人ca12a', 'ca12a@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('148', 'e837ee837e', '4adcf846b1789b1e016ccde83e7aca40', '机器人e837e', 'e837e@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('149', 'b0898b0898', '242d4fc761fbff648b52c9e3edb1f0b6', '机器人b0898', 'b0898@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('150', 'e8ba0e8ba0', 'b0647fd838fa04930e78a5c1e6466afa', '机器人e8ba0', 'e8ba0@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('151', '2c8912c891', '94d42f02c0c76061615cfc0702a00f21', '机器人2c891', '2c891@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('152', 'c69d0c69d0', '0a55b94030f629c9f29422ea085f5a53', '机器人c69d0', 'c69d0@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('153', '5e0905e090', '611cbb4b7141f42b22285c7c4eff4a18', '机器人5e090', '5e090@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('154', 'fbb9afbb9a', '4158b613e362018f494f5470b366392a', '机器人fbb9a', 'fbb9a@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('155', '396fb396fb', '3802bada49f40f04493b411ca3a8d22c', '机器人396fb', '396fb@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('156', 'f58b0f58b0', '479617a06a07cc830835d3382c191eef', '机器人f58b0', 'f58b0@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('157', 'c131ec131e', '8aa1bbe4eb803803ea31f415e56a349f', '机器人c131e', 'c131e@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('158', '92af792af7', 'ff477ab03f70be7e8150fed7162c7de3', '机器人92af7', '92af7@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('159', '4e4314e431', 'd5cea85b22013b89eccf1438c12dd95a', '机器人4e431', '4e431@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('160', '7d6ec7d6ec', '17a7bb48b963c5e00a2ea35236c9ff5d', '机器人7d6ec', '7d6ec@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('161', '4340943409', '803e9296d2d9b05cff40e58c3564798f', '机器人43409', '43409@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('162', 'ba909ba909', '4de1b12ba16b2de0054777267840881f', '机器人ba909', 'ba909@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('163', 'f0b53f0b53', '2c92a4bd18b4be6735a08e821053e069', '机器人f0b53', 'f0b53@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('164', '0cf900cf90', '58eed712bd030a18a11c9d8496f5bd22', '机器人0cf90', '0cf90@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('165', '6476d6476d', '6dad9a8c3f3604943efcc9d7fb25d446', '机器人6476d', '6476d@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('166', '0777407774', '81f46aa57129791d149425ca9917570f', '机器人07774', '07774@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('167', '6469264692', 'c8a480bbf7adfa7c31a69b971ed87906', '机器人64692', '64692@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('168', '48ecf48ecf', '13fbd1afef0692ed77889623ef4a6a24', '机器人48ecf', '48ecf@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('169', '9964899648', 'cf2fbcdc842bd323b2687c1046df1dab', '机器人99648', '99648@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('170', '0ba060ba06', '2e9471535831a1a92aede192d4eb6448', '机器人0ba06', '0ba06@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('171', 'c06e3c06e3', 'f8025c95ae3579819e8e5af9463964b3', '机器人c06e3', 'c06e3@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('172', 'e665de665d', '366f2c720da1c81114bc5f6afae14451', '机器人e665d', 'e665d@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('173', '2c2d72c2d7', '2134ea9dd06a96dfae50db38eb1b8f78', '机器人2c2d7', '2c2d7@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('174', '735ad735ad', '2793a424e97049be10aaf26e86591a84', '机器人735ad', '735ad@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('175', 'ae780ae780', 'd308451bb5ee7819866565d89ae22f49', '机器人ae780', 'ae780@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('176', '82a2582a25', '087422c82e3d7958ba72fc96a085b551', '机器人82a25', '82a25@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('177', 'b5898b5898', '775f19882572d4d19d2141fd16a61971', '机器人b5898', 'b5898@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('178', '0097700977', 'e2ff0d3a8b4f4d2f5c0d9b00e8cb92fb', '机器人00977', '00977@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('179', '1771717717', '5984c34c0f3a6a742dc21e903a0371c5', '机器人17717', '17717@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('180', '2890f2890f', '0ce75bf09a42841ca34c7aacbcf5b028', '机器人2890f', '2890f@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('181', '47dd947dd9', '3fd4836dcc0a10b243bfd003b6d060b4', '机器人47dd9', '47dd9@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('182', '980cd980cd', 'b92b52e9d3fed859933b0be157d7a018', '机器人980cd', '980cd@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('183', '3c0503c050', 'cc2312e7b8f9322245ecb2d7f6cef46c', '机器人3c050', '3c050@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('184', '7102e7102e', '4f03e21c26dc0d63cc1c1676c5556b54', '机器人7102e', '7102e@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('185', '1202512025', '652d35817d6a5f0fd327bca3dba30619', '机器人12025', '12025@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('186', '470ea470ea', 'b9f28fda5904cf64369b745375cb4558', '机器人470ea', '470ea@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('187', '709ac709ac', 'c5ca12bb245590acefc113edbeec6c5b', '机器人709ac', '709ac@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('188', '8775287752', 'cde92791be68f3ea69bce46ad95c5cad', '机器人87752', '87752@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('189', '41ad441ad4', '514d39efa3b1761b391b45d6c66771ba', '机器人41ad4', '41ad4@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('190', 'd331bd331b', '70cbd2cc537e2d83f9f2ead1c105e39a', '机器人d331b', 'd331b@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('191', '2d6372d637', 'f063ca183c84a985027ed41e806018a7', '机器人2d637', '2d637@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('192', 'bc6fabc6fa', 'bf66fbab0d88db8292ced1d920cfcfdf', '机器人bc6fa', 'bc6fa@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('193', '1ef021ef02', 'fa77efcb6c73564b2e3d5ca30ebe3312', '机器人1ef02', '1ef02@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('194', '9b3559b355', '157cd07818ea98a702f0b66ba0692046', '机器人9b355', '9b355@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('195', 'ccef7ccef7', 'b5fb86773bd357277277e8d231994b7c', '机器人ccef7', 'ccef7@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('196', '3465834658', '6288f2810790e1063aa7ef2fedb39bb1', '机器人34658', '34658@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('197', 'f92d4f92d4', '3751f7bcaf8f3bfa1aa5034fa9b2736a', '机器人f92d4', 'f92d4@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('198', 'cfb79cfb79', 'c273b1f8e808e30ba37575e82bd301f4', '机器人cfb79', 'cfb79@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('199', 'ba044ba044', 'e2b55a4d879cf4b76e0a60b0b2846505', '机器人ba044', 'ba044@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('200', 'c4462c4462', 'c0d7671dcf50968666ed53421c46b7be', '机器人c4462', 'c4462@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('201', '7db9e7db9e', '0b6a6b432e7e95735d860f4b9f135716', '机器人7db9e', '7db9e@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('202', 'fbc3bfbc3b', 'c9f9c07ca36ffe8427c64068c528efc8', '机器人fbc3b', 'fbc3b@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('203', 'e0771e0771', '858ffb832a2fb09a256569cc3c839200', '机器人e0771', 'e0771@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('204', '9a98d9a98d', '38568f0673320b00901c02b20f6c15b2', '机器人9a98d', '9a98d@163.com', '100', 'reviewing', null, null);
INSERT INTO `t_account` VALUES ('205', '9ad739ad73', 'f0e717dd00c0821c11dab5ec1d8b3502', '机器人9ad73', '9ad73@163.com', '100', 'reviewing', null, null);

-- ----------------------------
-- Table structure for t_character
-- ----------------------------
DROP TABLE IF EXISTS `t_character`;
CREATE TABLE `t_character` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `role` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '角色',
  `explanation` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '解释',
  PRIMARY KEY (`id`,`role`),
  KEY `character` (`role`)
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
  `username` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '账号',
  `navigationId` int(11) NOT NULL COMMENT '系别模块id',
  `up_time` datetime NOT NULL COMMENT '时间',
  `title` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '文本标题',
  `url` varchar(200) COLLATE utf8_bin NOT NULL COMMENT '操作标识',
  `file_path` varchar(255) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_t_file_info_account` (`username`),
  KEY `FK_t_file_info_navigation_id` (`navigationId`) USING BTREE,
  CONSTRAINT `FK_t_file_info_account` FOREIGN KEY (`username`) REFERENCES `t_account` (`username`),
  CONSTRAINT `FK_t_file_info_navigation` FOREIGN KEY (`navigationId`) REFERENCES `t_navigation` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='数据表9';

-- ----------------------------
-- Records of t_file_info
-- ----------------------------
INSERT INTO `t_file_info` VALUES ('8', 'lalalala', '1', '2017-05-23 17:11:09', 'wawawwa', 'FILE_URL', 'FILE_PATH');
INSERT INTO `t_file_info` VALUES ('9', 'lalalala', '1', '2017-05-23 17:11:09', '我欲修仙，法力无边', 'FILE_URL', 'FILE_PATH');
INSERT INTO `t_file_info` VALUES ('10', 'lalalala', '1', '2017-05-23 17:11:09', '我欲修仙，法力无边', 'FILE_URL', 'FILE_PATH');
INSERT INTO `t_file_info` VALUES ('11', 'lalalala', '1', '2017-05-23 17:11:09', '我欲修仙，法力无边', 'FILE_URL', 'FILE_PATH');
INSERT INTO `t_file_info` VALUES ('12', 'lalalala', '1', '2017-05-23 17:11:09', '我欲修仙，法力无边', 'FILE_URL', 'FILE_PATH');
INSERT INTO `t_file_info` VALUES ('13', 'lalalala', '1', '2017-05-23 17:11:10', '我欲修仙，法力无边', 'FILE_URL', 'FILE_PATH');
INSERT INTO `t_file_info` VALUES ('14', 'lalalala', '1', '2017-05-23 17:11:10', '我欲修仙，法力无边', 'FILE_URL', 'FILE_PATH');
INSERT INTO `t_file_info` VALUES ('15', 'lalalala', '1', '2017-05-23 17:11:10', '我欲修仙，法力无边', 'FILE_URL', 'FILE_PATH');
INSERT INTO `t_file_info` VALUES ('16', 'lalalala', '1', '2017-05-23 17:11:10', '我欲修仙，法力无边', 'FILE_URL', 'FILE_PATH');

-- ----------------------------
-- Table structure for t_mapping_com
-- ----------------------------
DROP TABLE IF EXISTS `t_mapping_com`;
CREATE TABLE `t_mapping_com` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `om_id` int(11) NOT NULL COMMENT '名称',
  `role` varchar(20) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_t_mapping_COM_om_id` (`om_id`),
  KEY `FK_t_mapping_COM_character` (`role`),
  CONSTRAINT `FK_t_mapping_COM_character` FOREIGN KEY (`role`) REFERENCES `t_character` (`role`),
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
  `departmentId` int(11) NOT NULL,
  `parent` int(11) unsigned zerofill NOT NULL DEFAULT '00000000000',
  `title` varchar(30) COLLATE utf8_bin NOT NULL,
  `url` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `extend` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_t_nacigation_department` (`departmentId`),
  CONSTRAINT `FK_t_nacigation_department` FOREIGN KEY (`departmentId`) REFERENCES `t_department` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of t_navigation
-- ----------------------------
INSERT INTO `t_navigation` VALUES ('1', '100', '00000000000', '一级导航', null, '0');

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
-- View structure for v_account_info
-- ----------------------------
DROP VIEW IF EXISTS `v_account_info`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_account_info` AS select `t_account`.`id` AS `id`,`t_account`.`username` AS `username`,`t_account`.`name` AS `name`,`t_account`.`mail` AS `mail`,`t_account`.`role` AS `role`,`t_profession`.`profession` AS `profession`,`t_profession`.`department_id` AS `department_id`,`t_department`.`department` AS `department` from ((`t_account` join `t_profession` on((`t_account`.`profession_id` = `t_profession`.`id`))) join `t_department` on((`t_profession`.`department_id` = `t_department`.`id`))) ;

-- ----------------------------
-- View structure for v_char_pro
-- ----------------------------
DROP VIEW IF EXISTS `v_char_pro`;
CREATE ALGORITHM=TEMPTABLE DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_char_pro` AS select `t_mapping_com`.`id` AS `id`,`t_character`.`role` AS `role`,`t_module`.`module` AS `module`,`t_operate`.`operate` AS `operate` from ((((`t_character` join `t_mapping_com` on((`t_mapping_com`.`role` = `t_character`.`role`))) join `t_mapping_om` on((`t_mapping_com`.`om_id` = `t_mapping_om`.`id`))) join `t_module` on((`t_mapping_om`.`module` = `t_module`.`module`))) join `t_operate` on((`t_mapping_om`.`operate` = `t_operate`.`operate`))) order by `t_mapping_com`.`id` ;

-- ----------------------------
-- View structure for v_file_info
-- ----------------------------
DROP VIEW IF EXISTS `v_file_info`;
CREATE ALGORITHM=UNDEFINED DEFINER=`skip-grants user`@`skip-grants host` SQL SECURITY DEFINER VIEW `v_file_info` AS select `t_file_info`.`id` AS `id`,`t_file_info`.`username` AS `username`,`t_account`.`name` AS `name`,`t_file_info`.`up_time` AS `up_time`,`t_file_info`.`title` AS `title`,`t_file_info`.`url` AS `url`,`t_file_info`.`file_path` AS `file_path`,`t_profession`.`department_id` AS `departmentId`,`t_file_info`.`navigationId` AS `navigationId` from ((`t_file_info` join `t_account` on((`t_file_info`.`username` = `t_account`.`username`))) join `t_profession` on((`t_account`.`profession_id` = `t_profession`.`id`))) ;

-- ----------------------------
-- Procedure structure for test
-- ----------------------------
DROP PROCEDURE IF EXISTS `test`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `test`()
BEGIN
    declare c int default 0;
    select c ;
END
;;
DELIMITER ;
