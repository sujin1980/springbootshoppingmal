/*
SQLyog Enterprise v12.2.6 (64 bit)
MySQL - 5.1.51-community : Database - shoppingmall
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`shoppingmall` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `shoppingmall`;

/*Table structure for table `brand` */

DROP TABLE IF EXISTS `brand`;

CREATE TABLE `brand` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `brand` */

insert  into `brand`(`id`,`name`,`remarks`) values 
(1,'易耗品','易耗品'),
(2,'有偿用品','有偿用品'),
(3,'皮草','皮草');

/*Table structure for table `client` */

DROP TABLE IF EXISTS `client`;

CREATE TABLE `client` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `chinesename` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `telephone` varchar(255) NOT NULL,
  `address` varchar(1000) NOT NULL,
  `weixin` varchar(255) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `qq` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `client` */

insert  into `client`(`id`,`name`,`chinesename`,`password`,`telephone`,`address`,`weixin`,`remarks`,`qq`) values 
(1,'jialefu','家乐福','jialefu','123456','天府大道华阳店',NULL,'的说法',NULL),
(2,'yiteng','伊藤','yiteng','456132','华府大道华阳店',NULL,'撒旦法',NULL),
(3,'oushang','欧尚','oushang','4124','艾弗森','asdf','示范法','1213413'),
(4,'sujin_123','苏进','123456','13981816942','阿道夫','阿斯蒂芬','fefefer','二二恶'),
(5,'shanyang','山羊','456123','18080456985','asdf','撒辅导费','effect','丰富');

/*Table structure for table `product` */

DROP TABLE IF EXISTS `product`;

CREATE TABLE `product` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `typeid` int(20) NOT NULL,
  `num` int(11) NOT NULL DEFAULT '0',
  `brandid` int(11) DEFAULT NULL,
  `price` decimal(10,0) NOT NULL DEFAULT '0',
  `icon` varchar(500) DEFAULT NULL,
  `status` int(255) NOT NULL DEFAULT '1' COMMENT '商品状态，1-正常，2-下架，3-删除',
  `begintime` varchar(255) NOT NULL DEFAULT '',
  `endtime` varchar(255) NOT NULL DEFAULT '',
  `remarks` varchar(255) NOT NULL,
  PRIMARY KEY (`id`,`remarks`) USING BTREE,
  KEY `brandid_id` (`brandid`),
  KEY `typeid_id` (`typeid`),
  KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=112 DEFAULT CHARSET=utf8;

/*Data for the table `product` */

