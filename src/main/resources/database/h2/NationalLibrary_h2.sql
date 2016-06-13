/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50713
Source Host           : localhost:3306
Source Database       : nationallibrary

Target Server Type    : MYSQL
Target Server Version : 50713
File Encoding         : 65001

Date: 2016-06-13 17:21:56
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book` (
  `book_number` decimal(10,0) NOT NULL DEFAULT '0' COMMENT 'Book ID',
  `book_name` varchar(200) DEFAULT NULL COMMENT 'Book Name',
  `author` varchar(200) DEFAULT NULL COMMENT 'Author',
  `publisher` varchar(30) DEFAULT NULL COMMENT 'publisher',
  `publish_date` datetime DEFAULT NULL COMMENT 'publish_date',
  `price` varchar(20) DEFAULT NULL COMMENT 'price',
  `book_type` varchar(30) DEFAULT NULL,
  `store_location` varchar(30) DEFAULT NULL COMMENT 'store_location',
  `store_date` datetime DEFAULT NULL COMMENT 'store_date',
  `borrowed_number` int(11) DEFAULT NULL COMMENT 'borrowed_number',
  `number` int(11) DEFAULT NULL COMMENT 'number',
  PRIMARY KEY (`book_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES ('1236999', 'The  C Programming Language', 'Brian W. Kernighan Dennis M. Ritchie', 'Prentice Hall', '1988-05-08 18:04:38', '$48', 'Programming', 'A33', '2016-06-08 18:04:38', '1', '1');
