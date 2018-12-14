/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50562
Source Host           : localhost:3306
Source Database       : piao2017

Target Server Type    : MYSQL
Target Server Version : 50562
File Encoding         : 65001

Date: 2018-12-14 16:25:40
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for account
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
  `id` int(32) NOT NULL,
  `account_name` varchar(64) DEFAULT NULL,
  `account_mobile` varchar(64) DEFAULT NULL,
  `account_password` varchar(64) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL,
  `account_state` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of account
-- ----------------------------

-- ----------------------------
-- Table structure for account_login_log
-- ----------------------------
DROP TABLE IF EXISTS `account_login_log`;
CREATE TABLE `account_login_log` (
  `id` int(11) NOT NULL,
  `login_ip` varchar(255) DEFAULT NULL,
  `login_time` datetime DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of account_login_log
-- ----------------------------

-- ----------------------------
-- Table structure for account_roles
-- ----------------------------
DROP TABLE IF EXISTS `account_roles`;
CREATE TABLE `account_roles` (
  `roles_id` int(4) DEFAULT NULL,
  `account_id` int(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of account_roles
-- ----------------------------

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `id` bigint(32) NOT NULL,
  `customer_name` varchar(64) DEFAULT NULL,
  `customer_id_card` varchar(64) DEFAULT NULL,
  `customer_id_card_photo` varchar(64) DEFAULT NULL,
  `customer_id_card_photo_back` varchar(64) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL,
  `customer_photo` varchar(64) DEFAULT NULL,
  `customer_tel` varchar(64) DEFAULT NULL,
  `customer_address` varchar(64) DEFAULT NULL,
  `ticket_id` bigint(20) DEFAULT NULL,
  `customer_age` int(11) DEFAULT NULL,
  `customer_gender` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of customer
-- ----------------------------

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permission_name` varchar(64) DEFAULT NULL,
  `permission_code` varchar(64) DEFAULT NULL,
  `permission_type` varchar(64) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT NULL,
  `url` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of permission
-- ----------------------------

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roles_name` varchar(64) DEFAULT NULL,
  `roles_code` varchar(64) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of roles
-- ----------------------------

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
-- Records of roles_permission
-- ----------------------------

-- ----------------------------
-- Table structure for store_account
-- ----------------------------
DROP TABLE IF EXISTS `store_account`;
CREATE TABLE `store_account` (
  `id` int(11) NOT NULL,
  `store_account` varchar(64) DEFAULT NULL,
  `store_password` varchar(64) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL,
  `store_state` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of store_account
-- ----------------------------

-- ----------------------------
-- Table structure for store_login_log
-- ----------------------------
DROP TABLE IF EXISTS `store_login_log`;
CREATE TABLE `store_login_log` (
  `id` bigint(32) NOT NULL,
  `login_ip` varchar(64) DEFAULT NULL,
  `login_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `store_account_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of store_login_log
-- ----------------------------

-- ----------------------------
-- Table structure for tickets
-- ----------------------------
DROP TABLE IF EXISTS `tickets`;
CREATE TABLE `tickets` (
  `id` bigint(64) NOT NULL,
  `ticket_num` varchar(64) DEFAULT NULL,
  `ticket_in_time` timestamp NULL DEFAULT NULL,
  `ticket_state` varchar(255) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL,
  `ticket_out_time` varchar(64) DEFAULT NULL,
  `store_account_id` int(11) DEFAULT NULL,
  `ticket_validity_start` timestamp NULL DEFAULT NULL,
  `ticket_validity_end` timestamp NULL DEFAULT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tickets
-- ----------------------------

-- ----------------------------
-- Table structure for ticket_in_record
-- ----------------------------
DROP TABLE IF EXISTS `ticket_in_record`;
CREATE TABLE `ticket_in_record` (
  `id` int(11) NOT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL,
  `account_name` varchar(64) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `account_id` varchar(64) DEFAULT NULL,
  `begin_ticket_num` varchar(64) DEFAULT NULL,
  `end_ticket_num` varchar(64) DEFAULT NULL,
  `total_num` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ticket_in_record
-- ----------------------------

-- ----------------------------
-- Table structure for ticket_order
-- ----------------------------
DROP TABLE IF EXISTS `ticket_order`;
CREATE TABLE `ticket_order` (
  `id` bigint(20) NOT NULL,
  `ticket_order_num` varchar(32) DEFAULT NULL,
  `ticket_order_price` decimal(10,4) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL,
  `ticket_id` bigint(32) DEFAULT NULL,
  `customer_id` bigint(32) DEFAULT NULL,
  `store_account_id` int(11) DEFAULT NULL,
  `ticket_order_type` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ticket_order
-- ----------------------------

-- ----------------------------
-- Table structure for ticket_out_record
-- ----------------------------
DROP TABLE IF EXISTS `ticket_out_record`;
CREATE TABLE `ticket_out_record` (
  `id` int(64) NOT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL,
  `out_account_name` varchar(255) DEFAULT NULL,
  `finance_account_name` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `begin_ticket_num` varchar(32) DEFAULT NULL,
  `end_ticket_num` varchar(32) DEFAULT NULL,
  `total_num` int(11) DEFAULT NULL,
  `price` decimal(10,4) DEFAULT NULL,
  `total_price` decimal(12,4) DEFAULT NULL,
  `store_account_name` varchar(255) DEFAULT NULL,
  `store_account_id` int(11) DEFAULT NULL,
  `out_account_id` int(11) DEFAULT NULL,
  `finance_account_id` int(11) DEFAULT NULL,
  `pay_type` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ticket_out_record
-- ----------------------------

-- ----------------------------
-- Table structure for ticket_store
-- ----------------------------
DROP TABLE IF EXISTS `ticket_store`;
CREATE TABLE `ticket_store` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `store_name` varchar(644) DEFAULT NULL,
  `store_manager` varchar(64) DEFAULT NULL,
  `store_tel` varchar(64) DEFAULT NULL,
  `store_address` varchar(64) DEFAULT NULL,
  `store_geo_longitude` varchar(64) DEFAULT NULL,
  `store_geo_latitude` varchar(64) DEFAULT NULL,
  `store_manager_attachment` varchar(64) DEFAULT NULL,
  `store_attachment` varchar(64) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ticket_store
-- ----------------------------
