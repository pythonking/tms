/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50562
Source Host           : localhost:3306
Source Database       : piao2017

Target Server Type    : MYSQL
Target Server Version : 50562
File Encoding         : 65001

Date: 2018-12-17 16:49:38
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for account
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
  `id` int(11) NOT NULL,
  `account_name` varchar(64) DEFAULT NULL COMMENT '账号名称',
  `account_mobile` varchar(64) DEFAULT NULL COMMENT '账号手机号码，用于作为系统登录账号',
  `account_password` varchar(64) DEFAULT NULL COMMENT '登录密码，MD5加密',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '最后修改时间',
  `account_state` varchar(10) DEFAULT NULL COMMENT '账号状态：正常|禁用|锁定',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for account_login_log
-- ----------------------------
DROP TABLE IF EXISTS `account_login_log`;
CREATE TABLE `account_login_log` (
  `id` bigint(20) NOT NULL,
  `login_ip` varchar(64) DEFAULT NULL COMMENT '登录的IP地址',
  `login_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '登陆时间',
  `account_id` int(11) DEFAULT NULL COMMENT '登陆账户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for account_roles
-- ----------------------------
DROP TABLE IF EXISTS `account_roles`;
CREATE TABLE `account_roles` (
  `roles_id` int(4) DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `id` bigint(20) NOT NULL,
  `customer_name` varchar(64) DEFAULT NULL COMMENT '姓名',
  `customer_id_card` varchar(64) DEFAULT NULL COMMENT '身份证号',
  `customer_id_card_photo` varchar(64) DEFAULT NULL COMMENT '身份证正面照片',
  `customer_id_card_photo_back` varchar(64) DEFAULT NULL COMMENT '身份证背面照片',
  `customer_photo` varchar(64) DEFAULT NULL COMMENT '照片地址',
  `customer_tel` varchar(64) DEFAULT NULL COMMENT '联系电话',
  `customer_address` varchar(64) DEFAULT NULL COMMENT '住址',
  `ticket_id` bigint(20) DEFAULT NULL COMMENT '年票ID',
  `customer_age` int(4) DEFAULT NULL COMMENT '年龄',
  `customer_gender` varchar(4) DEFAULT NULL COMMENT '性别',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permission_name` varchar(64) DEFAULT NULL COMMENT '权限名称，例如 添加账号、查询库存',
  `permission_code` varchar(64) DEFAULT NULL COMMENT '权限代号，例如 add:account，query:store',
  `permission_type` varchar(64) DEFAULT NULL COMMENT '权限类型，菜单 | 按钮',
  `parent_id` int(11) DEFAULT NULL COMMENT '父ID',
  `url` varchar(100) DEFAULT NULL COMMENT '资源路径',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roles_name` varchar(64) DEFAULT NULL COMMENT '角色名称',
  `roles_code` varchar(64) DEFAULT NULL COMMENT '角色代号，例如 admin',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for roles_permission
-- ----------------------------
DROP TABLE IF EXISTS `roles_permission`;
CREATE TABLE `roles_permission` (
  `roles_id` int(11) NOT NULL DEFAULT '0',
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`roles_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for store_account
-- ----------------------------
DROP TABLE IF EXISTS `store_account`;
CREATE TABLE `store_account` (
  `id` int(11) NOT NULL,
  `store_account` varchar(64) DEFAULT NULL COMMENT '售票点登录账号',
  `store_password` varchar(64) DEFAULT NULL COMMENT '售票点密码',
  `store_state` varchar(32) DEFAULT NULL COMMENT '售票点状态',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for store_login_log
-- ----------------------------
DROP TABLE IF EXISTS `store_login_log`;
CREATE TABLE `store_login_log` (
  `id` bigint(32) NOT NULL,
  `login_ip` varchar(64) DEFAULT NULL COMMENT '登录的IP地址',
  `login_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `store_account_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tickets
-- ----------------------------
DROP TABLE IF EXISTS `tickets`;
CREATE TABLE `tickets` (
  `id` bigint(64) NOT NULL,
  `ticket_num` varchar(64) DEFAULT NULL COMMENT '年票号码',
  `ticket_in_time` timestamp NULL DEFAULT NULL COMMENT '入库时间',
  `ticket_state` varchar(255) DEFAULT NULL COMMENT '年票状态',
  `ticket_out_time` varchar(64) DEFAULT NULL COMMENT '年票出库(下发)时间',
  `store_account_id` int(11) DEFAULT NULL COMMENT '售票点ID',
  `ticket_validity_start` timestamp NULL DEFAULT NULL COMMENT '有效期起始时间',
  `ticket_validity_end` timestamp NULL DEFAULT NULL COMMENT '有效期截至时间',
  `customer_id` bigint(20) DEFAULT NULL COMMENT '顾客ID',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for ticket_in_record
-- ----------------------------
DROP TABLE IF EXISTS `ticket_in_record`;
CREATE TABLE `ticket_in_record` (
  `id` int(11) NOT NULL,
  `account_name` varchar(64) DEFAULT NULL COMMENT '创建人姓名',
  `content` varchar(255) DEFAULT NULL COMMENT '下发内容',
  `account_id` varchar(64) DEFAULT NULL,
  `begin_ticket_num` varchar(64) DEFAULT NULL COMMENT '起始票号',
  `end_ticket_num` varchar(64) DEFAULT NULL COMMENT '结束票号',
  `total_num` int(11) DEFAULT NULL COMMENT '本次入库数量',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for ticket_order
-- ----------------------------
DROP TABLE IF EXISTS `ticket_order`;
CREATE TABLE `ticket_order` (
  `id` bigint(20) NOT NULL,
  `ticket_order_num` varchar(32) DEFAULT NULL COMMENT '流水号',
  `ticket_order_price` decimal(10,4) DEFAULT NULL COMMENT '价格',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL,
  `ticket_id` bigint(32) DEFAULT NULL,
  `customer_id` bigint(32) DEFAULT NULL,
  `store_account_id` int(11) DEFAULT NULL,
  `ticket_order_type` varchar(32) DEFAULT NULL COMMENT '类型 新办|续费|补卡',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for ticket_out_record
-- ----------------------------
DROP TABLE IF EXISTS `ticket_out_record`;
CREATE TABLE `ticket_out_record` (
  `id` int(64) NOT NULL,
  `out_account_name` varchar(255) DEFAULT NULL COMMENT '下发人',
  `finance_account_name` varchar(255) DEFAULT NULL COMMENT '财务收款人',
  `content` varchar(255) DEFAULT NULL COMMENT '内容',
  `begin_ticket_num` varchar(32) DEFAULT NULL COMMENT '起始票号',
  `end_ticket_num` varchar(32) DEFAULT NULL COMMENT '结束票号',
  `total_num` int(11) DEFAULT NULL COMMENT '总数量',
  `price` decimal(10,4) DEFAULT NULL COMMENT '单张票价',
  `total_price` decimal(12,4) DEFAULT NULL COMMENT '总票价',
  `store_account_id` int(11) DEFAULT NULL COMMENT '下发售票点ID',
  `store_account_name` varchar(255) DEFAULT NULL COMMENT '下发的售票点名称',
  `out_account_id` int(11) DEFAULT NULL COMMENT '下发人ID',
  `finance_account_id` int(11) DEFAULT NULL COMMENT '收款人ID',
  `pay_type` varchar(32) DEFAULT NULL COMMENT '支付方式  现金 | 银行卡',
  `state` varchar(255) DEFAULT NULL COMMENT '状态 未支付|已支付',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for ticket_store
-- ----------------------------
DROP TABLE IF EXISTS `ticket_store`;
CREATE TABLE `ticket_store` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `store_name` varchar(644) DEFAULT NULL COMMENT '售票点名称',
  `store_manager` varchar(64) DEFAULT NULL COMMENT '售票点负责人',
  `store_tel` varchar(64) DEFAULT NULL COMMENT '联系电话',
  `store_address` varchar(64) DEFAULT NULL COMMENT '售票点地址',
  `store_geo_longitude` varchar(64) DEFAULT NULL COMMENT '售票点坐标_经度',
  `store_geo_latitude` varchar(64) DEFAULT NULL COMMENT '售票点坐标_纬度',
  `store_manager_attachment` varchar(64) DEFAULT NULL COMMENT '营业执照照片',
  `store_attachment` varchar(64) DEFAULT NULL COMMENT '负责人身份证照片',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