INSERT INTO `book` VALUES ('1432042', 'Code Complete', 'Steve McConnell', 'Microsoft Press', '1988-05-08 18:04:38', '$49', 'Programming', 'C43', '2016-06-08 18:35:09', '1', '4');
INSERT INTO `book` VALUES ('1433399', 'Introduction to Algorithms', 'Thomas H. Cormen Charles E. Leiserson Ronald L. Rivest Clifford Stein', 'The MIT Press', '2001-10-08 18:53:19', '$85', 'Programming', 'X21', '2016-06-08 18:53:19', '1', '2');
INSERT INTO `book` VALUES ('1451622', 'Structure and Interpretation of Computer Programs - 2nd Edition (MIT)', 'Harold Abelson Gerald Jay Sussman', 'The MIT Press', '1996-08-08 18:08:29', '$145', 'Programming', 'B23', '2016-06-08 18:08:29', '0', '2');
INSERT INTO `book` VALUES ('1494210', 'Economics', 'Paul A. Samuelson William D. Nordhaus', 'McGraw Hill Higher Education', '2004-11-08 19:04:20', 'USD 88', 'Economics', 'W14', '2016-06-08 19:04:20', '1', '2');
INSERT INTO `book` VALUES ('1850263', 'Recent Developments in Growth Theory (International Library of Critical Writings in Economics)', 'Daron Acemoglu (EDT)', 'Edward Elgar Publishing', '2004-11-08 19:05:02', 'USD 655', 'Economics', 'W01', '2016-06-08 19:05:02', '0', '1');
INSERT INTO `book` VALUES ('1856488', 'Principles of Microeconomics', 'N. Gregory Mankiw', 'South-Western College Pub', '2006-02-08 19:03:30', 'CAD 169', 'Economics', 'W12', '2016-06-08 19:03:30', '0', '1');
INSERT INTO `book` VALUES ('1874839', 'Core Python Programming', 'Wesley J. Chun', 'Prentice Hall PTR', '2006-10-08 18:57:58', 'USD 49', 'Programming', 'A23', '2016-06-08 18:57:58', '1', '5');
INSERT INTO `book` VALUES ('2023370', 'Beautiful Code', 'Greg Wilson Andy Oram', 'O\'Reilly Media', '0008-04-08 18:55:36', '$44', 'Programming', 'A121', '2016-06-08 18:55:36', '1', '2');
INSERT INTO `book` VALUES ('2431476', 'Who\'s Looking Out for You?', 'Bill O\'Reilly', 'Broadway', '2003-10-10 19:52:57', 'USD 24', 'Life', 'Z43', '2016-06-10 19:52:57', '1', '4');
INSERT INTO `book` VALUES ('2922462', 'Dave Pelz\'s Short Game Bible', 'Pelz, Dave', 'Bantam Dell Pub Group', '1999-06-10 19:49:39', '239', 'Life', 'Z21', '2016-06-10 19:49:39', '0', '2');
INSERT INTO `book` VALUES ('3231284', 'Australian Language & Culture (Language Reference)', 'Paul Smitz Barry Blake', 'Lonely Planet', '2007-04-10 20:02:35', 'USD 8', 'Culture', 'B87', '2016-06-10 20:02:35', '1', '4');
INSERT INTO `book` VALUES ('3330098', 'Programming Applications for Microsoft Windows', 'Jeffrey Richter', 'Microsoft Press', '1999-10-23 14:03:26', '$86', 'Programming', 'A30', '2015-10-26 14:03:26', '1', '1');
INSERT INTO `book` VALUES ('6009858', 'Sleep Right, Sleep Tight', 'Tweddle Child; Family Health Service;', 'Family Health Service', '2006-10-10 19:55:42', '$ 20', '', 'D21', '2016-06-10 19:55:42', '0', '6');
INSERT INTO `book` VALUES ('6021272', 'API Design for C++', 'Martin Reddy', 'Morgan Kaufmann', '2011-03-08 19:01:56', 'USD 59', 'Programming', 'S65', '2016-06-08 19:01:56', '1', '2');
INSERT INTO `book` VALUES ('6752250', 'La Bella Figura', 'Severgnini, Beppe', 'Broadway Books', '2008-07-10 19:51:38', '102', 'Life', 'Z43', '2016-06-10 19:51:38', '0', '3');
INSERT INTO `book` VALUES ('6884314', 'Cooking class holiday recipes cookbook', 'Publications International Ltd', 'Publications International Ltd', '1994-02-10 19:54:27', '123', '', 'C21', '2016-06-10 19:54:27', '0', '2');
INSERT INTO `book` VALUES ('11418171', 'Medievalism and the Gothic in Australian Culture', 'Trigg, Stephanie', 'Trigg', '2000-06-10 20:01:31', '$ 98', 'Culture', 'V34', '2016-06-10 20:01:31', '0', '1');
INSERT INTO `book` VALUES ('16632655', 'A Guide to Australian Identity and Culture', 'Adele, Charlotte', 'Adele, Charlotte', '0171-07-10 20:03:23', '$65', 'Culture', 'K12', '2016-06-10 20:03:23', '0', '1');
INSERT INTO `book` VALUES ('20137275', 'Lonely Planet Australian Language & Culture', 'Lonely Planet', 'Lonely Planet', '2013-05-10 20:02:05', 'USD 8', 'Culture', 'F56', '2016-06-10 20:02:05', '0', '3');
INSERT INTO `book` VALUES ('26295140', 'CSS Secrets', 'Lea Verou', 'O\'Reilly Media', '2015-05-08 19:00:18', 'USD 39', 'Programming', 'Z32', '2016-06-08 19:00:18', '0', '1');

