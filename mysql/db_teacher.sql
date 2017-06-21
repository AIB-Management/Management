/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50718
Source Host           : localhost:3306
Source Database       : db_teacher

Target Server Type    : MYSQL
Target Server Version : 50718
File Encoding         : 65001

Date: 2017-06-20 18:22:11
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_account
-- ----------------------------
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
) ENGINE=InnoDB AUTO_INCREMENT=827 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='账号表';

-- ----------------------------
-- Records of t_account
-- ----------------------------
INSERT INTO `t_account` VALUES ('209', '9c138227-4015-4ab1-979b-ffd54348cfb3', 'znhoznho', 'e0bbb65e628dd40297ee1ef12198427c', 'znhoznho', 'wsxzh22@163.com', 'admin', '7020304c-cc1d-41ea-bf17-d4b154378ae4', '6d9b3825-3131-48c3-86b0-6630a72251ed', '2017-06-06 17:53:37');
INSERT INTO `t_account` VALUES ('218', '835b8a58-f545-41ef-97b4-a561ef72c7d4', 'wewewsewew', 'f26a60621dd9f0262a919380fce469e2', 'sdasdsad', 'qweqwe@163.com', 'teacher', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('219', '552b5449-16b4-4f12-9111-54c475099e0f', 'lalalala', '4a2a2fa3f04dd5f37f2684e37ddf5da3', '阿苏德文', 'qwewe@163.com', 'teacher', '6f5d85b2-2de0-4e09-a233-1fda040f228b', null, null);
INSERT INTO `t_account` VALUES ('420', '12a216a5-2d53-4b95-84d5-1d5674674a2c', 'lalalala0', '9e7aa53e8df81474e53cb252038630a2', '机器人0', 'i00121232@163.com', 'teacher', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('421', '43619a62-fc09-4914-96ce-f61aa04fbbc9', 'lalalala1', 'a338d2effc4e97272e8ae511386f334d', '机器人1', 'i12121232@163.com', 'teacher', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('422', 'cb535091-f59a-4ee6-9a4e-ef6c9530b615', 'lalalala2', 'b43a0afb7ec27e3e85f5769dd5b1f8b9', '机器人2', 'i24121232@163.com', 'teacher', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('423', '58ae6925-0a9d-45af-9af0-39ca09343e64', 'lalalala3', '2a80d9902520626475f89e2b1e26c59e', '机器人3', 'i36121232@163.com', 'teacher', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('424', '8047c4c8-f095-4171-90eb-99992440f939', 'lalalala4', 'cef0e639a5da5892e27dcb510f64a789', '机器人4', 'i48121232@163.com', 'teacher', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('425', '6e470ac9-4472-4583-8570-e51779a85b53', 'lalalala5', '1113d782dedfa42fac0e6335cc3f5173', '机器人5', 'i510121232@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('427', '8e2322ed-fd74-4b51-9b97-d07bb8a06b1b', 'lalalala7', 'cd6d3dc0e8693fac63660ef825c63632', '机器人7', 'i714121232@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('429', 'cd4933a4-be88-4d05-bd05-aa872ae5c9a2', 'lalalala9', 'f21746fe5bc4112ab752f66325f26f34', '机器人9', 'i918121232@163.com', 'teacher', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('430', 'd4ff9639-a4cb-4a32-ae1c-7b1e2afa00bd', 'lalalala10', 'c1057e8cf23a392e107de15d2c9263af', '机器人10', 'i1020121232@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('434', 'd3a54919-94c0-405a-8ac1-c44ea7a6c2c0', 'lalalala14', 'e8210d6e832dafb019af6b4a9558cbca', '机器人14', 'i1428121232@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('435', 'bf2ebfc0-c4b3-4565-8266-99921b52940b', 'lalalala15', '32acdd562d309014e3bd33dd03421285', '机器人15', 'i1530121232@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('436', '8532af9b-0411-4ebe-9c7b-b57df4a4b538', 'lalalala16', 'b58956ca01710b47e04ebaaf04b53c06', '机器人16', 'i1632121232@163.com', 'teacher', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('437', '03474cb9-f5e1-4998-9a11-78c9e483043b', 'lalalala17', '83ce2a94da2879f13e61e2b7cacd8414', '机器人17', 'i1734121232@163.com', 'teacher', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('438', '15ac79ec-462e-4a62-b0bf-4d745cee2090', 'lalalala18', 'bc2c3e7a53fa48ef1cbf7fc1a036d74d', '机器人18', 'i1836121232@163.com', 'teacher', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('439', 'd78746cb-eee3-40e7-b2dc-dba45b4c4ea7', 'lalalala19', 'f9d254eb799a5d8fc1d0398a9bb03474', '机器人19', 'i1938121232@163.com', 'teacher', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('440', '80c2dbcb-a59c-4383-940f-2cd2b1a5a42a', 'lalalala20', '24044c51d7826179e29041f8282d9d86', '机器人20', 'i2040121232@163.com', 'teacher', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('441', 'fa701f87-6d4f-456d-834f-67680c5d304d', 'lalalala21', '4658f070a707f70afcfdfc99b4877316', '机器人21', 'i2142121232@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('445', 'd630623d-41b6-4217-bfb7-b58b5118f4b3', 'lalalala25', '36f3c0df4760d8a64518304ad07176f2', '机器人25', 'i2550121232@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('446', '7ef6b1b2-9046-486f-b85d-c11b1378aef2', 'lalalala26', '58749b49453c4eb25d92adddadcf585f', '机器人26', 'i2652121232@163.com', 'teacher', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('447', '0eb587fa-298d-45b4-a247-ea6ff427d06a', 'lalalala27', 'ed3c17f4056bfae8760b532b49b05143', '机器人27', 'i2754121232@163.com', 'teacher', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('448', '6773f38b-ed9f-4302-8093-ea23618e5ed4', 'lalalala28', 'd0bccc44851b14b2457ec20b604b3e97', '机器人28', 'i2856121232@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('449', '7dd3590d-09aa-424f-8a5e-f4b03d8b13a2', 'lalalala29', '880b06ff6978aaa0035b9edb9b25af9a', '机器人29', 'i2958121232@163.com', 'teacher', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('450', '99ff2a1e-f146-49e9-b59f-778507d8f9e8', 'lalalala30', 'db7f7784121cf22390d5094b7053163f', '机器人30', 'i3060121232@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('451', '9f763241-3127-4339-9bdf-b8b7509806d9', 'lalalala31', 'bccbc3f76120e433c6826312fa2591a4', '机器人31', 'i3162121232@163.com', 'teacher', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('452', 'c8c59ffe-86bc-4906-847d-26769300efd4', 'lalalala32', 'acc0db6b9ce241a234021693894420dc', '机器人32', 'i3264121232@163.com', 'teacher', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('453', 'b0163bcf-8e42-4046-8dcf-d547813b38c3', 'lalalala33', '3bc6fc189427175f66ebc199a340501d', '机器人33', 'i3366121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('454', 'faf4521e-cb5f-417c-9e91-b89d6dd1d003', 'lalalala34', 'ccf36fac1ade33e86390f69cae7f7d6f', '机器人34', 'i3468121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('455', '5ea1d845-5085-416b-82a6-abeaf67f5b6e', 'lalalala35', '074976e14a907698e79281ca10fa2974', '机器人35', 'i3570121232@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('456', 'b745f6c1-aedf-4bca-9301-8cc91c4a2fd2', 'lalalala36', '7328ed517ea5ae9b4c7399a6fcb3b584', '机器人36', 'i3672121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('457', '5f43400a-d9d2-43d1-a7d7-7cf81d75f44e', 'lalalala37', '72c69c4f797d8b1bf32f815c7cc07427', '机器人37', 'i3774121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('458', 'f7266bb3-662b-4d36-a5fc-684f7b6a80a2', 'lalalala38', 'b89d47e4a5b4599ecac90984928c6f11', '机器人38', 'i3876121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('459', '3c7f82a4-e036-4516-be3b-6451eb762c34', 'lalalala39', '6ae41f761c97eeeae70d625768d0d00f', '机器人39', 'i3978121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('460', 'd274db1b-d423-4b8c-aed7-c92bc310d62e', 'lalalala40', 'fd01ffe8901e3c31fb9b4a44c56508fd', '机器人40', 'i4080121232@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('461', '79802cb0-33cf-4050-b80d-a14322b8c6c4', 'lalalala41', '7e2275ad0ebda1b397949e3a1def92d2', '机器人41', 'i4182121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('462', '94c7553f-f9f1-4739-8b2d-6460e10d74c6', 'lalalala42', '058226f1ff3a029286cd7e84c46eb327', '机器人42', 'i4284121232@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('463', '71c0f3a4-4f4f-4fab-96ca-7f643d052aff', 'lalalala43', 'fce81e189ffd910548015d7d505fb3d0', '机器人43', 'i4386121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('464', '26e374ad-6f8e-435b-984a-a89f4d202e4c', 'lalalala44', '7a359cf43c7aee8f5ef98a4d8238b30e', '机器人44', 'i4488121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('465', '72f4ba83-569f-4aa1-be84-d133c1828b25', 'lalalala45', '9f2aeb1a11abdcef9c68d447b9bb0e6c', '机器人45', 'i4590121232@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('466', '42ef01ea-bd75-45fc-a53b-5c2b00a0ac4a', 'lalalala46', 'ef39eaf7126d2f3119b99e533a45d904', '机器人46', 'i4692121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('467', 'fd3f1c5b-ae89-49de-bc87-e782016ea609', 'lalalala47', '7a908abac968c1a84f6f79324fb20b49', '机器人47', 'i4794121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('468', '85f2acf0-e9b1-42a7-afea-993b47f1893b', 'lalalala48', '260324fce2df747536174fa03866ecc8', '机器人48', 'i4896121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('469', '9548b0bc-ad6e-4c5f-b095-8b8ac0b056f3', 'lalalala49', 'b76f13dd9a348cf0e84c0f77420c6e71', '机器人49', 'i4998121232@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('470', 'fc8333b6-d4a1-42c6-a9a8-65212d7fe9f4', 'lalalala50', '44fa5ca05000b5dde3dadb1011951047', '机器人50', 'i50100121232@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('471', '5715b1d3-bc79-4629-9c42-57525ee95fa3', 'lalalala51', 'c2298d3b3bccdb4b847cd4dac6c1e66d', '机器人51', 'i51102121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('472', 'aba330cb-98ee-4d0f-bc81-e0279f1ee728', 'lalalala52', '0b3f95d8ba09fef2ad9e8cd89d1a10b8', '机器人52', 'i52104121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('473', '7aa61968-ae2c-4389-ace8-c8cb4a0fa3c1', 'lalalala53', '1ad87241691fe085f65ba6ba7a9f6a55', '机器人53', 'i53106121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('474', '9b4f1c3a-93f2-4613-8c0e-7472a11d966b', 'lalalala54', '1c4d264067722e1e920124afdc1efe06', '机器人54', 'i54108121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('475', 'bdb04e92-e3e7-46ea-8696-ff7478faa030', 'lalalala55', '64cfdfb44861a5bb4f66c172d926cb52', '机器人55', 'i55110121232@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('476', '158485ff-c6a1-451a-acad-4058334d455b', 'lalalala56', '0db4a061356914a105c2d671c3f1bfc0', '机器人56', 'i56112121232@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('477', '1d8b8ee2-ad27-4f5d-a530-e687b072eca7', 'lalalala57', '84aacaf82df15b5d62b8752ba56a5270', '机器人57', 'i57114121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('478', '80805b6c-dec9-4561-b32b-2e95c92bbf95', 'lalalala58', '78af056017019c03ca81fe974ece4fb1', '机器人58', 'i58116121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('479', '239780d3-23f2-4d35-81a0-560bd5182b84', 'lalalala59', '1811afbcc90e2ac66e2827df6a0a2fdb', '机器人59', 'i59118121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('480', 'a484f834-bc91-49b6-83ae-824409e09d32', 'lalalala60', '04a57289c097715759b578164b0310b0', '机器人60', 'i60120121232@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('481', '7b86cdd0-d3f1-42bb-a04b-c3a496f3068a', 'lalalala61', 'a79f5f0333692e46560ea472bc29ca20', '机器人61', 'i61122121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('482', '3f1f259c-4b92-4916-a25c-0c3ae5ae7365', 'lalalala62', '72c4839e5cd5bad3e27afa328d7eea49', '机器人62', 'i62124121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('483', '4df3457b-257d-45ef-8cca-2cdd41a9dd09', 'lalalala63', 'dd8d49bd5066fbd6198f46836d5d5044', '机器人63', 'i63126121232@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('484', 'b0f0b89c-7fc1-4954-afa1-15340d3bdc62', 'lalalala64', 'c3bf29717d0f2cc7a7edfc768882f392', '机器人64', 'i64128121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('485', 'e6a56544-957c-4d02-9af7-9d97dcab1986', 'lalalala65', '4b2ab23d17d93cf00b44999493b5e0a2', '机器人65', 'i65130121232@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('486', '453a56bf-8a0b-4959-baa6-f61ac8d63d30', 'lalalala66', '678c7a03ff4dec70f0edfb9dec3049a8', '机器人66', 'i66132121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('487', '1e8e5917-6526-4338-bbcd-235fd3d46252', 'lalalala67', 'd6eff9afaa0e9c488cde0ba73ebfe38a', '机器人67', 'i67134121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('488', '6b342437-c23d-4a48-9f20-50cf01ee46a0', 'lalalala68', '9044aef6cc86d732b1ff78cbbd089173', '机器人68', 'i68136121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('489', 'cc714ddc-cf0c-4c12-a89e-d2d9024b9274', 'lalalala69', 'b165f5d495b06283312688e032778c4f', '机器人69', 'i69138121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('490', '6491469e-7cbf-4ba2-af51-6730f0e0c334', 'lalalala70', 'e8d8797a76ad1564290631b27c700c6f', '机器人70', 'i70140121232@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('491', 'e9d44b1b-ece0-4a96-a625-946c570a703e', 'lalalala71', '9fe5b01a15af2873e3bdceb627f69be7', '机器人71', 'i71142121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('492', 'dcf765e5-6f26-42ce-a285-544c7fd7c9b9', 'lalalala72', '57c1d536cff6adf0e867f75dff7d9a82', '机器人72', 'i72144121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('493', '8bac3234-78cb-438f-b3af-7e4613030682', 'lalalala73', '5a5b88659952c6ede711fe6bf656fcec', '机器人73', 'i73146121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('494', '525dba76-f4cd-4895-869e-4b75dd005179', 'lalalala74', '49a5b6f89aa626e623bb482ddcd78ac5', '机器人74', 'i74148121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('495', '9146417f-b1d1-4fdf-8b07-48675f1eae11', 'lalalala75', 'c655da0972d610dd100eb00fccbf1ecc', '机器人75', 'i75150121232@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('496', '5fb99279-e47f-42fc-8f74-0502b42cd289', 'lalalala76', '37c0a976bc1fdb6671c9d12c0a35ba47', '机器人76', 'i76152121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('497', '88a5d4d5-b267-4151-9dd5-9bfc7c9711c9', 'lalalala77', '92c662fc9dd6492897cb9c587a207967', '机器人77', 'i77154121232@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('498', 'e710bdd4-dc89-4adc-a9d6-709fd16f5f3f', 'lalalala78', 'ad1b5b4001b1426d187870cc35645742', '机器人78', 'i78156121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('499', 'cf1cc908-6b3c-45d6-b52c-007056ece5b0', 'lalalala79', '9328157714b868f02e7f4edde7b3b687', '机器人79', 'i79158121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('500', '15887218-bf90-4336-9428-704f42f86025', 'lalalala80', 'c2ce0da11c25619d8188f37c9ef10ae9', '机器人80', 'i80160121232@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('501', '6cf139c1-40dd-4467-9943-a7cf356dc591', 'lalalala81', '461d5fa033b4542907b52499702a1573', '机器人81', 'i81162121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('502', 'a65eb08e-e0eb-4a2d-b542-25aadb5ae500', 'lalalala82', '016181e2cfcf8d687efcfc90d02247fd', '机器人82', 'i82164121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('503', '017097f5-9281-42eb-84a0-3f07e90024c7', 'lalalala83', '1a4ed10c4a2fbe4b7f5a9816cabf1739', '机器人83', 'i83166121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('504', 'a806a44b-8eb3-4419-a309-79aaf09884b9', 'lalalala84', 'eaa56b991b03fcbe73c671b8b9bcda06', '机器人84', 'i84168121232@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('505', '09845f09-32c7-48a1-bdb0-0a3d02abaf28', 'lalalala85', '2ddbc13ff363573672bed8537e8158c6', '机器人85', 'i85170121232@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('506', 'd10ce7ec-7bd9-4ab8-9a19-c3c90393dc35', 'lalalala86', '6b6a26c35da27d296dc4c4fb7dd6cfd2', '机器人86', 'i86172121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('507', '900cbf66-3f64-4d7e-9ca5-c414885d6ee2', 'lalalala87', '5613dc61af5cad5858fe8765a0bab813', '机器人87', 'i87174121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('508', '99066840-141d-4da1-9d83-1f4e3abaa7ba', 'lalalala88', 'e20e6a79363d80462a463d3f05766fa6', '机器人88', 'i88176121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('509', '257a0a5f-5b13-4093-92c5-198f83f2a8f4', 'lalalala89', '111dc823df61e3c2116fe4396e0a7cc6', '机器人89', 'i89178121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('510', 'cf1dc4ac-5bba-441d-830d-34160149c410', 'lalalala90', '77026feb4a7e4f74bda83fe732809493', '机器人90', 'i90180121232@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('511', 'abec5fc8-95a5-406d-bc45-f003c257143a', 'lalalala91', '6d958191147e00e899b8addf26eadabf', '机器人91', 'i91182121232@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('512', '41229092-dec5-4edb-bb6b-f5bc6b5e6e8b', 'lalalala92', '38cc41493a5c7bd628309bdaa3113422', '机器人92', 'i92184121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('513', 'c34d275d-d06e-4b5f-959f-b960d77027d0', 'lalalala93', 'c5169f4dce125f1ad7d4cf55aadae838', '机器人93', 'i93186121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('514', '06e90353-080b-4784-b2ea-f4a8a9edd54d', 'lalalala94', 'c0c58f85e4e7d105623ff42b1c487bba', '机器人94', 'i94188121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('515', '4efb69d8-d967-4fda-9258-29143963ddd2', 'lalalala95', '018fc5af33eb0a03cabd6cb7f8b70dcd', '机器人95', 'i95190121232@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('516', 'f293a548-fee7-4ea4-b1f8-6cf7515270af', 'lalalala96', '476f39ef48b78f3ed0d9a6880f4d4b70', '机器人96', 'i96192121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('517', 'cf882ef4-c4fe-447e-9dd2-eb03e9615e1c', 'lalalala97', '2ecb9e90828003acb28ce9ab7f62993f', '机器人97', 'i97194121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('518', '24dbbf78-57ee-4566-8365-0f5f91945d06', 'lalalala98', '392a92a4704a90282e46ebaf553d8681', '机器人98', 'i98196121232@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('519', '4e12f942-8688-4cf1-a0d5-49e43d30d9b1', 'lalalala99', 'b279831ffb4260e3d9ad4f84b78d791f', '机器人99', 'i99198121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('520', '840b0277-428f-457c-b7d8-63525ac84968', 'lalalala100', '16439b0167e94229add809f936666145', '机器人100', 'i100200121232@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('521', '4a24e430-3195-40cc-932e-7d81604db90c', 'lalalala101', '3116d5c9cbe5b83adc5ac12fae7bad04', '机器人101', 'i101202121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('522', 'fb191fa2-a77e-4ce6-a501-efd712f17cbf', 'lalalala102', 'aa0175dea05dc5a76b538a79e3e070c6', '机器人102', 'i102204121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('523', 'c7e075d5-cf05-4b7a-8e87-41f8a5213c13', 'lalalala103', '0cdf1b1d6f888b377d6e7cb7bdef29ab', '机器人103', 'i103206121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('524', '9b4b2a43-a84e-4ebc-bc8a-4cffdadd4fc1', 'lalalala104', '7ded1312660addf67ab02ec71a73c840', '机器人104', 'i104208121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('525', 'c730d195-4c0a-45c7-9e9a-0befc6b35a20', 'lalalala105', '36aeb6fafdb55011ac49e23db092acf2', '机器人105', 'i105210121232@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('526', '0da07ee9-dfdc-4dc6-a076-5194931b3b60', 'lalalala106', 'f4eb4676f26aa53d9434bd761471a279', '机器人106', 'i106212121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('527', '3244a875-f883-4c55-8aed-4c098d7193b8', 'lalalala107', '40b6691861705ef8b68ec51fc30648af', '机器人107', 'i107214121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('528', 'fd60d36f-1212-4445-900b-291491fbe80b', 'lalalala108', '4cdb6426a1d630e5c94704ba32c72cac', '机器人108', 'i108216121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('529', '0bcd7621-6bd4-4256-b2c1-9210230b79ce', 'lalalala109', 'fd3fca3588165dba2b5fb892b8d06217', '机器人109', 'i109218121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('530', '3df5af2c-56a6-4e40-92ce-045513840617', 'lalalala110', 'e579546dd07f840d68a7f1ae517acb22', '机器人110', 'i110220121232@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('531', '35015d17-95ce-4243-9d3a-20acf6ad66aa', 'lalalala111', 'd843f72da5e8733d2e32898e6f16f36d', '机器人111', 'i111222121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('532', 'e30396a5-884c-421d-a761-8566825fb50f', 'lalalala112', '4b1feff22f0f37f2b3beb1f351a79fe5', '机器人112', 'i112224121232@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('533', '56d9f613-0454-4a59-b3f1-d1d18d6b7b23', 'lalalala113', '28a7d9ee91e7626e03140508c29d0613', '机器人113', 'i113226121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('534', '0064fbff-358a-4d35-83db-02880eb5a359', 'lalalala114', 'c37c131c6a44a45810ad1dc3052da96d', '机器人114', 'i114228121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('535', 'e9ef9233-9df9-4b98-9b92-fcf6503ce8dd', 'lalalala115', '32b266c2412912b600f442ea382bc8f0', '机器人115', 'i115230121232@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('536', '0fe56111-1e2a-4fd4-8a9e-d0952c4cbd58', 'lalalala116', '1d947f375b7a911a7d7ad77f82d84191', '机器人116', 'i116232121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('537', '61a3b309-1a70-46d0-a4e4-b6bb823aa75d', 'lalalala117', '01be642422ed4fd9dda795c595236853', '机器人117', 'i117234121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('538', '82d90196-bfe7-4884-a3e6-cee6640d1822', 'lalalala118', 'f78701f2d008cb47c66225c116a3282d', '机器人118', 'i118236121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('539', '38727ffb-1c09-4785-abde-ee12faaa23ac', 'lalalala119', '91575581b1abd85322a7f44258552f02', '机器人119', 'i119238121232@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('540', '355d3477-83be-4906-98a5-b2a40f16bd88', 'lalalala120', '1be28d92de171b6233f0347582d90b20', '机器人120', 'i120240121232@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('541', '338a2f00-7cd3-4c73-8e46-a8f50ed6a577', 'lalalala121', 'ca4fa18e7935a732627d70e250910afb', '机器人121', 'i121242121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('542', '32228640-980f-41cf-91b9-f1c14c07e877', 'lalalala122', 'b1d635a2ca69a27ce694875ffebe55a0', '机器人122', 'i122244121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('543', '99452041-576f-4388-a010-4fe21a18be40', 'lalalala123', '683bca29c900aa8bf8e44f92cf61d774', '机器人123', 'i123246121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('544', '8c884284-adee-4e3f-b242-a00c4632bad7', 'lalalala124', '159b1ba8a91248b1afd055b69da6f357', '机器人124', 'i124248121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('545', 'dced8375-baac-4510-9c57-f7f5fad3f50e', 'lalalala125', 'b4ef366679d83ae50bfc3201ec46ee53', '机器人125', 'i125250121232@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('546', 'f051f89b-ca3c-4c4c-bede-eea00b252af2', 'lalalala126', '71ce378e69d608cd6180351b542272f8', '机器人126', 'i126252121232@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('547', 'e1c2ea70-f26f-48de-8528-d303983125b9', 'lalalala127', 'a6f1b46a0aa7216e5b34b7d2cf77a7bf', '机器人127', 'i127254121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('548', 'dbeb9567-4c88-4edf-acb0-20b090dc4924', 'lalalala128', '3e601b0b1aba003179729030b4fa6269', '机器人128', 'i128256121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('549', 'a1ee1010-0541-45ce-a77a-510416ca5836', 'lalalala129', 'f85ef56a0b33878b5282e6f76e18942e', '机器人129', 'i129258121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('550', 'd69321b2-9372-4c13-8c52-e5c6b2e3a227', 'lalalala130', '3a66c225ff549ab9f96d625dcfa00d3d', '机器人130', 'i130260121232@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('551', '5bf9c28c-a372-488d-a54e-6ac275191804', 'lalalala131', 'a5eb84d20c18d781b8b5c7ab5e917587', '机器人131', 'i131262121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('552', '516584c4-4358-4705-a27a-bcbf635518b1', 'lalalala132', '8b574108af11064b989c186b8ecd2e91', '机器人132', 'i132264121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('553', '7f1c066c-8635-470e-88b6-27c377d92ee4', 'lalalala133', 'c5e860bfb5aa3e992ed43820e97e1d35', '机器人133', 'i133266121232@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('554', '51f85375-bf5d-48d4-ae6e-5d8931c54a6e', 'lalalala134', '463c88306c17d085beda67f2c27448d0', '机器人134', 'i134268121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('555', '564da742-3a41-4e2c-910d-ae5c895b891a', 'lalalala135', 'bf7cb0e7a47459fe90d8bc3afa18c77b', '机器人135', 'i135270121232@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('556', '8387d9a2-3f24-44ea-8ee3-6f7093fa5966', 'lalalala136', 'b9549712a273cbeb2ff190f3bc0f40b5', '机器人136', 'i136272121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('557', '2f6272c0-f74e-4e04-9393-2209813bf359', 'lalalala137', '9e6cfbff1acc2db24bb03ddefb2d520d', '机器人137', 'i137274121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('558', '6eafd52d-58b6-4f02-8b88-5b3d698a8dda', 'lalalala138', '113c87f417920b56798391f4eecd06a9', '机器人138', 'i138276121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('559', '8259d59f-0041-4b06-bb4b-0d4d25e60dbd', 'lalalala139', '4eb9a9f6f88703fa27de05305e97a89f', '机器人139', 'i139278121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('560', '21c6bad4-01a6-438f-80f8-ea625c13501e', 'lalalala140', '5afe6b6756af62fc38aef3bef61ba258', '机器人140', 'i140280121232@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('561', '8dd67575-a95e-4dc3-b237-5d8da732ff72', 'lalalala141', 'f1764736a20e3050b753f7d6f2476878', '机器人141', 'i141282121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('562', 'a1c82e65-9857-42ce-9f6d-8c95757c4341', 'lalalala142', 'fc8d8706d664e05ac59f9fe73d800990', '机器人142', 'i142284121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('563', 'cb93bb24-1bca-4d27-bf0c-e1cc730e0dc5', 'lalalala143', '051c7a1487b89fd0a969d5ae549900da', '机器人143', 'i143286121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('564', 'de3df385-c0f1-4f56-bcfa-0b8eb5b1652a', 'lalalala144', '7b3149ba8a9a32faec464ee1a22bec69', '机器人144', 'i144288121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('565', 'c09c4094-08e3-4c6a-be35-6685a7c2ec31', 'lalalala145', '5b88fcaa3026832f7e09dcc31e7e6cde', '机器人145', 'i145290121232@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('566', '0a142b72-ae5b-4566-a756-9c003fdbdc33', 'lalalala146', 'f38c151886abd583c738fbaab57c6e11', '机器人146', 'i146292121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('567', '887b42ca-9ce6-4093-b995-b4044d9aeb89', 'lalalala147', '4dba1ccf4670b56e31bb6cd7c40cff9a', '机器人147', 'i147294121232@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('568', '1ff88e88-76ce-4900-ba58-62731ecf947d', 'lalalala148', '7cbd835fd8ebb91de67dd1d0f2c738e4', '机器人148', 'i148296121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('569', '05eb7a40-adc3-4468-be1f-8fc2ff489966', 'lalalala149', '100aa6b2b34c6ea76ee3bd1882ff2dd8', '机器人149', 'i149298121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('570', '33f16b4b-1019-4a72-ac56-f3b4db98d926', 'lalalala150', '9e602f24b5826e93709494dcf78eac2d', '机器人150', 'i150300121232@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('571', '6ba41c8c-8f48-40b2-869c-d86d7e51c8ce', 'lalalala151', '7d3e8e4472625cd3c4bec0bb9f7c31d8', '机器人151', 'i151302121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('572', 'aac247b1-60e7-49ba-86f4-520f871680be', 'lalalala152', 'de55612b4e2811c7250e92949cd2b7d6', '机器人152', 'i152304121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('573', 'a4c01d11-5bbb-497d-8621-0e0ce1e806bf', 'lalalala153', 'bfb87b6f3e2e57c839c69d8581e66b33', '机器人153', 'i153306121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('574', '77e9ba23-ed6b-43bd-a275-d264a0db83ce', 'lalalala154', 'da11b29271a312526d6915fa3468eb55', '机器人154', 'i154308121232@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('575', '74aa5682-30ca-4246-ac49-aee804bfa555', 'lalalala155', 'a5b5ff37af123c89aa4cfff5500224c0', '机器人155', 'i155310121232@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('576', 'b543d35f-4357-4b62-a590-8026af570821', 'lalalala156', 'e05ae41bfb215d69def543a7594bd3d3', '机器人156', 'i156312121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('577', '005bf021-ed49-4892-b4e9-cc9979a1d6e3', 'lalalala157', '70553339a7af4b46c01769783924580d', '机器人157', 'i157314121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('578', '98978756-55b3-4104-a130-7409c15f5249', 'lalalala158', '3c110bbaeab47b8ca18d02e908d0f451', '机器人158', 'i158316121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('579', '7317d9f4-d8d7-4db4-9197-634142e6d74c', 'lalalala159', 'c79c3cd55c65cc8d1fcbc6234f9f85f1', '机器人159', 'i159318121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('580', 'b63d8816-44c1-49d8-9234-24c0f4e4122b', 'lalalala160', '228e801d8a60db0e48977f9549330211', '机器人160', 'i160320121232@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('581', '12784095-b338-42ad-8362-f76b4b885328', 'lalalala161', 'c03756a97e043337ab265975a1f751b2', '机器人161', 'i161322121232@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('582', 'a1c54d27-d5f4-42cc-9a54-67e461092836', 'lalalala162', '00d22b8a05ead4826a4885a64125a90c', '机器人162', 'i162324121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('583', 'c6abad71-6b25-411f-b002-6181b91963ee', 'lalalala163', '715eb19a06cab849caf5fdc130b9d623', '机器人163', 'i163326121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('584', '7c247342-fcec-42bc-a64e-9fbb56e2801a', 'lalalala164', '39f334f87bfa48d00397d6948c9b9040', '机器人164', 'i164328121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('585', '86f147b2-de01-4310-9c98-c7424b0b4b61', 'lalalala165', '8554bedcf611f546451ba36012f6d499', '机器人165', 'i165330121232@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('586', '8d6d2ee9-ab79-4da2-92fd-391ac11b28f4', 'lalalala166', '7defef8e38f7a523c2fdf29b737feb28', '机器人166', 'i166332121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('587', '628519d3-ed8a-488b-a3df-90d948d00adb', 'lalalala167', '248c05e98d8d71c68bc584ee9970767b', '机器人167', 'i167334121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('588', '435e7387-fc80-438c-9796-b551724ef93f', 'lalalala168', 'f0b73718ba9afa701b9c6637c775acd9', '机器人168', 'i168336121232@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('589', '97894502-1418-4d01-b223-656dc4932c10', 'lalalala169', '50ac2b44bdad209497196c6ce8ded7e5', '机器人169', 'i169338121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('590', '7dfdab8c-3b49-4e93-871c-0cc5528ac9f5', 'lalalala170', '666cf8e4cf21148c7485f947150cb588', '机器人170', 'i170340121232@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('591', '710ceb5c-a3af-476a-85e9-3d5df4111b11', 'lalalala171', '1b9cfed4ab2a242c2999380ccf9b1610', '机器人171', 'i171342121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('592', '5a294010-8aae-4bec-8d75-88449ea1a8b4', 'lalalala172', '6eb1dbd7648917acc0793eaa7e3267ef', '机器人172', 'i172344121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('593', '6a3447ff-b0d1-4591-b950-e1d0b6137c36', 'lalalala173', '5c1a6a230c16df3616d5280ec01c6640', '机器人173', 'i173346121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('594', '6c37039d-6404-49c2-8bc8-04b7661711b0', 'lalalala174', 'f3013300a826d7a4da3ee970b86262b3', '机器人174', 'i174348121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('595', '97a849ec-8c77-4fad-8985-94434e4ee5fd', 'lalalala175', '707cfbf54976984f3355b50ed4eaae22', '机器人175', 'i175350121232@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('596', '4751cdff-4266-41f1-8fc4-f7b39f69cc4d', 'lalalala176', 'cf1e562a8268c41adf73185ce8793678', '机器人176', 'i176352121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('597', '96c5e9ea-ca8a-41e7-887c-4195404785aa', 'lalalala177', 'e76cdf740cf501e5f9fe0437dc82f90b', '机器人177', 'i177354121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('598', '4561a9f6-1856-4d46-8d6b-2819690166f9', 'lalalala178', '2a8200752f0aa50b7b41f3071f822eba', '机器人178', 'i178356121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('599', 'a04c5ea5-f11a-4052-92fd-f8c100777d5d', 'lalalala179', '0de598fac60f683c3c5a8062496e4fb2', '机器人179', 'i179358121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('600', '1bbccff7-9388-4b6b-87c0-fb475016985a', 'lalalala180', 'a0e6702a1bb870a9d0fb3d872ba3fe40', '机器人180', 'i180360121232@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('601', '9cdab5a4-9651-4d18-93d3-771e09e37731', 'lalalala181', '0e3003a60441a4195c17f0d417247280', '机器人181', 'i181362121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('602', 'f71ad8d3-8f88-480c-a1d7-0f2c51459e2f', 'lalalala182', '5001844e22c2ea1c23ed2927f26eed62', '机器人182', 'i182364121232@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('603', '04ac42a7-8da8-4ff0-be0a-8abdf5277925', 'lalalala183', '6f471396ac8e6cae8b8c828e68e0bb31', '机器人183', 'i183366121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('604', '0fcd1967-f294-44f5-b28f-3e1836a3e455', 'lalalala184', 'ca23bda525f6abb1964933bc1a0f27f6', '机器人184', 'i184368121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('605', '552f3cd7-bd69-4b62-9134-a41277c1c5c8', 'lalalala185', '88f72a522aa0b45ec8093524c8da4f37', '机器人185', 'i185370121232@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('606', 'e2076131-3b78-438c-9a88-c5aef50fefd2', 'lalalala186', '308d0b4b73c3ab8f8f3883f1f4d2f7cd', '机器人186', 'i186372121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('607', 'ea9b1e61-5467-4bbd-aeb5-fe2655d40cbe', 'lalalala187', '92838251d4091e74c667ba7bb86af9d3', '机器人187', 'i187374121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('608', '1bc05ad6-0eca-448e-b788-0fcd006de492', 'lalalala188', '97d0c4ff0f7976d1097ba6d67a373666', '机器人188', 'i188376121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('609', 'c00859d2-6aa3-4c7a-852b-972fc09e5973', 'lalalala189', 'e1c3dcb193a9f2fe2e7614ea6e2a782f', '机器人189', 'i189378121232@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('610', '7df30234-f3d9-4945-804b-88596985e9a7', 'lalalala190', '6e73bd5007bdc6b17e98be2592163523', '机器人190', 'i190380121232@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('611', 'afe77776-c25d-4f9d-ad26-cc097d0b3a41', 'lalalala191', '0036f450d524825528603657ad791384', '机器人191', 'i191382121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('612', '1a9b17c2-c046-40b9-9f70-38fe2cb18b27', 'lalalala192', '7474ad7f3d2d0c1b7147111892b7331c', '机器人192', 'i192384121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('613', 'cee1b523-fd32-4228-8d83-75eb0504d7ae', 'lalalala193', 'b4f88093546d51fdfc878dece94a311a', '机器人193', 'i193386121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('614', '211800a8-ed4c-49ce-b285-f6451eea5695', 'lalalala194', '3ba8b4510aa01e0bd817b489b0f0338d', '机器人194', 'i194388121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('615', '04c8a070-6148-4480-8220-1266afceb736', 'lalalala195', 'e4226c777c3aecf601290605876d7dc8', '机器人195', 'i195390121232@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('616', '572f3585-a952-4c3b-b506-dabc39a1dc63', 'lalalala196', '262ba6f9638a30c755150ec191cfbe24', '机器人196', 'i196392121232@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('617', 'abbc2bdb-5828-4621-b219-f9b3c5c413fc', 'lalalala197', 'd00fde16ae12dd87bb246341ab7b840c', '机器人197', 'i197394121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('618', 'bfdfa702-6e6b-42b5-b844-86bdf8b16af1', 'lalalala198', '921d9f44863d63beb446b2c27db0705c', '机器人198', 'i198396121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('619', 'c3aa898f-4df4-44f7-a56f-5767558dfdf2', 'lalalala199', 'a4b61eb53a65477426567fa51784debd', '机器人199', 'i199398121232@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('620', 'bd44cd29-18c1-4a3e-a60d-cdb4a1503073', '123321123', '1bc4c6a899b582b1f3c77aff53b65c28', '小米糕点', 'weqweweqw@163.com', 'reviewing', 'b036d42e-1110-4d3e-84b2-87a07c95b422', null, null);
INSERT INTO `t_account` VALUES ('621', '131af7c1-ce36-44bf-adcd-7f81325e3ded', 'hahahaha0', '6f159d624cbf04efb1bc9b2b8c4fe776', 'XXX老师0', '0lalalala@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('622', 'fd46b1cc-f2b9-4c31-aecc-dc9786e8e8b1', 'hahahaha1', 'df3b434728760d5c9cef469a7e9b154f', 'XXX老师1', '2lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('623', 'decebb00-3702-4048-afec-a6dd14caa3aa', 'hahahaha2', '5f0e5322508d08f5e6639aeba672f50a', 'XXX老师2', '6lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('624', '0de458df-5a8f-4422-bc6a-90d14b5af2a5', 'hahahaha3', '1d3339828a7f9f7d1b71db67a8e022d4', 'XXX老师3', '12lalalala@163.com', 'reviewing', '192cab96-5956-418b-a883-19519f99e2c5', null, null);
INSERT INTO `t_account` VALUES ('625', '5a8ee5f3-75cd-49c5-aca9-d70a2fa9ef76', 'hahahaha4', '2d368c76bac12d43d7d116c03cda62d7', 'XXX老师4', '20lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('626', '79bfbca7-9166-4587-9865-1f154caeac7c', 'hahahaha5', '1a4791534ce0c608e7e018754085d928', 'XXX老师5', '30lalalala@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('627', '38ec9074-6b5a-451d-aeb0-d276480a6af2', 'hahahaha6', '62cf53b1196d68b3c33e4884487b59b5', 'XXX老师6', '42lalalala@163.com', 'reviewing', '192cab96-5956-418b-a883-19519f99e2c5', null, null);
INSERT INTO `t_account` VALUES ('628', '8f17f59c-36fc-4468-be6d-e0347ce53ccc', 'hahahaha7', 'e6a6c8ede876dc85f9b5dd208551ece4', 'XXX老师7', '56lalalala@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('629', '3d8ced00-1e1f-48b2-a497-34390c8e3fa5', 'hahahaha8', '0940680f9ec5a925bf6d0f445722d204', 'XXX老师8', '72lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('630', '40e80cb9-61b2-4d4b-80c4-9cba46f204c2', 'hahahaha9', '48478ec3edf50643c8d41e073617a6bf', 'XXX老师9', '90lalalala@163.com', 'reviewing', '192cab96-5956-418b-a883-19519f99e2c5', null, null);
INSERT INTO `t_account` VALUES ('631', 'c71136b0-cfd8-4727-a14a-cae91e48bf4c', 'hahahaha10', '5fbbf367c6cdd73616dd79f2324d490e', 'XXX老师10', '110lalalala@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('632', 'f2bf093e-33ee-45d0-b22a-0d1499109d1f', 'hahahaha11', '1fe4739730acd8137f9252e0931a4d61', 'XXX老师11', '132lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('633', 'e0a42e1f-e499-4272-b605-f4f9fe118018', 'hahahaha12', 'd3bf779231128e1d48a9f17086b37f4c', 'XXX老师12', '156lalalala@163.com', 'reviewing', '192cab96-5956-418b-a883-19519f99e2c5', null, null);
INSERT INTO `t_account` VALUES ('634', 'c436bab8-94f8-4d38-baa4-c1ebfbd6b673', 'hahahaha13', 'b72fc5dd901d095b9dd8ed8497c69eb4', 'XXX老师13', '182lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('635', '29b360c1-0b19-44e5-8c53-ebdabcd2ad9a', 'hahahaha14', '6928b53ab574ae75b56d25277bf74163', 'XXX老师14', '210lalalala@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('636', '108b2b44-412c-4251-accb-ccfc38360f0e', 'hahahaha15', '37bd78eb8b0da4e364054776eb16f805', 'XXX老师15', '240lalalala@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('637', '40a41957-dc9a-4884-a7d3-3d1b5a76dccf', 'hahahaha16', '3a56e9a6b0a2afbb0c6936a1806afe79', 'XXX老师16', '272lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('638', 'd1a4d6e8-6ca6-4413-a933-6b68bdfc7a41', 'hahahaha17', '1c01b4e4acac7c31143758900172a941', 'XXX老师17', '306lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('639', 'e5ed3f39-65a0-44a0-a624-4fad06587bb9', 'hahahaha18', '7a01cb6c2b3618c172b660670c1127fb', 'XXX老师18', '342lalalala@163.com', 'reviewing', '192cab96-5956-418b-a883-19519f99e2c5', null, null);
INSERT INTO `t_account` VALUES ('640', '1d2b0992-79a6-4b67-b05f-695a001a6b96', 'hahahaha19', '11ffedf06c93799ec21ef90c1697bde8', 'XXX老师19', '380lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('641', '9f83ad5d-b81b-462c-9e4d-702ca8e17b8e', 'hahahaha20', '24a9bbd3562b94aa78da8afebf82b5a2', 'XXX老师20', '420lalalala@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('642', 'd793e0ed-981d-49c6-818b-6a33bf9c558e', 'hahahaha21', 'a02d3ae5f9a51d3aee49746fa8e3f22e', 'XXX老师21', '462lalalala@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('643', 'be62b68f-ab35-4dcb-8073-b9b95dfe1736', 'hahahaha22', 'c71114e30604006264552d77b40e8d20', 'XXX老师22', '506lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('644', 'da98f938-4e81-43be-8964-9c314ad476c5', 'hahahaha23', 'dd1a9786c7abc78c23aaabeb9bf3cb7d', 'XXX老师23', '552lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('645', '0de370c2-796a-4cb1-9a18-3b0381c7ecde', 'hahahaha24', '1a352b34f05a30fc3d4f470ce8f70d13', 'XXX老师24', '600lalalala@163.com', 'reviewing', '192cab96-5956-418b-a883-19519f99e2c5', null, null);
INSERT INTO `t_account` VALUES ('646', 'e66c431e-49af-4c36-a2e6-1ddc1801dea5', 'hahahaha25', 'ffe8746259111fb42443256ddb8124e5', 'XXX老师25', '650lalalala@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('647', 'b4847f48-98ae-41d3-9335-7e06661d9c95', 'hahahaha26', 'e8e76f5d7257e91b172cdc54b1cd3e8a', 'XXX老师26', '702lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('648', 'ac71ed49-afdd-4432-a187-91b21cdb900c', 'hahahaha27', 'a893e2a75f448fd85758c27f778457aa', 'XXX老师27', '756lalalala@163.com', 'reviewing', '192cab96-5956-418b-a883-19519f99e2c5', null, null);
INSERT INTO `t_account` VALUES ('649', '6c414a5d-f9da-4e6c-86df-7ba4e8654764', 'hahahaha28', '24703c83f9bc6a77a5ed5a89cb6033c9', 'XXX老师28', '812lalalala@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('650', '62a2cd9c-5606-4d4f-9745-647c2fe37d03', 'hahahaha29', '49d9fec6a00b60adf17b01a5a5f80348', 'XXX老师29', '870lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('651', '160de89b-984c-4514-97d6-89184459f1bf', 'hahahaha30', '456f6c602d53002f4d94718bb53d6aef', 'XXX老师30', '930lalalala@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('652', '2b983c33-057c-46fa-affb-18f9037bc7dc', 'hahahaha31', '27a4b878e1ac9efb89097d005ef5b043', 'XXX老师31', '992lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('653', '6d5e6534-e268-4a7d-bf5a-2012960de5b6', 'hahahaha32', 'e9df359775868063b4c5889f17bf89f8', 'XXX老师32', '1056lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('654', '400db65f-9ae0-4178-b997-001b8170132b', 'hahahaha33', 'ced3136e24d9f286932d4df7a5c6be5c', 'XXX老师33', '1122lalalala@163.com', 'reviewing', '192cab96-5956-418b-a883-19519f99e2c5', null, null);
INSERT INTO `t_account` VALUES ('655', '9979ae2d-1a5d-4a38-8bb3-3fd324b79809', 'hahahaha34', '487bcf89852caa7abd37aefe85e31bc3', 'XXX老师34', '1190lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('656', '9b5ed84c-e088-4ae1-a7d1-4675277fa41e', 'hahahaha35', 'dbc830cda5d00908a8aeb41429f99f75', 'XXX老师35', '1260lalalala@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('657', '78475524-a512-4d91-a464-40ed24513234', 'hahahaha36', '53fc6ff557aa2b6e6c1fc144534f5914', 'XXX老师36', '1332lalalala@163.com', 'reviewing', '192cab96-5956-418b-a883-19519f99e2c5', null, null);
INSERT INTO `t_account` VALUES ('658', '964d5081-139e-4ce7-981c-1fa3c9ca84dc', 'hahahaha37', '30e8bf2eeb77503061b45c32bf0ad27e', 'XXX老师37', '1406lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('659', '837590e3-14fd-47fe-b58d-0622e5d861e5', 'hahahaha38', '6a20369ff337fc49c85bafc9682097b1', 'XXX老师38', '1482lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('660', 'b54b414c-0004-4167-a602-cbce2fa94521', 'hahahaha39', '39ee3faed074c38a49e2a8130e2e2196', 'XXX老师39', '1560lalalala@163.com', 'reviewing', '192cab96-5956-418b-a883-19519f99e2c5', null, null);
INSERT INTO `t_account` VALUES ('661', 'a4eac22a-e51a-4b20-ab16-eb78a0f32473', 'hahahaha40', 'd4d2a95c3f33b882a315ffaab7061130', 'XXX老师40', '1640lalalala@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('662', 'dd007df4-d7de-4520-a867-ef972cd29eb4', 'hahahaha41', 'd51909c9e9c4a2846d4b1a299250e71c', 'XXX老师41', '1722lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('663', 'b2614ad7-345f-4348-87ad-8199ebcefd7b', 'hahahaha42', '1272134cb9c5147074236d27daf2ea17', 'XXX老师42', '1806lalalala@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('664', '359013c6-3350-430b-8ebf-61c5cad351b3', 'hahahaha43', '7e0da8ea068aba2544a882b29352c5e9', 'XXX老师43', '1892lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('665', 'ef7db7b5-4fb3-42a2-bab5-f48972dae847', 'hahahaha44', '674b7f7d403c6474ce3506acf843a79d', 'XXX老师44', '1980lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('666', 'bf9908d0-0772-449e-a01d-cb6d1f13fee2', 'hahahaha45', '1b0fb34197a03e0655e166e810e2b94f', 'XXX老师45', '2070lalalala@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('667', '0ca6e241-2f60-4178-a8ee-5a57071ffcdd', 'hahahaha46', 'a9078ae837c68980887190f01eac2d46', 'XXX老师46', '2162lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('668', 'd74fc599-a936-474e-99c5-f1b0e28e54aa', 'hahahaha47', '0879df60016418fd268e83e7603a4e1a', 'XXX老师47', '2256lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('669', '6625e817-201d-48bf-aa03-0e2345e1472e', 'hahahaha48', '3e2e3da37cf608671f95a5c728675e20', 'XXX老师48', '2352lalalala@163.com', 'reviewing', '192cab96-5956-418b-a883-19519f99e2c5', null, null);
INSERT INTO `t_account` VALUES ('670', '063d1f77-43bc-4708-b9da-2d7043e0b7d1', 'hahahaha49', '691a042b5ffb25759893341a5371c877', 'XXX老师49', '2450lalalala@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('671', 'ba103a92-1d10-482f-af29-2b9ab40caa6c', 'hahahaha50', '5a719ef65dbc418a09bc008dc9641fbe', 'XXX老师50', '2550lalalala@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('672', 'dcefdc69-4244-4fd1-9c31-5f53d57a66ed', 'hahahaha51', '515d059a67a42d2a6e10d70cd8b54d62', 'XXX老师51', '2652lalalala@163.com', 'reviewing', '192cab96-5956-418b-a883-19519f99e2c5', null, null);
INSERT INTO `t_account` VALUES ('673', '38bbd829-cb4e-4c71-8bea-1731092eef25', 'hahahaha52', '18ee4ef7958f8a7e4eba019255a5968b', 'XXX老师52', '2756lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('674', 'b0f95479-51b3-4952-b57b-638e01c5d693', 'hahahaha53', '3f35f32b6c6c2094bb96579f6d0a32c2', 'XXX老师53', '2862lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('675', 'a03b31af-099d-46ec-9dcb-87c03f840a71', 'hahahaha54', '12db72cd6a40c00cfad8427af106fcdb', 'XXX老师54', '2970lalalala@163.com', 'reviewing', '192cab96-5956-418b-a883-19519f99e2c5', null, null);
INSERT INTO `t_account` VALUES ('676', 'b86da19f-1bb8-413a-ae42-2070638d6277', 'hahahaha55', '2d2b86d60f3ef2f18040a5f99f562766', 'XXX老师55', '3080lalalala@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('677', '8933c963-8700-44a4-97c2-1911bcc4e7df', 'hahahaha56', '08e3cd05c35f9c274ef1411a7107f201', 'XXX老师56', '3192lalalala@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('678', '4ebd181f-5102-4192-856c-34c79b4e2604', 'hahahaha57', '91224f74fc00f54872dc30ee7a8dd965', 'XXX老师57', '3306lalalala@163.com', 'reviewing', '192cab96-5956-418b-a883-19519f99e2c5', null, null);
INSERT INTO `t_account` VALUES ('679', '706ae76d-cae8-4c50-a786-753d5ec0e7a2', 'hahahaha58', 'd5089789dfc5dde7e1d57b3e1ac5078d', 'XXX老师58', '3422lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('680', '513a9042-f8d3-479b-8265-590370c20d60', 'hahahaha59', '3909504c84b9b636b84b9db484c29e13', 'XXX老师59', '3540lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('681', '337ed5d7-1887-49ad-ad52-d6576587894a', 'hahahaha60', '3b2393b87e87f8ce8259f76581baca83', 'XXX老师60', '3660lalalala@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('682', '089dc697-9e90-40af-a0c4-9092820060b3', 'hahahaha61', '5c37e63d2395850f6e978e63e4c0ce4d', 'XXX老师61', '3782lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('683', '217f87e2-4a50-41ae-8b1a-f600f198267b', 'hahahaha62', '0521a0d4791d4dbd83bc8dc438abd44c', 'XXX老师62', '3906lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('684', 'f70511fb-441c-4483-993d-a4a37e8285bf', 'hahahaha63', '6ec7904b760fb17570ba554dce4b4d55', 'XXX老师63', '4032lalalala@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('685', '7aa05a9a-c7a8-448a-99b1-6f9742604cd7', 'hahahaha64', '0fa00eaf965c4e123fb066874922c6e8', 'XXX老师64', '4160lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('686', 'f3d18287-712c-4093-8f9e-a25d33e8e81d', 'hahahaha65', '210c91e3898147e58233ce89b43d1f58', 'XXX老师65', '4290lalalala@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('687', '1fc4e175-ca19-4a4f-8c8c-764b8864e9b3', 'hahahaha66', '42991aa4122eb3be2921462b36a63974', 'XXX老师66', '4422lalalala@163.com', 'reviewing', '192cab96-5956-418b-a883-19519f99e2c5', null, null);
INSERT INTO `t_account` VALUES ('688', '32fa1faf-adcc-4c83-aa7e-bc270c48b02f', 'hahahaha67', '0305706abdc047e6c876578c9cda82ac', 'XXX老师67', '4556lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('689', '0badbd1e-ecda-4f8b-9b17-7156a3eeaa33', 'hahahaha68', '7bd2ada1bcba8451e44a05ede6767346', 'XXX老师68', '4692lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('690', '1f764ba5-9e6a-41ef-9d90-8d661461306d', 'hahahaha69', '28436cb101b735e941b21a2af3d5e1a7', 'XXX老师69', '4830lalalala@163.com', 'reviewing', '192cab96-5956-418b-a883-19519f99e2c5', null, null);
INSERT INTO `t_account` VALUES ('691', '457e9937-d498-44df-a35a-a1ac429e8867', 'hahahaha70', '9c67d24b1466ffaf844497a3ac1869bd', 'XXX老师70', '4970lalalala@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('692', '0eeac36e-4e5b-4a4c-b1e3-a25484c2be3a', 'hahahaha71', '62ef8f3380c3b83a50ac766977cf8d66', 'XXX老师71', '5112lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('693', '23c61b1a-ba38-4664-95b8-f8a75312efc1', 'hahahaha72', '53e76e799d56110a1ee8834c56fa4e91', 'XXX老师72', '5256lalalala@163.com', 'reviewing', '192cab96-5956-418b-a883-19519f99e2c5', null, null);
INSERT INTO `t_account` VALUES ('694', 'b882e000-bf7b-4d1b-93aa-bf69d534511a', 'hahahaha73', '915a02541399f4df9dffe637106cd6d2', 'XXX老师73', '5402lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('695', 'c4ece2a4-a6ae-4f9c-90d9-e96cc3fdf76e', 'hahahaha74', 'c49b8fd719f0524b78c69ee11516164b', 'XXX老师74', '5550lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('696', '0a490270-f80c-4e5f-a8b1-b41adb0d7a77', 'hahahaha75', 'e6dea2405a1cad0bf4c9596e7684466f', 'XXX老师75', '5700lalalala@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('697', '9690d956-aa9c-4bf7-9f12-8a6794fd592a', 'hahahaha76', 'b4a894b8acc603e23f52a43882511593', 'XXX老师76', '5852lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('698', '72abc60b-8b72-45cb-ab80-4f75710dfd84', 'hahahaha77', 'bcb131b93da4b6c70f44b323c7697500', 'XXX老师77', '6006lalalala@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('699', '35de3ae6-5c7e-4da6-858c-ab1a8ca2072f', 'hahahaha78', 'a31625c14c5542f65baa67af38e7b4ee', 'XXX老师78', '6162lalalala@163.com', 'reviewing', '192cab96-5956-418b-a883-19519f99e2c5', null, null);
INSERT INTO `t_account` VALUES ('700', '92f42402-156f-4a8d-bca0-ce9331411763', 'hahahaha79', '74e271618289f1c83af19f14720c53b2', 'XXX老师79', '6320lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('701', 'de79797b-9287-4006-9623-bf73a1d1a7ec', 'hahahaha80', 'e040892c7a29a3ad1f86d1f4e1c8e4c1', 'XXX老师80', '6480lalalala@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('702', '5978f344-94b2-4a86-aed4-b75cb5f732bd', 'hahahaha81', '54454e8dbe225551a9d88f1e53158c1d', 'XXX老师81', '6642lalalala@163.com', 'reviewing', '192cab96-5956-418b-a883-19519f99e2c5', null, null);
INSERT INTO `t_account` VALUES ('703', '5e7856ed-83e4-464f-a6a0-779f41bbc412', 'hahahaha82', 'dc632aa3b3d411a88567cd00d2f4b44a', 'XXX老师82', '6806lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('704', 'ed71ef35-23dc-4f5b-9fbe-54b826e29c1a', 'hahahaha83', '6188d74775e86ae29f68cbdc0df1ef14', 'XXX老师83', '6972lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('705', '31f0f408-e600-4d79-9d30-395a592ce7e6', 'hahahaha84', '0dcfd0b040785deddcfaa28ddc76b10a', 'XXX老师84', '7140lalalala@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('706', 'b627ff48-8f63-485e-ab88-6a7c5be0f2d6', 'hahahaha85', '48dca27bafbe57dafa852e9c9df05d62', 'XXX老师85', '7310lalalala@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('707', 'ed78461d-34b6-4662-bf0c-3c1cb3d737f9', 'hahahaha86', '1e7b19c87ca9846cb373c89bff997c5a', 'XXX老师86', '7482lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('708', '577d9729-47f7-4ebd-a169-b748bcb5a0d9', 'hahahaha87', '23d615423c108f082390215dd765ac64', 'XXX老师87', '7656lalalala@163.com', 'reviewing', '192cab96-5956-418b-a883-19519f99e2c5', null, null);
INSERT INTO `t_account` VALUES ('709', 'b4f5889a-1f70-4482-8c0e-41d1c1b22e01', 'hahahaha88', 'd134edbd950f2ad2d063f449c80e5edd', 'XXX老师88', '7832lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('710', '1ede264c-df77-46dd-ad66-fd12a5107ac5', 'hahahaha89', 'd0cfab9a88e62e2b8d6789bc4a26cb41', 'XXX老师89', '8010lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('711', '335cf2ed-dad5-4a24-ad27-59836733b897', 'hahahaha90', 'bb17868db7f812660c14a07c7cea9148', 'XXX老师90', '8190lalalala@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('712', '7b780d1a-09f3-4be3-9e80-ee12819658ba', 'hahahaha91', 'e4006d46dded21ae38323cdbb6d7c78d', 'XXX老师91', '8372lalalala@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('713', '4fbf5d81-d899-4e3b-8ef1-92e6bedd8742', 'hahahaha92', 'bd9cc5ed94486e107353c86e0c6de577', 'XXX老师92', '8556lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('714', '6c57da90-7fd2-4b82-8e7d-ecd4b2bf2700', 'hahahaha93', '6fe0c80261be09191fd865d706cf56f8', 'XXX老师93', '8742lalalala@163.com', 'reviewing', '192cab96-5956-418b-a883-19519f99e2c5', null, null);
INSERT INTO `t_account` VALUES ('715', 'c9cae332-b02d-4e1a-ac66-9801c039fb53', 'hahahaha94', '9740f726f707ef59a8fac30937474d5a', 'XXX老师94', '8930lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('716', '03037cc4-dc24-4394-9232-3e84795207da', 'hahahaha95', '91d2fda3c1999ae90967f1d05bb56a5b', 'XXX老师95', '9120lalalala@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('717', '781b443a-c56b-432f-8507-e53af80ed0ff', 'hahahaha96', '77f650f2528399ee06d1eb9e0e3532b6', 'XXX老师96', '9312lalalala@163.com', 'reviewing', '192cab96-5956-418b-a883-19519f99e2c5', null, null);
INSERT INTO `t_account` VALUES ('718', '7f2e74f6-8b19-4a19-95ee-1f9e352c26ee', 'hahahaha97', '4e47a75e519e995f1e5d8f2f50e06fa0', 'XXX老师97', '9506lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('719', 'f86ec04a-0ef9-4638-ac54-0598ccfbd0a7', 'hahahaha98', '7c791d1c7663dbd105429fa48cd11240', 'XXX老师98', '9702lalalala@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('720', '57bfbf49-03fa-4019-b2e9-af945347d486', 'hahahaha99', '3f8280214883370dc08a1bb2dd6c206e', 'XXX老师99', '9900lalalala@163.com', 'reviewing', '192cab96-5956-418b-a883-19519f99e2c5', null, null);
INSERT INTO `t_account` VALUES ('721', '7eabf787-28be-460d-9104-e3ff07c7f5bd', 'hahahaha100', 'd22e574988baf3cf4017dacd4bdb2c70', 'XXX老师100', '10100lalalala@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('722', 'aa850874-e0c9-41f9-865d-86ce673ddfdb', 'hahahaha101', 'eeed155d6eddf843f3b57f2c340617c6', 'XXX老师101', '10302lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('723', '9379a0ed-2911-4eee-a5b9-a3d2e4ce3419', 'hahahaha102', 'bf06da4b6166a52a10207d5b1fddcc5f', 'XXX老师102', '10506lalalala@163.com', 'reviewing', '192cab96-5956-418b-a883-19519f99e2c5', null, null);
INSERT INTO `t_account` VALUES ('724', '4ca45a04-282c-41f1-a96a-bbde0331006e', 'hahahaha103', '44932c69ae56d4f9e14b64f0dd2fc34d', 'XXX老师103', '10712lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('725', '18e5ed36-6995-4d25-b70e-9f04c0cd30bf', 'hahahaha104', '920a195df3a65539de8ccfa6e13e445a', 'XXX老师104', '10920lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('726', '2642ef7e-f61e-447b-b15a-306900114319', 'hahahaha105', '493f4b510b342c963a544dc01d961e41', 'XXX老师105', '11130lalalala@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('727', '40732d2f-abd8-4bbb-9dbb-b117c4cff9b9', 'hahahaha106', '48e61d37ab8fa95257241b4aeab49c49', 'XXX老师106', '11342lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('728', 'de0397d1-ab5c-4c09-a0f9-2cf80ff6c3a5', 'hahahaha107', '6782b801730325cd4ba4e251553c86bb', 'XXX老师107', '11556lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('729', '71df4cef-97ed-4ab7-8e05-066ddab4c6b9', 'hahahaha108', 'efa5d5baaff309fe37aaa87790a5f619', 'XXX老师108', '11772lalalala@163.com', 'reviewing', '192cab96-5956-418b-a883-19519f99e2c5', null, null);
INSERT INTO `t_account` VALUES ('730', '59e74375-54c5-4082-b762-b7751183c39d', 'hahahaha109', '40d5029ff5240fe5e2c8beef9c17aeaf', 'XXX老师109', '11990lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('731', '6f0e76e2-fcfa-4f73-84ba-bfa703c777b9', 'hahahaha110', '19c4f87283ba6b43ace686082fc82ca7', 'XXX老师110', '12210lalalala@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('732', 'cc43780f-7bc9-463f-8aaf-7b700a3cbd43', 'hahahaha111', 'dfd8fcfd8fe3f042939508b115dcb934', 'XXX老师111', '12432lalalala@163.com', 'reviewing', '192cab96-5956-418b-a883-19519f99e2c5', null, null);
INSERT INTO `t_account` VALUES ('733', 'dc10d0a3-19a4-470e-8b87-a8a96457cb16', 'hahahaha112', 'e802f5db91a377ccadc5bcdb49e0d761', 'XXX老师112', '12656lalalala@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('734', 'a782cad2-ff70-4bdf-8ce4-268be3adcd3f', 'hahahaha113', '1f1d193d866639da24b667aedafeca5c', 'XXX老师113', '12882lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('735', '2978e570-01ee-41a8-ad09-35cbf67663e4', 'hahahaha114', 'bfe8cd976e86654f3d49aea26b8760fe', 'XXX老师114', '13110lalalala@163.com', 'reviewing', '192cab96-5956-418b-a883-19519f99e2c5', null, null);
INSERT INTO `t_account` VALUES ('736', '2117b6fc-af31-4df5-9889-e895797dc47e', 'hahahaha115', 'c11702e3f14c6f530f1ad13635bce5a5', 'XXX老师115', '13340lalalala@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('737', 'fe9ab18d-d3f0-4926-8bac-f8e235fc6547', 'hahahaha116', 'b629338331ce2b475f1e1dcd08e4df95', 'XXX老师116', '13572lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('738', 'e65e008b-327d-47d2-bc2f-a426d02a0e45', 'hahahaha117', '0993d7c780124dc181907e19a9ee393b', 'XXX老师117', '13806lalalala@163.com', 'reviewing', '192cab96-5956-418b-a883-19519f99e2c5', null, null);
INSERT INTO `t_account` VALUES ('739', '27865d45-244b-4ccd-a92e-0fcb31df17d1', 'hahahaha118', 'eec7e63a25b437b8e3ef0acc7050a462', 'XXX老师118', '14042lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('740', '443cc30f-c75d-4043-bc2f-5bea78187403', 'hahahaha119', 'ef6901fa6cf09f9abbd37e7e29236e01', 'XXX老师119', '14280lalalala@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('741', 'aa88a6ab-ca39-42c7-a7ff-41b37b9ffa83', 'hahahaha120', 'b491b593ba28dfbc6793fb845f4573b4', 'XXX老师120', '14520lalalala@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('742', '9d9686f1-1aea-4dee-adc9-a0d52b3ad2cd', 'hahahaha121', '8c8eb15b5cbcb245a0485bcb0f19101e', 'XXX老师121', '14762lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('743', '4b095ae9-7bf2-4c63-8a11-1babf019507b', 'hahahaha122', '8bc9cdc7478fdd75b57c26778288f6c1', 'XXX老师122', '15006lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('744', '25cf994d-f125-48cd-91d4-4673ca841925', 'hahahaha123', '1c8b3895943e6565e996d70d92760d88', 'XXX老师123', '15252lalalala@163.com', 'reviewing', '192cab96-5956-418b-a883-19519f99e2c5', null, null);
INSERT INTO `t_account` VALUES ('745', 'a6a019f8-eb81-4dc1-9db7-5db598fc04f3', 'hahahaha124', 'a68bf7126bdfd9860bf5dec779020ef7', 'XXX老师124', '15500lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('746', '14a9144d-a790-4537-85b6-dba6817e2f7e', 'hahahaha125', 'fdf07ff18844249ef25adc6aaa28b571', 'XXX老师125', '15750lalalala@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('747', '7789f286-d783-4169-a581-fb8fb09fcc58', 'hahahaha126', 'ef05cc1003269f0fc2efdc21d4d56258', 'XXX老师126', '16002lalalala@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('748', 'e6ad029f-6db1-4147-b677-5f29cc4cdaf5', 'hahahaha127', '99414f50ffffb42d3493a42e1ada426c', 'XXX老师127', '16256lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('749', '59875b0c-5515-4d30-8ae9-1b4893a483f9', 'hahahaha128', 'ccbc842e08c752d26970341f0478cc83', 'XXX老师128', '16512lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('750', '7bae8f84-8d35-44af-9d5e-6b3031a1ad54', 'hahahaha129', 'c2565d70b2ddead07b07c65e9549685a', 'XXX老师129', '16770lalalala@163.com', 'reviewing', '192cab96-5956-418b-a883-19519f99e2c5', null, null);
INSERT INTO `t_account` VALUES ('751', '26c494f6-7c1d-4faf-822a-99b9c6bb9561', 'hahahaha130', '2533fc77c3ea0a346d6f2dcb11016018', 'XXX老师130', '17030lalalala@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('752', 'ef782602-84b7-45d8-973f-dd122747a8b2', 'hahahaha131', '6d1528eea2c93c4f2768c352ed8b94ee', 'XXX老师131', '17292lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('753', 'a3bb5848-29d7-4f2b-a9ca-95c2ac1f3aca', 'hahahaha132', '8e07f5a3520ae7119169ac3d08e8ac68', 'XXX老师132', '17556lalalala@163.com', 'reviewing', '192cab96-5956-418b-a883-19519f99e2c5', null, null);
INSERT INTO `t_account` VALUES ('754', 'bd38f022-f1d1-4664-86bb-e39405906ef1', 'hahahaha133', '09c558d698cb9225282f5b458e646e4f', 'XXX老师133', '17822lalalala@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('755', 'e08226f5-b646-4d2c-96df-638a9dd31a91', 'hahahaha134', '48fa54ff2dd013405bbcd025f8b4b21e', 'XXX老师134', '18090lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('756', 'c4ee5acf-0b84-45b2-85a9-d491efc375be', 'hahahaha135', 'bb5a04ddb54d2c8af7660b3116df4008', 'XXX老师135', '18360lalalala@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('757', 'fcdf194f-04a6-41b8-8985-78ca8ee344f5', 'hahahaha136', 'd2d95f79ce0bce6d386f957ddd8580e4', 'XXX老师136', '18632lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('758', '42e16b1d-c721-4d7c-ba43-7406d6dfa86f', 'hahahaha137', 'd8171e8e8f26f40ee839000afb474f3e', 'XXX老师137', '18906lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('759', 'cd2fec48-c6f8-4e2d-a746-8b347faef658', 'hahahaha138', '4a9c0f0e196ed4a93920db2b8c5881f5', 'XXX老师138', '19182lalalala@163.com', 'reviewing', '192cab96-5956-418b-a883-19519f99e2c5', null, null);
INSERT INTO `t_account` VALUES ('760', 'be13ca7b-db5a-4cb3-a898-04e92bf5df3b', 'hahahaha139', '1dd7e9f39321063d03b37535107a9f7f', 'XXX老师139', '19460lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('761', '3774c2f1-a28b-45fe-aa8a-e6cee171e651', 'hahahaha140', 'c382c729b8f7c698a566daa1c9234d88', 'XXX老师140', '19740lalalala@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('762', '09ab03ff-03d9-4b9e-9b89-7df8b99e830a', 'hahahaha141', 'bd4e18d25329f50e9563d5db3325c74a', 'XXX老师141', '20022lalalala@163.com', 'reviewing', '192cab96-5956-418b-a883-19519f99e2c5', null, null);
INSERT INTO `t_account` VALUES ('763', '58c3adbb-e564-4e9b-9fa0-48d9e5655ef8', 'hahahaha142', 'da3476d511a5de596b70525a15a9a67d', 'XXX老师142', '20306lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('764', '18e11733-18c8-45b8-a959-1ea2ee1c6f7d', 'hahahaha143', '3eaa6a1a5e267296b4a55b0a21a4ddf7', 'XXX老师143', '20592lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('765', '3248fe3a-458c-4374-ab76-bbc210e7d55d', 'hahahaha144', '8b444ae6c32b3d567d099c4d5f25c9e7', 'XXX老师144', '20880lalalala@163.com', 'reviewing', '192cab96-5956-418b-a883-19519f99e2c5', null, null);
INSERT INTO `t_account` VALUES ('766', 'f4d1ff00-b736-44af-b5d6-7a73e5dbc433', 'hahahaha145', 'c302aec53e6928f555d78c4017021058', 'XXX老师145', '21170lalalala@163.com', 'teacher', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('767', '896905ed-4527-4f0f-b1c0-8b1e66f9671a', 'hahahaha146', 'db9a05e154b05f58a8302fbb642fa4e5', 'XXX老师146', '21462lalalala@163.com', 'teacher', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('768', '5845bc70-322a-4a52-ad5e-94b27fed9712', 'hahahaha147', 'cda5e8cdafc870dd0a966797133a5929', 'XXX老师147', '21756lalalala@163.com', 'teacher', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('769', 'b57efc8e-71bb-493c-b98c-d037abf3cc04', 'hahahaha148', 'e5469c1447b5c5099e7033dbf807c2c0', 'XXX老师148', '22052lalalala@163.com', 'teacher', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('770', 'd92178c7-5961-4ad5-8461-312e6dd39511', 'hahahaha149', 'ccad09b627244e14a2c4dc01ee9e76db', 'XXX老师149', '22350lalalala@163.com', 'teacher', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('771', 'eec82d34-e454-456d-b2be-d88b4e94c839', 'hahahaha150', 'f70d74b8556e3d666442fed59b1186b0', 'XXX老师150', '22650lalalala@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('772', 'b89e951a-dae7-4f46-8333-9126d6b139c4', 'hahahaha151', '6ff6e62e9f03b1687cfb0f56a07eefe9', 'XXX老师151', '22952lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('773', '0ced279b-9f9f-4625-879e-e12b70c59a50', 'hahahaha152', '3670c77a1d982bd2b2ead9376f569474', 'XXX老师152', '23256lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('774', '88a9dc85-ded4-4eb3-9ac2-9b20fb0cc56c', 'hahahaha153', '7d9192da9311da94ed233b134c0bb3c7', 'XXX老师153', '23562lalalala@163.com', 'reviewing', '192cab96-5956-418b-a883-19519f99e2c5', null, null);
INSERT INTO `t_account` VALUES ('775', 'd064fcaa-f0c9-42b8-a9e5-0e420de607e4', 'hahahaha154', '5dd2aaf3e853f5d2432c6ccd693ca5f2', 'XXX老师154', '23870lalalala@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('776', '60daa2a0-0378-47aa-bade-11fc92b3f2f4', 'hahahaha155', 'd9577042e9ade7b2582c188980f01f50', 'XXX老师155', '24180lalalala@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('777', 'e5cd60da-0119-4f74-ad02-43e85fd508d1', 'hahahaha156', '34fff1909a051332320a5ff9724235f7', 'XXX老师156', '24492lalalala@163.com', 'reviewing', '192cab96-5956-418b-a883-19519f99e2c5', null, null);
INSERT INTO `t_account` VALUES ('778', 'e26d3166-e4cf-42fa-a131-c738553980e4', 'hahahaha157', 'c3602619e863413ed6525416b67a2532', 'XXX老师157', '24806lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('779', 'dcc1404e-56d5-466f-b5dc-be6bdc01cdc2', 'hahahaha158', '58d3aed6fffe93d599c54d1694278584', 'XXX老师158', '25122lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('780', '40a7960d-862a-4d93-9bbd-12c42aa890b6', 'hahahaha159', '733dca7af4ead456028c9ea0f3349b97', 'XXX老师159', '25440lalalala@163.com', 'reviewing', '192cab96-5956-418b-a883-19519f99e2c5', null, null);
INSERT INTO `t_account` VALUES ('781', '19ef7ce3-e86b-4446-8720-17ecb8fdda9b', 'hahahaha160', 'f64db83abf7cbe1c466a14ab741df017', 'XXX老师160', '25760lalalala@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('782', 'd206a1fe-ee62-4b7d-a0ef-9097b943d5a6', 'hahahaha161', '1889648a8186a642a18de4b4f4e58e2d', 'XXX老师161', '26082lalalala@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('783', 'd5662873-c001-49b4-b196-4d14fc1efce8', 'hahahaha162', '4b08a6ec3869482313019a762101f3e8', 'XXX老师162', '26406lalalala@163.com', 'reviewing', '192cab96-5956-418b-a883-19519f99e2c5', null, null);
INSERT INTO `t_account` VALUES ('784', '8c9045f6-e6c7-40e8-883f-617bcb72c8a6', 'hahahaha163', 'ee250c5438383507667589b4a7c324fb', 'XXX老师163', '26732lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('785', '737d2f99-1859-4f9b-835a-509970847ae9', 'hahahaha164', 'ae7701e250ec8fbaff4c671ee1028fa9', 'XXX老师164', '27060lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('786', 'f8c8daa6-94a9-4812-8cd8-6f46644460a9', 'hahahaha165', 'e5231eb9e0daa4dc86144ab6b74bece7', 'XXX老师165', '27390lalalala@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('787', '1a2730a6-3e31-4f0f-8e68-369e7082542d', 'hahahaha166', '6e6f2021ff88ba9a83c9dea0d4fb8ac1', 'XXX老师166', '27722lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('788', 'e7cf050e-e941-4082-b03a-3270981f1b17', 'hahahaha167', 'cc8e4bb17fe16c8cf072d045f980c39e', 'XXX老师167', '28056lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('789', '199003ff-4d58-4fd6-9c73-3ac580a4268a', 'hahahaha168', 'f8732e736f4eb5682cb746e72593a09d', 'XXX老师168', '28392lalalala@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('790', '0b2e5dd1-6894-4990-90b7-4a94a959eb86', 'hahahaha169', '2e66f3ef236daf1ad04209f41a3a4197', 'XXX老师169', '28730lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('791', 'f5d7421b-8562-4835-8611-9ef052a6e495', 'hahahaha170', 'd16de28ebf49f81b7662f270a324cf2a', 'XXX老师170', '29070lalalala@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('792', 'c43e7760-b944-43ba-809e-e8daa2644d46', 'hahahaha171', '32c0cc06704509fefa3dae7753305d20', 'XXX老师171', '29412lalalala@163.com', 'reviewing', '192cab96-5956-418b-a883-19519f99e2c5', null, null);
INSERT INTO `t_account` VALUES ('793', 'ad3ec348-f8c2-4e8d-a39a-027db4ba3b96', 'hahahaha172', '2cf93c9a4a851d87c097d438d11cb1b8', 'XXX老师172', '29756lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('794', '07e71986-8885-46ab-98df-8c62f5bad6e2', 'hahahaha173', 'acde064b49f550fbb1ef7b65cff5a749', 'XXX老师173', '30102lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('795', 'cc4c9caa-2c8e-4947-bd9a-2f627255ce59', 'hahahaha174', '5193f912370fabe3413d6700ce8348a7', 'XXX老师174', '30450lalalala@163.com', 'reviewing', '192cab96-5956-418b-a883-19519f99e2c5', null, null);
INSERT INTO `t_account` VALUES ('796', 'a5c6d6f3-b477-407e-8e15-2580b1191b67', 'hahahaha175', '088bd3046d60f51933b7c7bd3b7df5f2', 'XXX老师175', '30800lalalala@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('797', '0dbf87cd-e397-4ef4-abe8-65e8dcb498aa', 'hahahaha176', '08e99f42a121b6c71e1caf4147d30944', 'XXX老师176', '31152lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('798', '7a60974e-7827-4e7b-aeee-f7bead68ee38', 'hahahaha177', '85f5eb7ff351e502b9baef3a2cd2a6ce', 'XXX老师177', '31506lalalala@163.com', 'reviewing', '192cab96-5956-418b-a883-19519f99e2c5', null, null);
INSERT INTO `t_account` VALUES ('799', 'f4d1fadd-08e9-4e6f-bce5-eb11aa2c7f5b', 'hahahaha178', 'b278ba73e89da90400a46ed66afee3ec', 'XXX老师178', '31862lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('800', '1b1c1bca-d638-466b-a655-8e58a3928bb3', 'hahahaha179', '7721b1a96a35c94f3372eeaa347e2ab2', 'XXX老师179', '32220lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('801', 'f1ef485f-e8ec-43af-aaa2-ab906502c7fb', 'hahahaha180', 'fd385a550f02ec27554cbe7393d37e2a', 'XXX老师180', '32580lalalala@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('802', '5520beee-fb1a-47e8-aa7f-23b6f188f0f7', 'hahahaha181', '10cbd5616b35b1d5e5e78ae4896565b9', 'XXX老师181', '32942lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('803', '8b6989fb-2669-4fb9-93e6-dd45fa83d040', 'hahahaha182', 'be7a9dfe14f9dbcc6ae74d19627012f8', 'XXX老师182', '33306lalalala@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('804', '8d668aa7-f681-4a74-8b78-53cb5e659358', 'hahahaha183', 'b41c90a08d8b034542c9b22a44749dc4', 'XXX老师183', '33672lalalala@163.com', 'reviewing', '192cab96-5956-418b-a883-19519f99e2c5', null, null);
INSERT INTO `t_account` VALUES ('805', 'b3a0970a-380b-4c66-9555-2472f62f9ccf', 'hahahaha184', 'a6e63596e37d78be8a6b6e6cf3ea6fd0', 'XXX老师184', '34040lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('806', 'acf0fa9f-b50d-4aed-a036-7c91d4892585', 'hahahaha185', 'f84a4fb0070949e738d27d27bef6f960', 'XXX老师185', '34410lalalala@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('807', 'e9df6b2d-9f0c-4729-b159-2e19ca8702b4', 'hahahaha186', 'db42b204492092544ed20677ae59dcb5', 'XXX老师186', '34782lalalala@163.com', 'reviewing', '192cab96-5956-418b-a883-19519f99e2c5', null, null);
INSERT INTO `t_account` VALUES ('808', '7d4c0263-2de5-4408-85eb-0e4f55327117', 'hahahaha187', 'a4b6e73224ced7bf79fb2c948bc7fb27', 'XXX老师187', '35156lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('809', '0dea6b4a-d6b8-4ddd-b0c6-e249c5b77920', 'hahahaha188', 'e7f40682cd1c5e4b852f3e5ea5f23d82', 'XXX老师188', '35532lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('810', '55bcf4a9-1105-4577-9958-2161f650ae71', 'hahahaha189', '58b0a3e09c398a44f022d93f787bbf9c', 'XXX老师189', '35910lalalala@163.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('811', '0489dc66-3c9d-48b6-a313-3ce984e123c7', 'hahahaha190', '0e688ed366ea292a2abaa91f45b74d3a', 'XXX老师190', '36290lalalala@163.com', 'reviewing', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('812', 'bfeb1f36-8af5-483a-b022-4e43d5022931', 'hahahaha191', '3617d9443d02093f9e1f9015f9553c5e', 'XXX老师191', '36672lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('813', '46758dff-f40b-45bd-8548-b1fe28ce6ac0', 'hahahaha192', 'c08d400c8b9835e4ac575ad024a58e36', 'XXX老师192', '37056lalalala@163.com', 'reviewing', '192cab96-5956-418b-a883-19519f99e2c5', null, null);
INSERT INTO `t_account` VALUES ('814', '76abf13a-d41b-4654-bc5f-c0ff96834b8e', 'hahahaha193', '0660930595bbb228441fb3fb30d6aa35', 'XXX老师193', '37442lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('815', '73a104d8-ad8b-4d26-8cbc-e3797bae1073', 'hahahaha194', '7e338975c272f665a596e8b9c8372157', 'XXX老师194', '37830lalalala@163.com', 'reviewing', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('816', 'b47bd441-daab-4d05-8fc4-08df76b9b355', 'hahahaha195', '1ecce06795adea824870f4c14812aa4c', 'XXX老师195', '38220lalalala@163.com', 'teacher', '7020304c-cc1d-41ea-bf17-d4b154378ae4', null, null);
INSERT INTO `t_account` VALUES ('817', '2c4bdaf9-095b-472f-9072-ebbaa1b9cae2', 'hahahaha196', 'c53b545b6a0bb07df8bd5418df9fc5e3', 'XXX老师196', '38612lalalala@163.com', 'teacher', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('818', 'b5af4cd4-e4c7-48c5-af4b-b9f8476b60f7', 'hahahaha197', '5c7830098e7a23cccb3808d039dbfc49', 'XXX老师197', '39006lalalala@163.com', 'teacher', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('819', 'f333824a-63a0-4b6e-9a93-6a42dcd704bf', 'hahahaha198', '6b1f7965817d3b32aa9fa654fb08643b', 'XXX老师198', '39402lalalala@163.com', 'teacher', '192cab96-5956-418b-a883-19519f99e2c5', null, null);
INSERT INTO `t_account` VALUES ('820', '6e3b013b-8b04-4e4e-b908-206167c9729d', 'hahahaha199', '722f4d60350ad27092d5dff21fa0aa7b', 'XXX老师199', '39800lalalala@163.com', 'teacher', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5', null, null);
INSERT INTO `t_account` VALUES ('822', 'ef1e8cf3-cb2b-4a45-8b97-66d9f553562a', 'mahanzhen', '0641bff70b93523c9700b7a3f0afa7f6', '测试', '184999894@qq.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('823', '817cd809-ff71-40d4-ba98-14967de9493a', 'testaccount', '22a56d9d879737b50fa70ab1098c3c98', 'Teacher教师', '184999894kkk@qq.com', 'reviewing', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('824', 'c148f728-fe4b-4d62-a6cc-bce2841b44dd', 'AdminAccount', '2460ad6b09a12970264e3a4179dca270', '管理员', '31fadsfadsf5616@qq.com', 'admin', '29948d32-7d3a-4ada-8047-aebbd15e8636', null, null);
INSERT INTO `t_account` VALUES ('825', 'c018107c-e2e4-42a1-86b6-cf6435b03a0c', 'account123', '66d9300c79914a1cf93ec78920862d93', 'name', '6516161@163.com', 'reviewing', 'b036d42e-1110-4d3e-84b2-87a07c95b422', null, null);
INSERT INTO `t_account` VALUES ('826', 'f403c80f-41f8-4484-a016-f1c967e52177', 'test1234', '8493f9baa3329bd1854e1bfca1821af7', 'name', '466161@163.com', 'reviewing', 'b036d42e-1110-4d3e-84b2-87a07c95b422', null, null);

-- ----------------------------
-- Table structure for t_authorization
-- ----------------------------
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of t_authorization
-- ----------------------------
INSERT INTO `t_authorization` VALUES ('1', '12a216a5-2d53-4b95-84d5-1d5674674a2c', '552b5449-16b4-4f12-9111-54c475099e0f');
INSERT INTO `t_authorization` VALUES ('2', '43619a62-fc09-4914-96ce-f61aa04fbbc9', '552b5449-16b4-4f12-9111-54c475099e0f');
INSERT INTO `t_authorization` VALUES ('3', '8047c4c8-f095-4171-90eb-99992440f939', '552b5449-16b4-4f12-9111-54c475099e0f');
INSERT INTO `t_authorization` VALUES ('4', '552b5449-16b4-4f12-9111-54c475099e0f', '8047c4c8-f095-4171-90eb-99992440f939');
INSERT INTO `t_authorization` VALUES ('5', 'cd4933a4-be88-4d05-bd05-aa872ae5c9a2', '15ac79ec-462e-4a62-b0bf-4d745cee2090');
INSERT INTO `t_authorization` VALUES ('6', '552b5449-16b4-4f12-9111-54c475099e0f', 'd4ff9639-a4cb-4a32-ae1c-7b1e2afa00bd');
INSERT INTO `t_authorization` VALUES ('7', 'cb535091-f59a-4ee6-9a4e-ef6c9530b615', '6e470ac9-4472-4583-8570-e51779a85b53');
INSERT INTO `t_authorization` VALUES ('9', '552b5449-16b4-4f12-9111-54c475099e0f', '5f43400a-d9d2-43d1-a7d7-7cf81d75f44e');
INSERT INTO `t_authorization` VALUES ('10', '552b5449-16b4-4f12-9111-54c475099e0f', 'faf4521e-cb5f-417c-9e91-b89d6dd1d003');
INSERT INTO `t_authorization` VALUES ('12', '552b5449-16b4-4f12-9111-54c475099e0f', '43619a62-fc09-4914-96ce-f61aa04fbbc9');
INSERT INTO `t_authorization` VALUES ('15', '552b5449-16b4-4f12-9111-54c475099e0f', 'cb535091-f59a-4ee6-9a4e-ef6c9530b615');

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
  `content` varchar(40) COLLATE utf8_bin DEFAULT NULL,
  `parent` varchar(40) COLLATE utf8_bin DEFAULT NULL COMMENT '为0时是系别，等于id时是专业',
  `uid` varchar(40) COLLATE utf8_bin NOT NULL COMMENT '操作标识',
  PRIMARY KEY (`id`,`uid`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=418 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='系别';

-- ----------------------------
-- Records of t_department
-- ----------------------------
INSERT INTO `t_department` VALUES ('401', '计算机系', '0', 'a434d90d-a267-457c-8e10-89028ce6ed27');
INSERT INTO `t_department` VALUES ('402', '软件技术', 'a434d90d-a267-457c-8e10-89028ce6ed27', '29948d32-7d3a-4ada-8047-aebbd15e8636');
INSERT INTO `t_department` VALUES ('403', '移动应用', 'a434d90d-a267-457c-8e10-89028ce6ed27', 'b036d42e-1110-4d3e-84b2-87a07c95b422');
INSERT INTO `t_department` VALUES ('404', '管理系', '0', 'c72c7b69-5770-47fb-bb25-51b476e55373');
INSERT INTO `t_department` VALUES ('405', '财经系', '0', 'b3964e6b-89eb-4dac-9b8e-f290070fa877');
INSERT INTO `t_department` VALUES ('406', '艺术系', '0', 'cb6b88e6-de96-4d73-894e-2b80b8693105');
INSERT INTO `t_department` VALUES ('407', '机电系', '0', 'cf39e05d-8cc0-4591-9ed7-ce0146b7e94b');
INSERT INTO `t_department` VALUES ('408', '信管', 'a434d90d-a267-457c-8e10-89028ce6ed27', '6f5d85b2-2de0-4e09-a233-1fda040f228b');
INSERT INTO `t_department` VALUES ('409', '物流', 'c72c7b69-5770-47fb-bb25-51b476e55373', '7020304c-cc1d-41ea-bf17-d4b154378ae4');
INSERT INTO `t_department` VALUES ('410', '金融', 'b3964e6b-89eb-4dac-9b8e-f290070fa877', '15fc2163-3bb6-4f61-bf60-abcd1136a4d5');
INSERT INTO `t_department` VALUES ('411', '数控', 'cf39e05d-8cc0-4591-9ed7-ce0146b7e94b', '4a7daf02-f09f-43d3-904f-71c1fe632ef5');
INSERT INTO `t_department` VALUES ('412', '产品造型设计', 'cb6b88e6-de96-4d73-894e-2b80b8693105', '192cab96-5956-418b-a883-19519f99e2c5');
INSERT INTO `t_department` VALUES ('413', '多媒体设计与制作', 'cb6b88e6-de96-4d73-894e-2b80b8693105', 'c6cc4472-d330-4fe0-b5f3-ef349029a7ad');
INSERT INTO `t_department` VALUES ('414', '环境艺术设计', 'cb6b88e6-de96-4d73-894e-2b80b8693105', '35624ca7-2e71-4c62-8dc8-ddb36686b84d');
INSERT INTO `t_department` VALUES ('417', '软件测试', 'a434d90d-a267-457c-8e10-89028ce6ed27', 'cebb7867-eca8-401f-bcdf-bcb1ee0ea3ed');

-- ----------------------------
-- Table structure for t_file
-- ----------------------------
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='数据表9';

-- ----------------------------
-- Records of t_file
-- ----------------------------
INSERT INTO `t_file` VALUES ('10', 'ef1e8cf3-cb2b-4a45-8b97-66d9f553562a', 'e3da4355-c68e-4b54-a82f-fed0907a3d49', '2017-06-20 18:04:00', 'hahah', 'this is url', 0x2F546561636865727346696C652F65663165386366332D636232622D346134352D386239372D3636643966353533353632612F63363265353030612D363134362D343234342D613035662D323037653139326235666532, '51521683-f0ba-49f4-a4ea-dded3577bb6b');
INSERT INTO `t_file` VALUES ('11', 'ef1e8cf3-cb2b-4a45-8b97-66d9f553562a', 'e3da4355-c68e-4b54-a82f-fed0907a3d49', '2017-06-20 18:18:15', 'fadfadf', 'this is url', 0x2F546561636865727346696C652F65663165386366332D636232622D346134352D386239372D3636643966353533353632612F38616437636436662D303936642D343335362D383330642D353463643865306463626639, '2763cf02-a75d-4488-9d5d-de10c71793df');

-- ----------------------------
-- Table structure for t_file_item
-- ----------------------------
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='数据表9';

-- ----------------------------
-- Records of t_file_item
-- ----------------------------
INSERT INTO `t_file_item` VALUES ('7', '3d7f98d1-e6b4-4f78-82ed-bfd09175399d', '电子商务网络技术考纲.doc', '51521683-f0ba-49f4-a4ea-dded3577bb6b', 'application/msword', '00000000000', '1', '.doc');
INSERT INTO `t_file_item` VALUES ('8', '5fd08f0a-4025-4914-83e8-3b93a40ddf5b', '实践课程考核大纲.docx', '51521683-f0ba-49f4-a4ea-dded3577bb6b', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', '00000000000', '2', '.docx');
INSERT INTO `t_file_item` VALUES ('9', '01aaf3e2-2ec7-45f7-914a-26af37cba775', '实践课程考核大纲.docx', '2763cf02-a75d-4488-9d5d-de10c71793df', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', '00000000000', '1', '.docx');
INSERT INTO `t_file_item` VALUES ('10', 'e5684d64-ccf2-4762-9cab-39f77372ffd2', '电子商务网络技术考纲.doc', '2763cf02-a75d-4488-9d5d-de10c71793df', 'application/msword', '00000000000', '2', '.doc');

-- ----------------------------
-- Table structure for t_navigation
-- ----------------------------
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

-- ----------------------------
-- Records of t_navigation
-- ----------------------------
INSERT INTO `t_navigation` VALUES ('9', '0', 'first', '/content/ajaxFindNavAndFile.action?parent=dc3bbd84-6877-4452-8ca0-cb8eef59ea7f&depuid=c72c7b69-5770-47fb-bb25-51b476e55373', '1', 'dc3bbd84-6877-4452-8ca0-cb8eef59ea7f', 'c72c7b69-5770-47fb-bb25-51b476e55373');
INSERT INTO `t_navigation` VALUES ('10', 'dc3bbd84-6877-4452-8ca0-cb8eef59ea7f', '2', '/content/ajaxFindNavAndFile.action?parent=52b2bb42-dd33-4e73-9321-206f66ef72bc&depuid=c72c7b69-5770-47fb-bb25-51b476e55373', '1', '52b2bb42-dd33-4e73-9321-206f66ef72bc', 'c72c7b69-5770-47fb-bb25-51b476e55373');
INSERT INTO `t_navigation` VALUES ('12', '0', 'first', '/content/ajaxFindNavAndFile.action?parent=8b2fc2c8-583b-40c2-bebe-274eb16deb52&depuid=a434d90d-a267-457c-8e10-89028ce6ed27', '1', '8b2fc2c8-583b-40c2-bebe-274eb16deb52', 'a434d90d-a267-457c-8e10-89028ce6ed27');
INSERT INTO `t_navigation` VALUES ('13', '8b2fc2c8-583b-40c2-bebe-274eb16deb52', 'secend', '/content/ajaxFindNavAndFile.action?parent=e3da4355-c68e-4b54-a82f-fed0907a3d49&depuid=a434d90d-a267-457c-8e10-89028ce6ed27', '1', 'e3da4355-c68e-4b54-a82f-fed0907a3d49', 'a434d90d-a267-457c-8e10-89028ce6ed27');

-- ----------------------------
-- Table structure for t_permission
-- ----------------------------
DROP TABLE IF EXISTS `t_permission`;
CREATE TABLE `t_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `role` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '角色',
  `permission` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '分类:操作',
  PRIMARY KEY (`id`),
  KEY `FK_role_cha_role` (`role`),
  CONSTRAINT `FK_role_cha_role` FOREIGN KEY (`role`) REFERENCES `t_character` (`role`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of t_permission
-- ----------------------------
INSERT INTO `t_permission` VALUES ('1', 'teacher', 'content:query');
DROP TRIGGER IF EXISTS `delete_file_item_before`;
DELIMITER ;;
CREATE TRIGGER `delete_file_item_before` BEFORE DELETE ON `t_file` FOR EACH ROW DELETE FROM `t_file_item` WHERE (`fileUid`=old.uid)
;;
DELIMITER ;