insert  into `product`(`id`,`name`,`typeid`,`num`,`brandid`,`price`,`icon`,`status`,`begintime`,`endtime`,`remarks`) values 
(1,'佳洁士',1,0,NULL,10,'佳洁士icon',1,'','','佳洁士描述'),
(2,'舒克',1,0,NULL,12,'舒克icon',1,'','','舒克描述'),
(3,'舒肤佳',2,0,NULL,5,'舒肤佳icon',1,'','','舒肤佳描述'),
(4,'力士',2,0,NULL,7,'力士icon',1,'','','力士描述'),
(5,'本木',3,0,NULL,20,'本木icon',1,'','','本木描述'),
(6,'牛角梳',3,0,NULL,40,'牛角梳icon',1,'','','牛角梳描述'),
(7,'得力',4,0,NULL,20,'得力iocn',1,'','','得力描述'),
(8,'晨光',4,0,NULL,25,'晨光icon',1,'','','晨光描述'),
(9,'飘柔',5,0,NULL,35,'飘柔icon',1,'','','飘柔描述'),
(12,'南棉',6,0,NULL,30,'南棉icon',1,'','','南棉描述'),
(13,'小熊',7,0,NULL,100,'小熊icon',1,'','','小熊描述'),
(14,'小猫',7,0,NULL,120,'小猫icon',1,'','','小猫描述'),
(21,'中华',1,0,NULL,21,'中华icon',1,'','','中华介绍'),
(36,'牙具1',1,0,NULL,10,NULL,1,'','',''),
(37,'牙具2',1,0,NULL,0,NULL,1,'','',''),
(38,'香皂1',2,0,NULL,0,NULL,1,'','',''),
(39,'香皂2',2,0,NULL,0,NULL,1,'','',''),
(40,'梳子1',3,0,NULL,0,NULL,1,'','',''),
(41,'梳子2',3,0,NULL,0,NULL,1,'','',''),
(42,'办公用品1',4,0,NULL,0,NULL,1,'','',''),
(43,'办公用品2',4,0,NULL,0,NULL,1,'','',''),
(44,'保洁用品1',5,0,NULL,0,NULL,1,'','',''),
(45,'保洁用品2',5,0,NULL,0,NULL,1,'','',''),
(46,'浴巾1',6,0,NULL,0,NULL,1,'','',''),
(47,'浴巾2',6,0,NULL,0,NULL,1,'','',''),
(48,'床单1',7,0,NULL,0,NULL,1,'','',''),
(49,'床单2',7,0,NULL,0,NULL,1,'','',''),
(50,'洗发水1',8,0,NULL,0,NULL,1,'','',''),
(51,'洗发水2',8,0,NULL,0,NULL,1,'','',''),
(52,'沐浴露1',9,0,NULL,0,NULL,1,'','',''),
(53,'沐浴露2',9,0,NULL,0,NULL,1,'','',''),
(54,'浴帽1',10,0,NULL,0,NULL,1,'','',''),
(55,'浴帽2',10,0,NULL,0,NULL,1,'','',''),
(56,'拖鞋1',11,0,NULL,0,NULL,1,'','',''),
(57,'拖鞋2',11,0,NULL,0,NULL,1,'','',''),
(58,'水杯1',12,0,NULL,0,NULL,1,'','',''),
(59,'水杯2',12,0,NULL,0,NULL,1,'','',''),
(60,'垃圾袋1',13,0,NULL,0,NULL,1,'','',''),
(61,'垃圾袋2',13,0,NULL,0,NULL,1,'','',''),
(62,'个人护理1',14,0,NULL,0,NULL,1,'','',''),
(63,'个人护理2',14,0,NULL,0,NULL,1,'','',''),
(64,'纸品1',15,0,NULL,0,NULL,1,'','',''),
(65,'纸品2',15,0,NULL,0,NULL,1,'','',''),
(66,'有偿用品1',16,0,NULL,0,NULL,1,'','',''),
(67,'有偿用品2',16,0,NULL,0,NULL,1,'','',''),
(68,'小家电1',17,0,NULL,0,NULL,1,'','',''),
(69,'小家电2',17,0,NULL,0,NULL,1,'','',''),
(70,'标牌1',18,0,NULL,0,NULL,1,'','',''),
(71,'标牌2',18,0,NULL,0,NULL,1,'','',''),
(72,'餐饮用品1',19,0,NULL,0,NULL,1,'','',''),
(73,'餐饮用品2',19,0,NULL,0,NULL,1,'','',''),
(74,'生活百货1',20,0,NULL,0,NULL,1,'','',''),
(75,'生活百货2',20,0,NULL,0,NULL,1,'','',''),
(76,'大家电1',21,0,NULL,0,NULL,1,'','',''),
(77,'大家电2',21,0,NULL,0,NULL,1,'','',''),
(78,'拍照服务1',22,0,NULL,0,NULL,1,'','',''),
(79,'拍照服务2',22,0,NULL,0,NULL,1,'','',''),
(80,'食品饮料1',23,0,NULL,0,NULL,1,'','',''),
(81,'食品饮料2',23,0,NULL,0,NULL,1,'','',''),
(82,'公明收益1',24,0,NULL,0,NULL,1,'','',''),
(83,'公明收益2',24,0,NULL,0,NULL,1,'','',''),
(84,'美酒周边1',25,0,NULL,0,NULL,1,'','',''),
(85,'美酒周边2',25,0,NULL,0,NULL,1,'','',''),
(86,'瓷砖卫浴1',26,0,NULL,0,NULL,1,'','',''),
(87,'瓷砖卫浴2',26,0,NULL,0,NULL,1,'','',''),
(88,'五金1',27,0,NULL,0,NULL,1,'','',''),
(89,'五金2',27,0,NULL,0,NULL,1,'','',''),
(90,'智能设备1',28,0,NULL,0,NULL,1,'','',''),
(91,'智能设备2',28,0,NULL,0,NULL,1,'','',''),
(92,'被套1',29,0,NULL,0,NULL,1,'','',''),
(93,'被套2',29,0,NULL,0,NULL,1,'','',''),
(94,'枕套1',30,0,NULL,0,NULL,1,'','',''),
(95,'枕套2',30,0,NULL,0,NULL,1,'','',''),
(96,'面巾1',31,0,NULL,0,NULL,1,'','',''),
(97,'面巾2',31,0,NULL,0,NULL,1,'','',''),
(98,'方巾1',32,0,NULL,0,NULL,1,'','',''),
(99,'方巾2',32,0,NULL,0,NULL,1,'','',''),
(100,'地巾1',33,0,NULL,0,NULL,1,'','',''),
(101,'地巾2',33,0,NULL,0,NULL,1,'','',''),
(102,'被芯1',34,0,NULL,0,NULL,1,'','',''),
(103,'被芯2',34,0,NULL,0,NULL,1,'','',''),
(104,'保护垫1',35,0,NULL,0,NULL,1,'','',''),
(105,'保护垫2',35,0,NULL,0,NULL,1,'','',''),
(106,'床垫1',36,0,NULL,0,NULL,1,'','',''),
(107,'床垫2',36,0,NULL,0,NULL,1,'','',''),
(108,'服饰浴袍1',37,0,NULL,0,NULL,1,'','',''),
(109,'服饰浴袍2',37,0,NULL,0,NULL,1,'','',''),
(110,'梳子3',3,0,NULL,13,'blob:http://localhost:8080/34eab9d3-d0de-4d51-baec-d42744d7f969',1,'','','梳子3介绍'),
(111,'梳子4',1,0,NULL,24,'upload/d26aa776-f640-4047-9a25-e37b01ea2d83.png',1,'','','梳子介绍4');

