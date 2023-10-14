/*
 Navicat Premium Data Transfer

 Source Server         : 本机
 Source Server Type    : MySQL
 Source Server Version : 80034 (8.0.34)
 Source Host           : localhost:3306
 Source Schema         : dbo_acc

 Target Server Type    : MySQL
 Target Server Version : 80034 (8.0.34)
 File Encoding         : 65001

 Date: 14/10/2023 10:51:35
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for accounts
-- ----------------------------
DROP TABLE IF EXISTS `accounts`;
CREATE TABLE `accounts`  (
  `AccountID` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `Username` varchar(16) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Password_hash` varchar(32) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL COMMENT 'password in md5',
  `acc_status` enum('pending','block','active','temporary') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'active',
  `email` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'test@mail.com',
  `mallpoints` int UNSIGNED NOT NULL DEFAULT 0,
  `reg_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_login` timestamp NULL DEFAULT NULL,
  `reg_ip` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `admin` tinyint NOT NULL DEFAULT 0 COMMENT 'value from 0 to 10',
  `isGm` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 = normal user / 1 = game master or people with who can login in testing phase',
  `lastServerFarmId` tinyint UNSIGNED NOT NULL DEFAULT 255 COMMENT 'default: INVALID_SERVERFARMID ( 255 )',
  `founder` smallint NOT NULL DEFAULT 0 COMMENT '0 = no founder / 1 = first founder / 2 = second / 3 = third',
  `founder_recv` smallint NOT NULL DEFAULT 0 COMMENT '0 = founder not received / 1 = founder received',
  `last_ip` varchar(16) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '0.0.0.0',
  `del_char_pw` varchar(32) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'e165421110ba03099a1c0393373c5b43',
  `PremiumSlots` tinyint UNSIGNED NOT NULL DEFAULT 4,
  `EventCoins` int UNSIGNED NULL DEFAULT 0 COMMENT 'coins used to play on HLS event machine',
  `WaguCoins` int UNSIGNED NULL DEFAULT 0 COMMENT 'coins used to play on HLS slot machine',
  `web_ip` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `BansCount` smallint UNSIGNED NULL DEFAULT 0,
  `bans_end` bigint UNSIGNED NULL DEFAULT 0,
  `bz` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `NewPlayer` tinyint UNSIGNED NULL DEFAULT 0 COMMENT '0=新玩家 1=有角色出师',
  `firstCharID` int UNSIGNED NULL DEFAULT 0,
  `replacement_card` tinyint NOT NULL DEFAULT 0 COMMENT '补签卡数量',
  `card_count_limit` tinyint NOT NULL DEFAULT 0 COMMENT '补签卡上限(限制最多3张)',
  PRIMARY KEY (`AccountID`, `Username`) USING BTREE,
  UNIQUE INDEX `AccountID`(`AccountID` ASC) USING BTREE,
  UNIQUE INDEX `Username`(`Username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for accounts_banned
-- ----------------------------
DROP TABLE IF EXISTS `accounts_banned`;
CREATE TABLE `accounts_banned`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `GM_AccId` int UNSIGNED NOT NULL DEFAULT 0,
  `Banned_AccId` int UNSIGNED NOT NULL DEFAULT 0,
  `DateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Reason` varchar(1024) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Duration` tinyint UNSIGNED NOT NULL DEFAULT 1 COMMENT 'Value in days. 255 = permanent',
  `Active` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1 = true, 0 = false',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cash_key
-- ----------------------------
DROP TABLE IF EXISTS `cash_key`;
CREATE TABLE `cash_key`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `cd_key` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `cash` int UNSIGNED NULL DEFAULT 0,
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `use_time` datetime NULL DEFAULT NULL,
  `account_id` int UNSIGNED NULL DEFAULT 0,
  PRIMARY KEY (`id`, `cd_key`) USING BTREE,
  UNIQUE INDEX `key`(`cd_key` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4331 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cash_order
-- ----------------------------
DROP TABLE IF EXISTS `cash_order`;
CREATE TABLE `cash_order`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `cash` int NULL DEFAULT NULL,
  `price` int NULL DEFAULT NULL,
  `AccountID` int NULL DEFAULT NULL,
  `order_timestamp` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `alipay_trade_no` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cashshop_storage
-- ----------------------------
DROP TABLE IF EXISTS `cashshop_storage`;
CREATE TABLE `cashshop_storage`  (
  `ProductId` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `AccountID` int UNSIGNED NOT NULL,
  `HLSitemTblidx` int UNSIGNED NOT NULL,
  `StackCount` tinyint UNSIGNED NOT NULL,
  `giftCharId` int UNSIGNED NULL DEFAULT NULL,
  `IsRead` tinyint(1) NOT NULL DEFAULT 0,
  `SenderName` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `year` int UNSIGNED NOT NULL,
  `month` tinyint UNSIGNED NOT NULL,
  `day` tinyint UNSIGNED NOT NULL,
  `hour` tinyint UNSIGNED NOT NULL,
  `minute` tinyint UNSIGNED NOT NULL,
  `second` tinyint UNSIGNED NOT NULL,
  `millisecond` int UNSIGNED NOT NULL,
  `isMoved` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'BOOL. Did the player move the item to his inventory',
  `Buyer` int UNSIGNED NULL DEFAULT 0 COMMENT 'account id from the buyer',
  `price` int UNSIGNED NULL DEFAULT 0,
  `ItemID` bigint UNSIGNED NULL DEFAULT 0,
  `byRank` tinyint NULL DEFAULT 0,
  PRIMARY KEY (`ProductId`) USING BTREE,
  UNIQUE INDEX `ProductId`(`ProductId` ASC, `AccountID` ASC) USING BTREE,
  INDEX `AccountID`(`AccountID` ASC, `isMoved` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cdk
-- ----------------------------
DROP TABLE IF EXISTS `cdk`;
CREATE TABLE `cdk`  (
  `Isuse` tinyint NOT NULL,
  `cdk` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `money` int NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for client_version
-- ----------------------------
DROP TABLE IF EXISTS `client_version`;
CREATE TABLE `client_version`  (
  `version` int NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for client_version_file
-- ----------------------------
DROP TABLE IF EXISTS `client_version_file`;
CREATE TABLE `client_version_file`  (
  `path` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL,
  `md5` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cumulative_log
-- ----------------------------
DROP TABLE IF EXISTS `cumulative_log`;
CREATE TABLE `cumulative_log`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `AccountID` int NULL DEFAULT NULL,
  `CharID` int NULL DEFAULT NULL,
  `CharName` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Days` tinyint UNSIGNED NULL DEFAULT NULL,
  `itemid` int NULL DEFAULT NULL,
  `time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for event
-- ----------------------------
DROP TABLE IF EXISTS `event`;
CREATE TABLE `event`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `event_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `monday` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `tuesday` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `wednesday` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `thursday` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `friday` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `saturday` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `sunday` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for event_reward
-- ----------------------------
DROP TABLE IF EXISTS `event_reward`;
CREATE TABLE `event_reward`  (
  `AccountID` int UNSIGNED NULL DEFAULT NULL,
  `rewardTblidx` int UNSIGNED NULL DEFAULT NULL,
  `CharID` int UNSIGNED NULL DEFAULT 0,
  `CharName` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `er_date` date NOT NULL DEFAULT '3333-11-11',
  `er_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`er_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for gift_content
-- ----------------------------
DROP TABLE IF EXISTS `gift_content`;
CREATE TABLE `gift_content`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `gift_ID` int UNSIGNED NULL DEFAULT NULL,
  `tblidx` int UNSIGNED NULL DEFAULT 4294967295,
  `byCount` tinyint UNSIGNED NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for gift_fast
-- ----------------------------
DROP TABLE IF EXISTS `gift_fast`;
CREATE TABLE `gift_fast`  (
  `gift_ID` int UNSIGNED NOT NULL,
  `gift_Name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `gift_itemNumber` tinyint UNSIGNED NULL DEFAULT 0,
  PRIMARY KEY (`gift_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for item_cdkey
-- ----------------------------
DROP TABLE IF EXISTS `item_cdkey`;
CREATE TABLE `item_cdkey`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `cd_key` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `gift_ID` int UNSIGNED NOT NULL DEFAULT 0,
  `item_number` tinyint UNSIGNED NULL DEFAULT 1,
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `use_time` datetime NULL DEFAULT NULL,
  `user_id` int UNSIGNED NULL DEFAULT 0 COMMENT 'character id',
  `user_AccountID` int UNSIGNED NULL DEFAULT 0,
  `tmEndTimes` bigint UNSIGNED NULL DEFAULT 4294967295,
  `gift_type` int UNSIGNED NULL DEFAULT 0 COMMENT '0表示不限制次数，其他的表示尽可以使用一次',
  PRIMARY KEY (`id`, `cd_key`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for mall
-- ----------------------------
DROP TABLE IF EXISTS `mall`;
CREATE TABLE `mall`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `mall_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `mall_desc` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL,
  `cash` int NULL DEFAULT NULL,
  `mall_type` int NULL DEFAULT NULL,
  `del_flag` int NULL DEFAULT NULL,
  `tblidx` int UNSIGNED NULL DEFAULT NULL,
  `place` tinyint UNSIGNED NULL DEFAULT NULL,
  `pos` tinyint UNSIGNED NULL DEFAULT NULL,
  `count` tinyint UNSIGNED NULL DEFAULT NULL,
  `rank` tinyint NULL DEFAULT NULL,
  `durability` tinyint UNSIGNED NULL DEFAULT NULL,
  `grade` tinyint NULL DEFAULT NULL,
  `NeedToIdentify` tinyint(1) NULL DEFAULT NULL,
  `BattleAttribute` tinyint UNSIGNED NULL DEFAULT NULL,
  `Maker` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `OptionTblidx` int UNSIGNED NULL DEFAULT NULL,
  `OptionTblidx2` int UNSIGNED NULL DEFAULT NULL,
  `OptionRandomId` smallint UNSIGNED NULL DEFAULT NULL,
  `OptionRandomVal` int UNSIGNED NULL DEFAULT NULL,
  `OptionRandomId2` smallint UNSIGNED NULL DEFAULT NULL,
  `OptionRandomVal2` int UNSIGNED NULL DEFAULT NULL,
  `OptionRandomId3` smallint UNSIGNED NULL DEFAULT NULL,
  `OptionRandomVal3` int UNSIGNED NULL DEFAULT NULL,
  `OptionRandomId4` smallint UNSIGNED NULL DEFAULT NULL,
  `OptionRandomVal4` int UNSIGNED NULL DEFAULT NULL,
  `OptionRandomId5` smallint UNSIGNED NULL DEFAULT NULL,
  `OptionRandomVal5` int UNSIGNED NULL DEFAULT NULL,
  `OptionRandomId6` smallint UNSIGNED NULL DEFAULT NULL,
  `OptionRandomVal6` int UNSIGNED NULL DEFAULT NULL,
  `OptionRandomId7` smallint UNSIGNED NULL DEFAULT NULL,
  `OptionRandomVal7` int UNSIGNED NULL DEFAULT NULL,
  `OptionRandomId8` smallint UNSIGNED NULL DEFAULT NULL,
  `OptionRandomVal8` int UNSIGNED NULL DEFAULT NULL,
  `UseStartTime` bigint UNSIGNED NULL DEFAULT NULL,
  `UseEndTime` bigint UNSIGNED NULL DEFAULT NULL,
  `RestrictState` tinyint UNSIGNED NULL DEFAULT NULL,
  `DurationType` tinyint UNSIGNED NULL DEFAULT NULL,
  `sign_reward` int NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `mall_type`(`mall_type` ASC) USING BTREE,
  INDEX `del_flag`(`del_flag` ASC) USING BTREE,
  INDEX `sign_reward`(`sign_reward` ASC) USING BTREE,
  FULLTEXT INDEX `mall_name`(`mall_name`) WITH PARSER `ngram`
) ENGINE = InnoDB AUTO_INCREMENT = 74 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for mall_order
-- ----------------------------
DROP TABLE IF EXISTS `mall_order`;
CREATE TABLE `mall_order`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `mall_id` int NULL DEFAULT NULL,
  `mall_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `mall_desc` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL,
  `cash` int NULL DEFAULT NULL,
  `AccountID` int NULL DEFAULT NULL,
  `CharID` int NULL DEFAULT NULL,
  `CharName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `buy_time` datetime NULL DEFAULT NULL,
  `status` int NULL DEFAULT NULL,
  `tblidx` int UNSIGNED NULL DEFAULT NULL,
  `place` tinyint UNSIGNED NULL DEFAULT NULL,
  `pos` tinyint UNSIGNED NULL DEFAULT NULL,
  `count` tinyint UNSIGNED NULL DEFAULT NULL,
  `rank` tinyint NULL DEFAULT NULL,
  `durability` tinyint UNSIGNED NULL DEFAULT NULL,
  `grade` tinyint NULL DEFAULT NULL,
  `NeedToIdentify` tinyint(1) NULL DEFAULT NULL,
  `BattleAttribute` tinyint UNSIGNED NULL DEFAULT NULL,
  `Maker` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `OptionTblidx` int UNSIGNED NULL DEFAULT NULL,
  `OptionTblidx2` int UNSIGNED NULL DEFAULT NULL,
  `OptionRandomId` smallint UNSIGNED NULL DEFAULT NULL,
  `OptionRandomVal` int UNSIGNED NULL DEFAULT NULL,
  `OptionRandomId2` smallint UNSIGNED NULL DEFAULT NULL,
  `OptionRandomVal2` int UNSIGNED NULL DEFAULT NULL,
  `OptionRandomId3` smallint UNSIGNED NULL DEFAULT NULL,
  `OptionRandomVal3` int UNSIGNED NULL DEFAULT NULL,
  `OptionRandomId4` smallint UNSIGNED NULL DEFAULT NULL,
  `OptionRandomVal4` int UNSIGNED NULL DEFAULT NULL,
  `OptionRandomId5` smallint UNSIGNED NULL DEFAULT NULL,
  `OptionRandomVal5` int UNSIGNED NULL DEFAULT NULL,
  `OptionRandomId6` smallint UNSIGNED NULL DEFAULT NULL,
  `OptionRandomVal6` int UNSIGNED NULL DEFAULT NULL,
  `OptionRandomId7` smallint UNSIGNED NULL DEFAULT NULL,
  `OptionRandomVal7` int UNSIGNED NULL DEFAULT NULL,
  `OptionRandomId8` smallint UNSIGNED NULL DEFAULT NULL,
  `OptionRandomVal8` int UNSIGNED NULL DEFAULT NULL,
  `UseStartTime` bigint UNSIGNED NULL DEFAULT NULL,
  `UseEndTime` bigint UNSIGNED NULL DEFAULT NULL,
  `RestrictState` tinyint UNSIGNED NULL DEFAULT NULL,
  `DurationType` tinyint UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 323 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for mall_type
-- ----------------------------
DROP TABLE IF EXISTS `mall_type`;
CREATE TABLE `mall_type`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `type_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `sort` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for shortcuts
-- ----------------------------
DROP TABLE IF EXISTS `shortcuts`;
CREATE TABLE `shortcuts`  (
  `AccountID` int UNSIGNED NOT NULL,
  `ActionID` int UNSIGNED NOT NULL DEFAULT 0,
  `wKey` int UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`AccountID`, `ActionID`) USING BTREE,
  UNIQUE INDEX `AccountID`(`AccountID` ASC, `ActionID` ASC) USING BTREE,
  INDEX `AccountID_2`(`AccountID` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for sign
-- ----------------------------
DROP TABLE IF EXISTS `sign`;
CREATE TABLE `sign`  (
  `AccountID` int NOT NULL,
  `sign_date` date NOT NULL,
  `sign_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sign_itemid` int NOT NULL,
  `CharID` int UNSIGNED NULL DEFAULT 0,
  `CharName` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`AccountID`, `sign_date`) USING BTREE,
  INDEX `AccountID`(`AccountID` ASC, `sign_date` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for web_admin
-- ----------------------------
DROP TABLE IF EXISTS `web_admin`;
CREATE TABLE `web_admin`  (
  `Username` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `Password` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`Username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for wp_shop
-- ----------------------------
DROP TABLE IF EXISTS `wp_shop`;
CREATE TABLE `wp_shop`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `ServerChannelID` tinyint UNSIGNED NULL DEFAULT 255 COMMENT '频道编号 255表示所有频道',
  `MerchantTab` tinyint UNSIGNED NULL DEFAULT 255,
  `idxItemTbl` int UNSIGNED NULL DEFAULT 0,
  `dwPrice` smallint UNSIGNED NULL DEFAULT 0,
  `dwMinPrice` smallint UNSIGNED NULL DEFAULT NULL,
  `dwInventory` smallint UNSIGNED NULL DEFAULT 65535,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

SET FOREIGN_KEY_CHECKS = 1;