-- ----------------------------
-- Table structure for booktype
-- ----------------------------
DROP TABLE IF EXISTS `booktype`;
CREATE TABLE `booktype` (
  `type` varchar(255) NOT NULL COMMENT 'Type',
  `borrow_day` int(11) NOT NULL COMMENT 'borrow_day',
  `day_fine` decimal(10,0) DEFAULT NULL COMMENT 'day_fine',
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of booktype
-- ----------------------------
INSERT INTO `booktype` VALUES ('Culture ', '30', '1');
INSERT INTO `booktype` VALUES ('Economics', '30', '1');
INSERT INTO `booktype` VALUES ('Life', '30', '1');
INSERT INTO `booktype` VALUES ('Programming', '30', '1');

-- ----------------------------
-- Table structure for borrow
-- ----------------------------
DROP TABLE IF EXISTS `borrow`;
CREATE TABLE `borrow` (
  `patron_number` decimal(10,0) NOT NULL COMMENT 'patron_number',
  `book_number` decimal(10,0) NOT NULL COMMENT 'book_number',
  `patron_name` varchar(30) DEFAULT NULL COMMENT 'patron_name',
  `book_name` varchar(50) DEFAULT NULL COMMENT 'book_name',
  `return_date` datetime DEFAULT NULL COMMENT 'return_date',
  `borrowed_date` datetime DEFAULT NULL COMMENT 'borrowed_date',
  `fine` decimal(10,0) DEFAULT NULL COMMENT 'fine'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of borrow
-- ----------------------------
INSERT INTO `borrow` VALUES ('5', '1494210', 'Helen', 'Economics', null, '2016-06-10 19:11:08', null);
INSERT INTO `borrow` VALUES ('2', '6021272', 'Jerry', 'API Design for C++', null, '2016-06-10 19:12:00', null);
INSERT INTO `borrow` VALUES ('6', '1432042', 'liang', 'Code Complete', null, '2016-06-10 19:12:50', null);
INSERT INTO `borrow` VALUES ('2', '1236999', 'Jerry', 'The  C Programming Language', '2016-06-10 19:16:11', '2016-06-10 19:14:26', '0');
INSERT INTO `borrow` VALUES ('4', '1236999', 'Sam', 'The  C Programming Language', null, '2016-06-10 19:17:03', null);
INSERT INTO `borrow` VALUES ('5', '1433399', 'Helen', 'Introduction to Algorithms', null, '2016-06-10 19:17:52', null);
INSERT INTO `borrow` VALUES ('1', '1874839', 'Steven', 'Core Python Programming', null, '2016-06-10 19:18:09', null);
INSERT INTO `borrow` VALUES ('3', '2023370', 'Lisa', 'Beautiful Code', null, '2016-06-10 19:18:39', null);
INSERT INTO `borrow` VALUES ('6', '1874839', 'liang', 'Core Python Programming', '2016-06-13 11:55:32', '2016-06-10 19:18:58', '0');
INSERT INTO `borrow` VALUES ('2', '2431476', 'Jerry', 'Who\'s Looking Out for You?', null, '2016-06-10 20:04:06', null);
INSERT INTO `borrow` VALUES ('2', '3231284', 'Jerry', 'Australian Language & Culture (Language Reference)', null, '2016-06-10 20:04:24', null);

-- ----------------------------
-- Table structure for patron
-- ----------------------------
DROP TABLE IF EXISTS `patron`;
CREATE TABLE `patron` (
  `card_number` decimal(10,0) NOT NULL COMMENT 'card_number',
  `name` varchar(20) NOT NULL COMMENT 'name',
  `sex` varchar(10) NOT NULL COMMENT 'sex',
  `id_card_number` varchar(30) NOT NULL COMMENT 'id_card_number',
  `work_place` varchar(150) DEFAULT NULL COMMENT 'work_place',
  `address` varchar(150) DEFAULT NULL COMMENT 'address',
  `phone` varchar(30) DEFAULT NULL COMMENT 'phone',
  `type` varchar(30) NOT NULL COMMENT 'type',
  `create_time` datetime NOT NULL COMMENT 'create_time',
  `borrowed` int(11) DEFAULT '0' COMMENT 'borrowed',
  `is_lost` int(11) DEFAULT '0' COMMENT 'is_lost',
  PRIMARY KEY (`card_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of patron
-- ----------------------------
INSERT INTO `patron` VALUES ('1', 'Steven', 'Male', '4532186', 'Department of Human Services', '8 Chandler Street Belconnen ACT 2617', '0415425362', 'Member', '2016-06-08 15:05:30', '1', '0');
INSERT INTO `patron` VALUES ('2', 'Jerry', 'Male', '5431132', 'Australian Taxation Office', '430 Wilson St, Albury NSW 2640', '0432121323', 'Member', '2016-06-08 15:43:26', '3', '0');
INSERT INTO `patron` VALUES ('3', 'Lisa', 'Female', '4736282', 'Department of Veterans\' Affairs', 'Gnabra Building, 21 Genge Street, Civic', '0464327263', 'Member', '2016-06-08 15:43:38', '1', '0');
INSERT INTO `patron` VALUES ('4', 'Sam', 'Male', '5132465', 'Department of Immigration and Border Protection', '6 Chan St, Belconnen ACT 2617', '0456345987', 'Member', '2016-06-08 15:43:43', '1', '0');
INSERT INTO `patron` VALUES ('5', 'Helen', 'Female', '5647463', 'Australian Taxation Office', '430 Wilson St, Albury NSW 2640', '0421636352', 'Member', '2016-06-08 15:43:47', '2', '0');
INSERT INTO `patron` VALUES ('6', 'liang', 'Male', '53287163', 'Australian Bureau of Statistics', 'ABS House 45 Benjamin Way, Belconnen ACT 2617', '0488822481', 'Member', '2016-06-08 15:43:52', '1', '0');
INSERT INTO `patron` VALUES ('7', 'Nicholas', 'Male', '3456271', 'Department of Human Services', '8 Chandler Street Belconnen ACT 2617', '0447365348', 'Member', '2016-06-10 19:24:42', '0', '0');
INSERT INTO `patron` VALUES ('8', 'Anne', 'Female', '5647123', 'Australian Taxation Office', '430 Wilson St, Albury NSW 2640', '0687468123', 'Member', '2016-06-10 19:26:01', '0', '0');
INSERT INTO `patron` VALUES ('9', 'Chong', 'Female', '5674832', 'ATO', 'ATO', '0685743475', 'VIP', '2016-06-13 15:34:54', '0', '0');
INSERT INTO `patron` VALUES ('10', 'Leigh', 'Male', '7564243', 'ABS', 'ABS House 45 Benjamin Way, Belconnen ACT 2617', '8754098576', 'VIP', '2016-06-13 15:38:08', '0', '0');
INSERT INTO `patron` VALUES ('11', 'Michael', 'Male', '746436233', 'ABS', 'ABS House 45 Benjamin Way, Belconnen ACT 2617', '0987654567', 'Member', '2016-06-13 15:39:13', '0', '0');
INSERT INTO `patron` VALUES ('12', 'Ved', 'Male', '234523453', 'ABS', 'ABS', '0548643576', 'Member', '2016-06-13 16:03:59', '0', '0');
INSERT INTO `patron` VALUES ('13', 'sdsdfa', 'Male', '4352', 'adsf', 'adsfasf', '4352435', 'Member', '2016-06-13 16:07:08', '0', '0');
INSERT INTO `patron` VALUES ('17', 'dgdfgsdfg', 'Male', '23452345', 'ertretwet', 'gsdfgsdf', '34522345', 'Member', '2016-06-13 16:22:07', '0', '0');

-- ----------------------------
-- Table structure for patrontype
-- ----------------------------
DROP TABLE IF EXISTS `patrontype`;
CREATE TABLE `patrontype` (
  `type` varchar(20) NOT NULL COMMENT 'type',
  `borrow_number` int(11) NOT NULL COMMENT 'borrow_number',
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of patrontype
-- ----------------------------
INSERT INTO `patrontype` VALUES ('Member', '5');
INSERT INTO `patrontype` VALUES ('VIP', '10');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `is_admin` int(11) DEFAULT NULL COMMENT 'is_admin',
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('admin', 'admin', '1');
INSERT INTO `user` VALUES ('Josh', '123', '1');
INSERT INTO `user` VALUES ('liang', 'zhao', '1');
INSERT INTO `user` VALUES ('library', 'au', '1');
