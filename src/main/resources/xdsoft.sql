/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50041
Source Host           : localhost:3306
Source Database       : xdsoft

Target Server Type    : MYSQL
Target Server Version : 50041
File Encoding         : 65001

Date: 2016-04-06 14:15:06
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `active`
-- ----------------------------
DROP TABLE IF EXISTS `active`;
CREATE TABLE `active` (
  `id` int(11) NOT NULL,
  `active_name` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL default '0000-00-00 00:00:00' on update CURRENT_TIMESTAMP,
  `enddays` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of active
-- ----------------------------

-- ----------------------------
-- Table structure for `bonucount`
-- ----------------------------
DROP TABLE IF EXISTS `bonucount`;
CREATE TABLE `bonucount` (
  `id` int(11) NOT NULL auto_increment,
  `active_id` int(11) NOT NULL,
  `bonustotal` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bonucount
-- ----------------------------

-- ----------------------------
-- Table structure for `bonus_record`
-- ----------------------------
DROP TABLE IF EXISTS `bonus_record`;
CREATE TABLE `bonus_record` (
  `id` int(11) NOT NULL,
  `bonus_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `bonus_size` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL default '0000-00-00 00:00:00' on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bonus_record
-- ----------------------------

-- ----------------------------
-- Table structure for `orderlist`
-- ----------------------------
DROP TABLE IF EXISTS `orderlist`;
CREATE TABLE `orderlist` (
  `id` int(11) NOT NULL auto_increment,
  `ordernum_id` int(11) NOT NULL,
  `tempuser_address_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `paystate` int(11) default NULL,
  `paytimestamp` varchar(255) default NULL,
  `bonus` varchar(255) NOT NULL,
  `payment` varchar(255) NOT NULL,
  `timestamp` timestamp NOT NULL default '0000-00-00 00:00:00' on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of orderlist
-- ----------------------------

-- ----------------------------
-- Table structure for `printinfo`
-- ----------------------------
DROP TABLE IF EXISTS `printinfo`;
CREATE TABLE `printinfo` (
  `id` int(11) NOT NULL auto_increment,
  `tempfile_id` int(11) NOT NULL,
  `filepages` int(11) NOT NULL,
  `option1` int(11) NOT NULL,
  `option2` int(11) NOT NULL,
  `copies` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL default '0000-00-00 00:00:00' on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of printinfo
-- ----------------------------

-- ----------------------------
-- Table structure for `randordernum`
-- ----------------------------
DROP TABLE IF EXISTS `randordernum`;
CREATE TABLE `randordernum` (
  `id` int(11) NOT NULL auto_increment,
  `ordernum` varchar(255) NOT NULL,
  `timestamp` timestamp NOT NULL default '0000-00-00 00:00:00' on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of randordernum
-- ----------------------------

-- ----------------------------
-- Table structure for `reguser_address`
-- ----------------------------
DROP TABLE IF EXISTS `reguser_address`;
CREATE TABLE `reguser_address` (
  `id` int(11) NOT NULL auto_increment,
  `ordernum_id` int(11) NOT NULL,
  `user_address_id` int(11) NOT NULL,
  `sendtime` int(11) NOT NULL,
  `order_state` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL default '0000-00-00 00:00:00' on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of reguser_address
-- ----------------------------

-- ----------------------------
-- Table structure for `tempfile`
-- ----------------------------
DROP TABLE IF EXISTS `tempfile`;
CREATE TABLE `tempfile` (
  `id` int(11) NOT NULL auto_increment,
  `ordernum_id` int(11) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `tempfilelocal` varchar(255) NOT NULL,
  `timestamp` timestamp NOT NULL default '0000-00-00 00:00:00' on update CURRENT_TIMESTAMP,
  `fileunique` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tempfile
-- ----------------------------

-- ----------------------------
-- Table structure for `tempuser_address`
-- ----------------------------
DROP TABLE IF EXISTS `tempuser_address`;
CREATE TABLE `tempuser_address` (
  `id` int(11) NOT NULL auto_increment,
  `ordernum_id` int(11) NOT NULL,
  `recieve_name` varchar(255) NOT NULL,
  `tel` varchar(255) NOT NULL,
  `address_info_id` int(11) NOT NULL,
  `sendtime` int(11) NOT NULL,
  `use_state` int(11) NOT NULL,
  `dorm` varchar(255) NOT NULL,
  `timestamp` timestamp NOT NULL default '0000-00-00 00:00:00' on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tempuser_address
-- ----------------------------

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL auto_increment,
  `email` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `salt` varchar(255) NOT NULL,
  `avatar` varchar(255) default NULL,
  `sq` varchar(255) default NULL,
  `answer` varchar(255) default NULL,
  `nickname` varchar(255) default NULL,
  `joinat` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `lastlogin` timestamp NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('10000', '648269794@qq.com', 'weiwei', 'WWlDXPa8yikk0FSOHjMiajVCEyk=', 'PvVU/WbvZe4=', null, null, null, null, '2016-04-06 13:36:09', '0000-00-00 00:00:00');

-- ----------------------------
-- Table structure for `user_address`
-- ----------------------------
DROP TABLE IF EXISTS `user_address`;
CREATE TABLE `user_address` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `recieve_name` varchar(255) NOT NULL,
  `address_info_id` int(11) NOT NULL,
  `dorm` varchar(255) NOT NULL,
  `tel` varchar(255) NOT NULL,
  `state` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL default '0000-00-00 00:00:00' on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_address
-- ----------------------------

-- ----------------------------
-- Table structure for `user_author`
-- ----------------------------
DROP TABLE IF EXISTS `user_author`;
CREATE TABLE `user_author` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `author` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL default '0000-00-00 00:00:00' on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_author
-- ----------------------------

-- ----------------------------
-- Table structure for `user_config`
-- ----------------------------
DROP TABLE IF EXISTS `user_config`;
CREATE TABLE `user_config` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `qq_visual` int(11) default NULL,
  `tel_visual` int(11) default NULL,
  `timestamp` timestamp NOT NULL default '0000-00-00 00:00:00' on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_config
-- ----------------------------

-- ----------------------------
-- Table structure for `user_extend`
-- ----------------------------
DROP TABLE IF EXISTS `user_extend`;
CREATE TABLE `user_extend` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `invite` varchar(255) default NULL,
  `signature` varchar(255) default NULL,
  `hobby` varchar(255) default NULL,
  `qq` varchar(255) default NULL,
  `tel` varchar(255) default NULL,
  `sex` varchar(255) default NULL,
  `level` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_extend
-- ----------------------------
