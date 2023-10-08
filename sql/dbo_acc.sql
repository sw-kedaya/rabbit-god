/*
 Navicat Premium Data Transfer

 Source Server         : longzhu
 Source Server Type    : MySQL
 Source Server Version : 80012
 Source Host           : localhost:3306
 Source Schema         : dbo_acc

 Target Server Type    : MySQL
 Target Server Version : 80012
 File Encoding         : 65001

 Date: 19/09/2023 21:01:28
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for accounts
-- ----------------------------
DROP TABLE IF EXISTS `accounts`;
CREATE TABLE `accounts`  (
  `AccountID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Username` varchar(16) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Password_hash` varchar(32) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL COMMENT 'password in md5',
  `acc_status` enum('pending','block','active','temporary') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'active',
  `email` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'test@mail.com',
  `mallpoints` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `reg_date` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  `last_login` timestamp(0) NULL DEFAULT NULL,
  `reg_ip` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `admin` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'value from 0 to 10',
  `isGm` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 = normal user / 1 = game master or people with who can login in testing phase',
  `lastServerFarmId` tinyint(3) UNSIGNED NOT NULL DEFAULT 255 COMMENT 'default: INVALID_SERVERFARMID ( 255 )',
  `founder` smallint(6) NOT NULL DEFAULT 0 COMMENT '0 = no founder / 1 = first founder / 2 = second / 3 = third',
  `founder_recv` smallint(6) NOT NULL DEFAULT 0 COMMENT '0 = founder not received / 1 = founder received',
  `last_ip` varchar(16) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '0.0.0.0',
  `del_char_pw` varchar(32) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'e165421110ba03099a1c0393373c5b43',
  `PremiumSlots` tinyint(3) UNSIGNED NOT NULL DEFAULT 4,
  `EventCoins` int(10) UNSIGNED NULL DEFAULT 0 COMMENT 'coins used to play on HLS event machine',
  `WaguCoins` int(10) UNSIGNED NULL DEFAULT 0 COMMENT 'coins used to play on HLS slot machine',
  `web_ip` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `BansCount` smallint(5) UNSIGNED NULL DEFAULT 0,
  `bans_end` bigint(20) UNSIGNED NULL DEFAULT 0,
  `bz` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `NewPlayer` tinyint(3) UNSIGNED NULL DEFAULT 0 COMMENT '0=新玩家 1=有角色出师',
  `firstCharID` int(10) UNSIGNED NULL DEFAULT 0,
  PRIMARY KEY (`AccountID`, `Username`) USING BTREE,
  UNIQUE INDEX `AccountID`(`AccountID`) USING BTREE,
  UNIQUE INDEX `Username`(`Username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of accounts
-- ----------------------------

-- ----------------------------
-- Table structure for accounts_banned
-- ----------------------------
DROP TABLE IF EXISTS `accounts_banned`;
CREATE TABLE `accounts_banned`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `GM_AccId` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `Banned_AccId` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `DateTime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  `Reason` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Duration` tinyint(3) UNSIGNED NOT NULL DEFAULT 1 COMMENT 'Value in days. 255 = permanent',
  `Active` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1 = true, 0 = false',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 661 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of accounts_banned
-- ----------------------------

-- ----------------------------
-- Table structure for cash_key
-- ----------------------------
DROP TABLE IF EXISTS `cash_key`;
CREATE TABLE `cash_key`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `cd_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `cash` int(10) UNSIGNED NULL DEFAULT 0,
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `use_time` datetime(0) NULL DEFAULT NULL,
  `account_id` int(10) UNSIGNED NULL DEFAULT 0,
  PRIMARY KEY (`id`, `cd_key`) USING BTREE,
  UNIQUE INDEX `key`(`cd_key`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4310 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cash_key
-- ----------------------------

-- ----------------------------
-- Table structure for cash_order
-- ----------------------------
DROP TABLE IF EXISTS `cash_order`;
CREATE TABLE `cash_order`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cash` int(11) NULL DEFAULT NULL,
  `price` int(11) NULL DEFAULT NULL,
  `AccountID` int(11) NULL DEFAULT NULL,
  `order_timestamp` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `alipay_trade_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cash_order
-- ----------------------------

-- ----------------------------
-- Table structure for cashshop_storage
-- ----------------------------
DROP TABLE IF EXISTS `cashshop_storage`;
CREATE TABLE `cashshop_storage`  (
  `ProductId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `AccountID` int(10) UNSIGNED NOT NULL,
  `HLSitemTblidx` int(10) UNSIGNED NOT NULL,
  `StackCount` tinyint(3) UNSIGNED NOT NULL,
  `giftCharId` int(10) UNSIGNED NULL DEFAULT NULL,
  `IsRead` tinyint(1) NOT NULL DEFAULT 0,
  `SenderName` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `year` int(10) UNSIGNED NOT NULL,
  `month` tinyint(3) UNSIGNED NOT NULL,
  `day` tinyint(3) UNSIGNED NOT NULL,
  `hour` tinyint(3) UNSIGNED NOT NULL,
  `minute` tinyint(3) UNSIGNED NOT NULL,
  `second` tinyint(3) UNSIGNED NOT NULL,
  `millisecond` int(10) UNSIGNED NOT NULL,
  `isMoved` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'BOOL. Did the player move the item to his inventory',
  `Buyer` int(10) UNSIGNED NULL DEFAULT 0 COMMENT 'account id from the buyer',
  `price` int(10) UNSIGNED NULL DEFAULT 0,
  `ItemID` bigint(20) UNSIGNED NULL DEFAULT 0,
  `byRank` tinyint(4) NULL DEFAULT 0,
  PRIMARY KEY (`ProductId`) USING BTREE,
  UNIQUE INDEX `ProductId`(`ProductId`, `AccountID`) USING BTREE,
  INDEX `AccountID`(`AccountID`, `isMoved`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1202564 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cashshop_storage
-- ----------------------------

-- ----------------------------
-- Table structure for cdk
-- ----------------------------
DROP TABLE IF EXISTS `cdk`;
CREATE TABLE `cdk`  (
  `Isuse` tinyint(4) NOT NULL,
  `cdk` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `money` int(11) NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cdk
-- ----------------------------

-- ----------------------------
-- Table structure for client_version
-- ----------------------------
DROP TABLE IF EXISTS `client_version`;
CREATE TABLE `client_version`  (
  `version` int(11) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of client_version
-- ----------------------------

-- ----------------------------
-- Table structure for client_version_file
-- ----------------------------
DROP TABLE IF EXISTS `client_version_file`;
CREATE TABLE `client_version_file`  (
  `path` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `md5` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of client_version_file
-- ----------------------------

-- ----------------------------
-- Table structure for cumulative_log
-- ----------------------------
DROP TABLE IF EXISTS `cumulative_log`;
CREATE TABLE `cumulative_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `AccountID` int(11) NULL DEFAULT NULL,
  `CharID` int(11) NULL DEFAULT NULL,
  `CharName` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Days` tinyint(3) UNSIGNED NULL DEFAULT NULL,
  `itemid` int(11) NULL DEFAULT NULL,
  `time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11149 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cumulative_log
-- ----------------------------

-- ----------------------------
-- Table structure for event
-- ----------------------------
DROP TABLE IF EXISTS `event`;
CREATE TABLE `event`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `monday` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `tuesday` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `wednesday` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `thursday` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `friday` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `saturday` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `sunday` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of event
-- ----------------------------
INSERT INTO `event` VALUES (16, '武道会-成人个人', '', '19:55', '12:00', '19:55', '', '19:55', NULL);
INSERT INTO `event` VALUES (17, '武道会-少年个人', '19:55', '', '19:55', '', '', '', NULL);
INSERT INTO `event` VALUES (18, '武道会-成人团队', NULL, NULL, NULL, NULL, NULL, NULL, '21:00');
INSERT INTO `event` VALUES (19, '武道会-少年团队', NULL, NULL, NULL, NULL, NULL, NULL, '19:00');
INSERT INTO `event` VALUES (20, '世界BOSS', '12:00；21:00', '12:00；21:00', '12:00；21:00', '12:00；21:00', '12:00；21:00', '12:00；21:00', '12:00；21:00');
INSERT INTO `event` VALUES (21, '龙珠狩猎加成', '19:00-22:00', '19:00-22:00', '19:00-22:00', '19:00-22:00', '19:00-22:00', '19:00-22:00', '19:00-22:00');
INSERT INTO `event` VALUES (22, '龙珠争夺战', NULL, NULL, '', NULL, '21:00-22:30', '', NULL);
INSERT INTO `event` VALUES (24, '锦鲤活动', NULL, '全天', '', '全天', '', '', '全天');
INSERT INTO `event` VALUES (25, '西路二世活动', NULL, '全天', NULL, '全天', NULL, '', '全天');
INSERT INTO `event` VALUES (27, '蜜蜂活动', '全天', '', '全天', NULL, '', '全天', NULL);
INSERT INTO `event` VALUES (28, '波波的金库', '18:00-次日6:00', NULL, '12:00-24:00', NULL, '', '8:00-20:00', NULL);
INSERT INTO `event` VALUES (29, '道场争夺战', NULL, NULL, NULL, NULL, '19:00-22:00', NULL, NULL);
INSERT INTO `event` VALUES (99, '周末EXP活动', NULL, NULL, NULL, NULL, '全天', '全天', '全天');

-- ----------------------------
-- Table structure for event_reward
-- ----------------------------
DROP TABLE IF EXISTS `event_reward`;
CREATE TABLE `event_reward`  (
  `AccountID` int(10) UNSIGNED NULL DEFAULT NULL,
  `rewardTblidx` int(10) UNSIGNED NULL DEFAULT NULL,
  `CharID` int(10) UNSIGNED NULL DEFAULT 0,
  `CharName` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `er_date` date NOT NULL DEFAULT '3333-11-11',
  `er_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`er_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 87140 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of event_reward
-- ----------------------------

-- ----------------------------
-- Table structure for gift_content
-- ----------------------------
DROP TABLE IF EXISTS `gift_content`;
CREATE TABLE `gift_content`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `gift_ID` int(10) UNSIGNED NULL DEFAULT NULL,
  `tblidx` int(10) UNSIGNED NULL DEFAULT 4294967295,
  `byCount` tinyint(3) UNSIGNED NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 68 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gift_content
-- ----------------------------

-- ----------------------------
-- Table structure for gift_fast
-- ----------------------------
DROP TABLE IF EXISTS `gift_fast`;
CREATE TABLE `gift_fast`  (
  `gift_ID` int(10) UNSIGNED NOT NULL,
  `gift_Name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `gift_itemNumber` tinyint(3) UNSIGNED NULL DEFAULT 0,
  PRIMARY KEY (`gift_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gift_fast
-- ----------------------------

-- ----------------------------
-- Table structure for item_cdkey
-- ----------------------------
DROP TABLE IF EXISTS `item_cdkey`;
CREATE TABLE `item_cdkey`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `cd_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `gift_ID` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `item_number` tinyint(3) UNSIGNED NULL DEFAULT 1,
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `use_time` datetime(0) NULL DEFAULT NULL,
  `user_id` int(10) UNSIGNED NULL DEFAULT 0 COMMENT 'character id',
  `user_AccountID` int(10) UNSIGNED NULL DEFAULT 0,
  `tmEndTimes` bigint(20) UNSIGNED NULL DEFAULT 4294967295,
  `gift_type` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '0表示不限制次数，其他的表示尽可以使用一次',
  PRIMARY KEY (`id`, `cd_key`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1062 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of item_cdkey
-- ----------------------------

-- ----------------------------
-- Table structure for mall
-- ----------------------------
DROP TABLE IF EXISTS `mall`;
CREATE TABLE `mall`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mall_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `mall_desc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `cash` int(11) NULL DEFAULT NULL,
  `mall_type` int(11) NULL DEFAULT NULL,
  `del_flag` int(11) NULL DEFAULT NULL,
  `tblidx` int(10) UNSIGNED NULL DEFAULT NULL,
  `place` tinyint(3) UNSIGNED NULL DEFAULT NULL,
  `pos` tinyint(3) UNSIGNED NULL DEFAULT NULL,
  `count` tinyint(3) UNSIGNED NULL DEFAULT NULL,
  `rank` tinyint(4) NULL DEFAULT NULL,
  `durability` tinyint(3) UNSIGNED NULL DEFAULT NULL,
  `grade` tinyint(4) NULL DEFAULT NULL,
  `NeedToIdentify` tinyint(1) NULL DEFAULT NULL,
  `BattleAttribute` tinyint(3) UNSIGNED NULL DEFAULT NULL,
  `Maker` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `OptionTblidx` int(10) UNSIGNED NULL DEFAULT NULL,
  `OptionTblidx2` int(10) UNSIGNED NULL DEFAULT NULL,
  `OptionRandomId` smallint(5) UNSIGNED NULL DEFAULT NULL,
  `OptionRandomVal` int(10) UNSIGNED NULL DEFAULT NULL,
  `OptionRandomId2` smallint(5) UNSIGNED NULL DEFAULT NULL,
  `OptionRandomVal2` int(10) UNSIGNED NULL DEFAULT NULL,
  `OptionRandomId3` smallint(5) UNSIGNED NULL DEFAULT NULL,
  `OptionRandomVal3` int(10) UNSIGNED NULL DEFAULT NULL,
  `OptionRandomId4` smallint(5) UNSIGNED NULL DEFAULT NULL,
  `OptionRandomVal4` int(10) UNSIGNED NULL DEFAULT NULL,
  `OptionRandomId5` smallint(5) UNSIGNED NULL DEFAULT NULL,
  `OptionRandomVal5` int(10) UNSIGNED NULL DEFAULT NULL,
  `OptionRandomId6` smallint(5) UNSIGNED NULL DEFAULT NULL,
  `OptionRandomVal6` int(10) UNSIGNED NULL DEFAULT NULL,
  `OptionRandomId7` smallint(5) UNSIGNED NULL DEFAULT NULL,
  `OptionRandomVal7` int(10) UNSIGNED NULL DEFAULT NULL,
  `OptionRandomId8` smallint(5) UNSIGNED NULL DEFAULT NULL,
  `OptionRandomVal8` int(10) UNSIGNED NULL DEFAULT NULL,
  `UseStartTime` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `UseEndTime` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `RestrictState` tinyint(3) UNSIGNED NULL DEFAULT NULL,
  `DurationType` tinyint(3) UNSIGNED NULL DEFAULT NULL,
  `sign_reward` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `mall_type`(`mall_type`) USING BTREE,
  INDEX `del_flag`(`del_flag`) USING BTREE,
  INDEX `sign_reward`(`sign_reward`) USING BTREE,
  FULLTEXT INDEX `mall_name`(`mall_name`) WITH PARSER `ngram`
) ENGINE = InnoDB AUTO_INCREMENT = 54 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mall
-- ----------------------------

-- ----------------------------
-- Table structure for mall_order
-- ----------------------------
DROP TABLE IF EXISTS `mall_order`;
CREATE TABLE `mall_order`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mall_id` int(11) NULL DEFAULT NULL,
  `mall_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `mall_desc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `cash` int(11) NULL DEFAULT NULL,
  `AccountID` int(11) NULL DEFAULT NULL,
  `CharID` int(11) NULL DEFAULT NULL,
  `CharName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `buy_time` datetime(0) NULL DEFAULT NULL,
  `status` int(11) NULL DEFAULT NULL,
  `tblidx` int(10) UNSIGNED NULL DEFAULT NULL,
  `place` tinyint(3) UNSIGNED NULL DEFAULT NULL,
  `pos` tinyint(3) UNSIGNED NULL DEFAULT NULL,
  `count` tinyint(3) UNSIGNED NULL DEFAULT NULL,
  `rank` tinyint(4) NULL DEFAULT NULL,
  `durability` tinyint(3) UNSIGNED NULL DEFAULT NULL,
  `grade` tinyint(4) NULL DEFAULT NULL,
  `NeedToIdentify` tinyint(1) NULL DEFAULT NULL,
  `BattleAttribute` tinyint(3) UNSIGNED NULL DEFAULT NULL,
  `Maker` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `OptionTblidx` int(10) UNSIGNED NULL DEFAULT NULL,
  `OptionTblidx2` int(10) UNSIGNED NULL DEFAULT NULL,
  `OptionRandomId` smallint(5) UNSIGNED NULL DEFAULT NULL,
  `OptionRandomVal` int(10) UNSIGNED NULL DEFAULT NULL,
  `OptionRandomId2` smallint(5) UNSIGNED NULL DEFAULT NULL,
  `OptionRandomVal2` int(10) UNSIGNED NULL DEFAULT NULL,
  `OptionRandomId3` smallint(5) UNSIGNED NULL DEFAULT NULL,
  `OptionRandomVal3` int(10) UNSIGNED NULL DEFAULT NULL,
  `OptionRandomId4` smallint(5) UNSIGNED NULL DEFAULT NULL,
  `OptionRandomVal4` int(10) UNSIGNED NULL DEFAULT NULL,
  `OptionRandomId5` smallint(5) UNSIGNED NULL DEFAULT NULL,
  `OptionRandomVal5` int(10) UNSIGNED NULL DEFAULT NULL,
  `OptionRandomId6` smallint(5) UNSIGNED NULL DEFAULT NULL,
  `OptionRandomVal6` int(10) UNSIGNED NULL DEFAULT NULL,
  `OptionRandomId7` smallint(5) UNSIGNED NULL DEFAULT NULL,
  `OptionRandomVal7` int(10) UNSIGNED NULL DEFAULT NULL,
  `OptionRandomId8` smallint(5) UNSIGNED NULL DEFAULT NULL,
  `OptionRandomVal8` int(10) UNSIGNED NULL DEFAULT NULL,
  `UseStartTime` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `UseEndTime` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `RestrictState` tinyint(3) UNSIGNED NULL DEFAULT NULL,
  `DurationType` tinyint(3) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 313 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mall_order
-- ----------------------------

-- ----------------------------
-- Table structure for mall_type
-- ----------------------------
DROP TABLE IF EXISTS `mall_type`;
CREATE TABLE `mall_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `sort` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mall_type
-- ----------------------------

-- ----------------------------
-- Table structure for shortcuts
-- ----------------------------
DROP TABLE IF EXISTS `shortcuts`;
CREATE TABLE `shortcuts`  (
  `AccountID` int(10) UNSIGNED NOT NULL,
  `ActionID` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `wKey` int(10) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`AccountID`, `ActionID`) USING BTREE,
  UNIQUE INDEX `AccountID`(`AccountID`, `ActionID`) USING BTREE,
  INDEX `AccountID_2`(`AccountID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shortcuts
-- ----------------------------

-- ----------------------------
-- Table structure for sign
-- ----------------------------
DROP TABLE IF EXISTS `sign`;
CREATE TABLE `sign`  (
  `AccountID` int(11) NOT NULL,
  `sign_date` date NOT NULL,
  `sign_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  `sign_itemid` int(11) NOT NULL,
  `CharID` int(10) UNSIGNED NULL DEFAULT 0,
  `CharName` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`AccountID`, `sign_date`) USING BTREE,
  INDEX `AccountID`(`AccountID`, `sign_date`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sign
-- ----------------------------

-- ----------------------------
-- Table structure for web_admin
-- ----------------------------
DROP TABLE IF EXISTS `web_admin`;
CREATE TABLE `web_admin`  (
  `Username` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Password` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`Username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of web_admin
-- ----------------------------

-- ----------------------------
-- Table structure for wp_shop
-- ----------------------------
DROP TABLE IF EXISTS `wp_shop`;
CREATE TABLE `wp_shop`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ServerChannelID` tinyint(3) UNSIGNED NULL DEFAULT 255 COMMENT '频道编号 255表示所有频道',
  `MerchantTab` tinyint(3) UNSIGNED NULL DEFAULT 255,
  `idxItemTbl` int(10) UNSIGNED NULL DEFAULT 0,
  `dwPrice` smallint(5) UNSIGNED NULL DEFAULT 0,
  `dwMinPrice` smallint(5) UNSIGNED NULL DEFAULT NULL,
  `dwInventory` smallint(5) UNSIGNED NULL DEFAULT 65535,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 52 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wp_shop
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