/*Table structure for table `productcategory` */

DROP TABLE IF EXISTS `productcategory`;

CREATE TABLE `productcategory` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `productcategory` */

insert  into `productcategory`(`id`,`name`,`remarks`) values 
(2,'有偿用品','有偿用品2'),
(3,'布草','布草2'),
(4,'易耗品','易耗2');

/*Table structure for table `producttype` */

DROP TABLE IF EXISTS `producttype`;

CREATE TABLE `producttype` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `categoryid` int(20) NOT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `categoryid_id` (`categoryid`)
) ENGINE=MyISAM AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;

/*Data for the table `producttype` */

insert  into `producttype`(`id`,`name`,`categoryid`,`remarks`) values 
(1,'牙具',4,'牙具描述'),
(2,'香皂',4,'香皂描述'),
(3,'梳子',4,'梳子描述'),
(4,'办公用品',2,'办公用品描述'),
(5,'保洁用品',2,'保洁用品描述'),
(6,'浴巾',3,'浴巾描述'),
(7,'床单',3,'床单描述'),
(8,'洗发水',4,'洗发水描述'),
(9,'沐浴露',4,'沐浴露描述'),
(10,'浴帽',4,'浴帽描述'),
(11,'拖鞋',4,'拖鞋描述'),
(12,'水杯',4,'水杯描述'),
(13,'垃圾袋',4,'垃圾袋描述'),
(14,'个人护理',4,'个人护理描述'),
(15,'纸品',4,'纸品描述'),
(16,'有偿用品',2,'有偿用品描述'),
(17,'小家电',2,'小家电描述'),
(18,'标牌',2,'标牌描述'),
(19,'餐饮用品',2,'餐饮用品描述'),
(20,'生活百货',2,'生活百货描述'),
(21,'大家电',2,'大家电描述'),
(22,'拍照服务',2,'拍照服务描述'),
(23,'食品饮料',2,'食品饮料描述'),
(24,'公明收益',2,'公明收益描述'),
(25,'美酒周边',2,'美酒周边描述'),
(26,'瓷砖卫浴',2,'瓷砖卫浴描述'),
(27,'五金',2,'五金描述'),
(28,'智能设备',2,'智能设备描述'),
(29,'被套',3,'被套描述'),
(30,'枕套',3,'枕套描述'),
(31,'面巾',3,'面巾描述'),
(32,'方巾',3,'方巾描述'),
(33,'地巾',3,'地巾描述'),
(34,'被芯',3,'被芯描述'),
(35,'保护垫',3,'保护垫描述'),
(36,'床垫',3,'床垫描述'),
(37,'服饰浴袍',3,'服饰浴袍描述');

/*Table structure for table `t_function` */

DROP TABLE IF EXISTS `t_function`;

CREATE TABLE `t_function` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `parentid` int(10) NOT NULL,
  `orderidx` int(4) NOT NULL DEFAULT '0',
  `default_ico` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `focus_ico` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `used_module` int(1) NOT NULL DEFAULT '1',
  `public_module` int(1) NOT NULL DEFAULT '0',
  `module_type` int(1) NOT NULL DEFAULT '1',
  `url` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_function_parentid` (`parentid`)
) ENGINE=MyISAM AUTO_INCREMENT=80023 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `t_function` */

insert  into `t_function`(`id`,`name`,`parentid`,`orderidx`,`default_ico`,`focus_ico`,`used_module`,`public_module`,`module_type`,`url`) values 
(1,'领导查询',0,1,'leftico01.png','icon01.png',1,0,1,'notice/tonoticeDetail.do'),
(2,'行业审计',0,2,'leftico02.png','icon02.png',1,0,1,'audit/index.do'),
(3,'疑点管理',0,3,'leftico03.png','icon03.png',1,0,1,'doubtManager/index.do'),
(4,'SQL编辑',0,4,'leftico04.png','icon04.png',1,0,1,'sqlEdit/index.do'),
(5,'数据管理',0,5,'leftico04.png','icon05.png',1,0,1,'dataSource/index.do'),
(6,'系统管理',0,6,'leftico04.png','icon06.png',1,0,1,'department/index.do'),
(7,'后台管理',0,7,'leftico04.png','',1,0,1,NULL),
(11,'总体情况',1,11,NULL,NULL,1,0,1,'notice/tonoticeDetail.do'),
(21,'行业分类',2,21,NULL,NULL,1,0,1,'audit/index.do'),
(31,'疑点管理',3,31,NULL,NULL,1,0,1,'doubtManager/index.do'),
(41,'SQL分析',4,41,NULL,NULL,1,0,1,'sqlEdit/index.do'),
(51,'数源管理',5,51,NULL,NULL,1,0,1,'dataSource/index.do'),
(61,'组织管理',6,61,NULL,NULL,1,0,1,'department/index.do'),
(62,'角色管理',6,62,NULL,NULL,1,0,1,'role/index.do'),
(71,'领导管理',7,71,NULL,NULL,1,0,1,'notice/index.do'),
(72,'日志管理',7,72,NULL,NULL,1,0,1,'log/index.do');

/*Table structure for table `t_log_info` */

DROP TABLE IF EXISTS `t_log_info`;

CREATE TABLE `t_log_info` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL COMMENT '用户ID',
  `username` varchar(256) COLLATE utf8_bin NOT NULL COMMENT '用户姓名',
  `usertelephone` varchar(256) COLLATE utf8_bin DEFAULT NULL COMMENT '用户手机号码',
  `logaction` varchar(250) COLLATE utf8_bin DEFAULT NULL COMMENT '用户操作内容【多级间用:分开】',
  `logtime` datetime NOT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `t_log_info` */

/*Table structure for table `t_order` */

DROP TABLE IF EXISTS `t_order`;

CREATE TABLE `t_order` (
  `order_id` bigint(20) NOT NULL COMMENT '订单id',
  `client_id` int(11) DEFAULT NULL COMMENT '用户ID',
  `client_name` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '用户名称',
  `client_chinesename` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `receiver_mobile` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '收货人手机',
  `receiver_area_name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '收货人地区名称(省，市，县)街道',
  `payment` decimal(20,2) unsigned zerofill DEFAULT '000000000000000000.00' COMMENT '实付金额。精确到2位小数;单位:元。如:200.07，表示:200元7分',
  `status` varchar(20) COLLATE utf8_bin DEFAULT '初始生成' COMMENT '状态：1、初始生成，2、提交商家，3、未付款，4、已付款，5、未发货，6、已发货，7、交易成功，8、交易关闭, 9、待评价',
  `create_time` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '订单创建时间',
  `update_time` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '订单更新时间',
  `payment_time` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '付款时间',
  `consign_time` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '发货时间',
  `end_time` varchar(255) COLLATE utf8_bin DEFAULT '未完成' COMMENT '交易完成时间',
  `close_time` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '交易关闭时间',
  `shipping_name` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '物流名称',
  `shipping_code` int(20) DEFAULT NULL COMMENT '物流单号',
  `buyer_message` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '买家留言',
  `buyer_nick` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '买家昵称',
  `buyer_rate` varchar(2) COLLATE utf8_bin DEFAULT NULL COMMENT '买家是否已经评价',
  `receiver_zip_code` varchar(15) COLLATE utf8_bin DEFAULT NULL COMMENT '收货人邮编',
  `receiver` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '收货人',
  `expire` varchar(0) COLLATE utf8_bin DEFAULT NULL COMMENT '过期时间，定期清理',
  `invoice_type` varchar(1) COLLATE utf8_bin DEFAULT NULL COMMENT '发票类型(普通发票，电子发票，增值税发票)',
  `source_type` varchar(1) COLLATE utf8_bin DEFAULT NULL COMMENT '订单来源：1:app端，2：pc端，3：M端，4：微信端，5：手机qq端',
  `seller_id` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '商家ID',
  `payment_type` varchar(20) COLLATE utf8_bin DEFAULT '在线支付' COMMENT '支付类型，1、在线支付，2、货到付款',
  `post_fee` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '邮费。精确到2位小数;单位:元。如:200.07，表示:200元7分',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`order_id`),
  KEY `create_time` (`create_time`),
  KEY `buyer_nick` (`buyer_nick`),
  KEY `status` (`status`),
  KEY `payment_type` (`payment_type`),
  KEY `userid_id` (`client_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `t_order` */

insert  into `t_order`(`order_id`,`client_id`,`client_name`,`client_chinesename`,`receiver_mobile`,`receiver_area_name`,`payment`,`status`,`create_time`,`update_time`,`payment_time`,`consign_time`,`end_time`,`close_time`,`shipping_name`,`shipping_code`,`buyer_message`,`buyer_nick`,`buyer_rate`,`receiver_zip_code`,`receiver`,`expire`,`invoice_type`,`source_type`,`seller_id`,`payment_type`,`post_fee`,`remarks`) values 
(1548927368727,1,'jialefu','家乐福','123456','天府大道华阳店',000000000000000000.00,'初始生成','2019-01-31 17:36:08',NULL,'未付款','未发货','未完成',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'在线支付',NULL,''),
(1548927456632,5,'shanyang','山羊','18080456985','asdf',000000000000000000.00,'初始生成','2019-01-31 17:37:36',NULL,'未付款','未发货','未完成',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'在线支付',NULL,''),
(1548927598935,4,'sujin_123','苏进','13981816942','阿道夫',000000000000000000.00,'初始生成','2019-01-31 17:39:58',NULL,'未付款','未发货','未完成',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'在线支付',NULL,''),
(1548927891670,3,'oushang','欧尚','4124','艾弗森',000000000000000000.00,'初始生成','2019-01-31 17:44:51',NULL,'未付款','未发货','未完成',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'在线支付',NULL,''),
(1548928234975,5,'shanyang','山羊','18080456985','asdf',000000000000000000.00,'未付款','2019-01-31 17:50:34',NULL,'未完成','未发货','未完成',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'在线支付',NULL,'');

/*Table structure for table `t_ordergoods` */

DROP TABLE IF EXISTS `t_ordergoods`;

CREATE TABLE `t_ordergoods` (
  `orderid` bigint(20) NOT NULL,
  `goodsid` int(11) NOT NULL,
  `goodsname` varchar(255) DEFAULT NULL,
  `goodsnumber` int(11) DEFAULT NULL COMMENT '商品购买数量',
  `price` decimal(10,0) DEFAULT NULL COMMENT '商品单价',
  `goodsfee` decimal(10,0) DEFAULT NULL COMMENT '该商品总金额',
  `picture` varchar(255) DEFAULT NULL,
  `totalfee` decimal(10,0) DEFAULT NULL COMMENT '订单总金额',
  `remarks` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`orderid`,`goodsid`),
  KEY `goodsid_id` (`goodsid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `t_ordergoods` */

insert  into `t_ordergoods`(`orderid`,`goodsid`,`goodsname`,`goodsnumber`,`price`,`goodsfee`,`picture`,`totalfee`,`remarks`) values 
(1548927891670,110,'梳子3',1,13,13,'blob:http://localhost:8080/34eab9d3-d0de-4d51-baec-d42744d7f969',NULL,NULL),
(1548484362966,7,'得力',2,20,40,'得力iocn',NULL,NULL),
(1548484362966,12,'南棉',4,30,120,'南棉icon',NULL,NULL),
(1548927891670,109,'服饰浴袍2',1,0,0,NULL,NULL,NULL),
(1548928234975,40,'梳子1',1,0,0,NULL,NULL,NULL),
(1548928234975,111,'梳子4',1,24,24,'upload/d26aa776-f640-4047-9a25-e37b01ea2d83.png',NULL,NULL);

/*Table structure for table `t_role` */

DROP TABLE IF EXISTS `t_role`;

CREATE TABLE `t_role` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '',
  `role_desc` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `create_time` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `t_role` */

insert  into `t_role`(`id`,`name`,`role_desc`,`create_time`) values 
(1,'系统管理员','系统管理员描述','2015-09-06');

/*Table structure for table `t_role_function` */

DROP TABLE IF EXISTS `t_role_function`;

CREATE TABLE `t_role_function` (
  `role_id` int(10) NOT NULL,
  `function_id` int(10) NOT NULL,
  `permission` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`role_id`,`function_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `t_role_function` */

insert  into `t_role_function`(`role_id`,`function_id`,`permission`) values 
(1,11,'1111'),
(1,21,'1111'),
(1,31,'1111'),
(1,41,'1111'),
(1,51,'1111'),
(1,61,'1111'),
(1,62,'1111'),
(1,71,'1111'),
(1,72,'1111');

/*Table structure for table `t_role_user` */

DROP TABLE IF EXISTS `t_role_user`;

CREATE TABLE `t_role_user` (
  `role_id` int(10) NOT NULL,
  `user_id` int(10) NOT NULL,
  PRIMARY KEY (`role_id`,`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `t_role_user` */

insert  into `t_role_user`(`role_id`,`user_id`) values 
(1,1);

/*Table structure for table `t_user` */

DROP TABLE IF EXISTS `t_user`;

CREATE TABLE `t_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) DEFAULT NULL COMMENT 'admin',
  `user_password` varchar(255) DEFAULT NULL COMMENT 'admin',
  `user_email` varchar(255) DEFAULT NULL,
  `user_tel` varchar(11) DEFAULT NULL,
  `articles` int(11) DEFAULT NULL,
  `videos` int(11) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `info` varchar(255) DEFAULT NULL COMMENT '大家好',
  `user_pic` varchar(255) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  `miss_number` int(11) DEFAULT '0',
  `miss_time` varchar(255) DEFAULT NULL COMMENT '最新的登录时间',
  `allow_time` varchar(255) DEFAULT NULL COMMENT '允许登录的时间',
  PRIMARY KEY (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `t_user` */

insert  into `t_user`(`user_id`,`user_name`,`user_password`,`user_email`,`user_tel`,`articles`,`videos`,`avatar`,`info`,`user_pic`,`role_id`,`miss_number`,`miss_time`,`allow_time`) values 
(1,'admin','a',NULL,NULL,NULL,NULL,NULL,'管理员',NULL,NULL,0,NULL,NULL),
(2,'guest','guest',NULL,NULL,NULL,NULL,NULL,'访客',NULL,NULL,0,NULL,NULL),
(3,'client','client',NULL,NULL,NULL,NULL,NULL,'客户',NULL,NULL,0,NULL,NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
