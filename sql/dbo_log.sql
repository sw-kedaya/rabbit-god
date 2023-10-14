/*
 Navicat Premium Data Transfer

 Source Server         : 本机
 Source Server Type    : MySQL
 Source Server Version : 80034 (8.0.34)
 Source Host           : localhost:3306
 Source Schema         : dbo_log

 Target Server Type    : MySQL
 Target Server Version : 80034 (8.0.34)
 File Encoding         : 65001

 Date: 14/10/2023 10:51:52
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for additem_log
-- ----------------------------
DROP TABLE IF EXISTS `additem_log`;
CREATE TABLE `additem_log`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `tblidx` int UNSIGNED NULL DEFAULT NULL,
  `count` tinyint UNSIGNED NULL DEFAULT 0,
  `CharID` int UNSIGNED NULL DEFAULT NULL,
  `CharName` varchar(17) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for auctionhouse_log
-- ----------------------------
DROP TABLE IF EXISTS `auctionhouse_log`;
CREATE TABLE `auctionhouse_log`  (
  `Seller` int UNSIGNED NULL DEFAULT NULL,
  `Buyer` int UNSIGNED NULL DEFAULT NULL,
  `Price` int UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx` int UNSIGNED NULL DEFAULT NULL,
  `ItemID` bigint UNSIGNED NULL DEFAULT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for auth_login_log
-- ----------------------------
DROP TABLE IF EXISTS `auth_login_log`;
CREATE TABLE `auth_login_log`  (
  `AccountID` int UNSIGNED NOT NULL,
  `IP` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX `AccountID`(`AccountID` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bobo_log
-- ----------------------------
DROP TABLE IF EXISTS `bobo_log`;
CREATE TABLE `bobo_log`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `ChannelID` tinyint UNSIGNED NULL DEFAULT NULL,
  `count` int UNSIGNED NULL DEFAULT 0,
  `date` date NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for budokai
-- ----------------------------
DROP TABLE IF EXISTS `budokai`;
CREATE TABLE `budokai`  (
  `SeasonCount` int UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Amount of budokais. 0 = 1, 10 = 11 ...',
  `DefaultOpenTime` int UNSIGNED NULL DEFAULT 0,
  `RankPointInitialized` bit(1) NULL DEFAULT b'0',
  `StateData_State` tinyint UNSIGNED NULL DEFAULT 0 COMMENT 'Budokai State',
  `StateData_NextStepTime` int UNSIGNED NULL DEFAULT 0 COMMENT 'budokai next step time',
  `IndividualStateData_State` tinyint UNSIGNED NULL DEFAULT 0 COMMENT 'Solo match state',
  `IndividualStateData_NextStepTime` int UNSIGNED NULL DEFAULT 0 COMMENT 'solo match next step time',
  `TeamStateData_State` tinyint UNSIGNED NULL DEFAULT 0 COMMENT 'team match state',
  `TeamStateData_NextStepTime` int UNSIGNED NULL DEFAULT 0 COMMENT 'Team match next state time'
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for budokai_signup
-- ----------------------------
DROP TABLE IF EXISTS `budokai_signup`;
CREATE TABLE `budokai_signup`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `BudokaiNumber` int NULL DEFAULT NULL,
  `Type` tinyint(1) NULL DEFAULT NULL,
  `MatchType` tinyint(1) NULL DEFAULT NULL,
  `CharID` int UNSIGNED NULL DEFAULT 0,
  `CharName` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `JoinID` int UNSIGNED NULL DEFAULT 0,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for budokai_winners
-- ----------------------------
DROP TABLE IF EXISTS `budokai_winners`;
CREATE TABLE `budokai_winners`  (
  `ID` int NOT NULL AUTO_INCREMENT,
  `BudokaiNumber` int UNSIGNED NULL DEFAULT 0,
  `Type` tinyint(1) NULL DEFAULT 0 COMMENT '0 = junior, 1 = adult',
  `MatchType` tinyint(1) NULL DEFAULT 0 COMMENT '0 = individual, 1 = team',
  `WinnerCharID1` int UNSIGNED NULL DEFAULT 0,
  `WinnerCharID2` int UNSIGNED NULL DEFAULT 0,
  `WinnerCharID3` int UNSIGNED NULL DEFAULT 0,
  `WinnerCharID4` int UNSIGNED NULL DEFAULT 0,
  `WinnerCharID5` int UNSIGNED NULL DEFAULT 0,
  `Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Reward` int NULL DEFAULT 0 COMMENT '0=meifa  1=yijingfafang',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for budokai_winners_old
-- ----------------------------
DROP TABLE IF EXISTS `budokai_winners_old`;
CREATE TABLE `budokai_winners_old`  (
  `ID` int NOT NULL AUTO_INCREMENT,
  `BudokaiNumber` int UNSIGNED NULL DEFAULT 0,
  `Type` tinyint(1) NULL DEFAULT 0 COMMENT '0 = junior, 1 = adult',
  `MatchType` tinyint(1) NULL DEFAULT 0 COMMENT '0 = individual, 1 = team',
  `WinnerCharID1` int UNSIGNED NULL DEFAULT 0,
  `WinnerCharID2` int UNSIGNED NULL DEFAULT 0,
  `WinnerCharID3` int UNSIGNED NULL DEFAULT 0,
  `WinnerCharID4` int UNSIGNED NULL DEFAULT 0,
  `WinnerCharID5` int UNSIGNED NULL DEFAULT 0,
  `Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Reward` int NULL DEFAULT 0 COMMENT '0=meifa  1=yijingfafang',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for ccdb_log
-- ----------------------------
DROP TABLE IF EXISTS `ccdb_log`;
CREATE TABLE `ccdb_log`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `ITEMID` bigint UNSIGNED NOT NULL DEFAULT 0,
  `tblidx` int UNSIGNED NOT NULL DEFAULT 0,
  `CharID` int UNSIGNED NOT NULL DEFAULT 0,
  `CharName` varchar(17) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `PartyID` int UNSIGNED NOT NULL DEFAULT 0,
  `startStage` tinyint UNSIGNED NULL DEFAULT 0,
  `count` tinyint UNSIGNED NOT NULL DEFAULT 0,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for change_char_name
-- ----------------------------
DROP TABLE IF EXISTS `change_char_name`;
CREATE TABLE `change_char_name`  (
  `CharID` int UNSIGNED NOT NULL,
  `Name` varchar(17) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `newName` varchar(17) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `date` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for character_delete_log
-- ----------------------------
DROP TABLE IF EXISTS `character_delete_log`;
CREATE TABLE `character_delete_log`  (
  `AccountID` int UNSIGNED NOT NULL,
  `CharID` int NOT NULL,
  `deleteip` varchar(64) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '0.0.0.0',
  `DelCharTime` bigint UNSIGNED NULL DEFAULT 0,
  `timestamp` datetime NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for dragonballdropcount_log
-- ----------------------------
DROP TABLE IF EXISTS `dragonballdropcount_log`;
CREATE TABLE `dragonballdropcount_log`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `ChannelID` tinyint UNSIGNED NULL DEFAULT NULL,
  `count` int UNSIGNED NULL DEFAULT 0,
  `date` date NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for dynamic_field_count
-- ----------------------------
DROP TABLE IF EXISTS `dynamic_field_count`;
CREATE TABLE `dynamic_field_count`  (
  `serverIndex` tinyint UNSIGNED NOT NULL DEFAULT 0,
  `count` int UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`serverIndex`) USING BTREE,
  UNIQUE INDEX `serverIndex`(`serverIndex` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci COMMENT = 'When the server restarts it will save & load the progress from this table.\r\nSince it takes many days to reach max count it is very important.' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for exchange_log
-- ----------------------------
DROP TABLE IF EXISTS `exchange_log`;
CREATE TABLE `exchange_log`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `CharID` int UNSIGNED NOT NULL DEFAULT 0,
  `CharName` varchar(17) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `tblidx` int UNSIGNED NOT NULL DEFAULT 0,
  `byNeedItem` int UNSIGNED NOT NULL DEFAULT 0,
  `byNeedItemStack` tinyint UNSIGNED NOT NULL DEFAULT 0,
  `dwNeedZenny` int UNSIGNED NOT NULL DEFAULT 0,
  `byNpcTblidx` int UNSIGNED NOT NULL DEFAULT 0,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for field_boss
-- ----------------------------
DROP TABLE IF EXISTS `field_boss`;
CREATE TABLE `field_boss`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `boss_tblidx` int UNSIGNED NOT NULL DEFAULT 0,
  `fDifficulty` smallint UNSIGNED NULL DEFAULT 100,
  `isOn` tinyint UNSIGNED NULL DEFAULT 1 COMMENT '1=可用',
  `notes` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for field_boss_position
-- ----------------------------
DROP TABLE IF EXISTS `field_boss_position`;
CREATE TABLE `field_boss_position`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `CurLocX` float(11, 6) NOT NULL DEFAULT 78.000000,
  `CurLocY` float(11, 6) NOT NULL DEFAULT 46.000000,
  `CurLocZ` float(11, 6) NOT NULL DEFAULT 168.000000,
  `Position_Name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for founder_log
-- ----------------------------
DROP TABLE IF EXISTS `founder_log`;
CREATE TABLE `founder_log`  (
  `Username` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `forumname` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `date` datetime NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for gm_log
-- ----------------------------
DROP TABLE IF EXISTS `gm_log`;
CREATE TABLE `gm_log`  (
  `CharID` int UNSIGNED NOT NULL,
  `LogType` int UNSIGNED NULL DEFAULT NULL,
  `String` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for guild_name_change_log
-- ----------------------------
DROP TABLE IF EXISTS `guild_name_change_log`;
CREATE TABLE `guild_name_change_log`  (
  `key` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `GuildID` int UNSIGNED NULL DEFAULT NULL,
  `CurrentName` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `NewName` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`key`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for guildbank_log
-- ----------------------------
DROP TABLE IF EXISTS `guildbank_log`;
CREATE TABLE `guildbank_log`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `guildID` int UNSIGNED NULL DEFAULT NULL,
  `CharID` int UNSIGNED NULL DEFAULT NULL,
  `dwZenny` int UNSIGNED NULL DEFAULT 0,
  `deposit` tinyint UNSIGNED NULL DEFAULT 255 COMMENT '存钱=1  取钱=0',
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for item_upgrade16_log
-- ----------------------------
DROP TABLE IF EXISTS `item_upgrade16_log`;
CREATE TABLE `item_upgrade16_log`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `charId` int UNSIGNED NOT NULL,
  `itemId` bigint UNSIGNED NOT NULL,
  `itemTblidx` int UNSIGNED NOT NULL,
  `grade` int NOT NULL,
  `byte` tinyint UNSIGNED NOT NULL DEFAULT 0,
  `date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for item_upgrade_log
-- ----------------------------
DROP TABLE IF EXISTS `item_upgrade_log`;
CREATE TABLE `item_upgrade_log`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `charId` int UNSIGNED NOT NULL,
  `IsSuccess` bit(1) NOT NULL,
  `itemId` bigint UNSIGNED NOT NULL,
  `itemTblidx` int UNSIGNED NOT NULL,
  `grade` int NOT NULL,
  `newGrade` int NOT NULL,
  `StoneItemId` bigint UNSIGNED NOT NULL,
  `StoneItemTblidx` int UNSIGNED NOT NULL,
  `CoreItemUse` bit(1) NOT NULL,
  `coreItemId` bigint UNSIGNED NOT NULL DEFAULT 0,
  `coreItemTblidx` int UNSIGNED NOT NULL,
  `date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for item_use_log
-- ----------------------------
DROP TABLE IF EXISTS `item_use_log`;
CREATE TABLE `item_use_log`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `CharID` int UNSIGNED NOT NULL,
  `ITEMID` bigint UNSIGNED NOT NULL DEFAULT 0,
  `tblidx` int UNSIGNED NOT NULL,
  `type` tinyint UNSIGNED NULL DEFAULT 0,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for mail_deleted
-- ----------------------------
DROP TABLE IF EXISTS `mail_deleted`;
CREATE TABLE `mail_deleted`  (
  `id` int UNSIGNED NOT NULL,
  `CharID` int UNSIGNED NOT NULL,
  `SenderType` tinyint UNSIGNED NOT NULL DEFAULT 0,
  `MailType` tinyint UNSIGNED NOT NULL DEFAULT 1,
  `TextSize` tinyint UNSIGNED NOT NULL DEFAULT 0,
  `Text` varchar(127) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Zenny` int UNSIGNED NOT NULL DEFAULT 0,
  `itemId` bigint UNSIGNED NOT NULL DEFAULT 0,
  `TargetName` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `FromName` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `IsAccept` tinyint(1) NOT NULL DEFAULT 0,
  `IsLock` tinyint(1) NOT NULL DEFAULT 0,
  `IsRead` tinyint(1) NOT NULL DEFAULT 0,
  `CreateTime` bigint UNSIGNED NULL DEFAULT NULL,
  `EndTime` bigint UNSIGNED NULL DEFAULT NULL,
  `RemainDay` tinyint UNSIGNED NOT NULL DEFAULT 1,
  `year` int UNSIGNED NOT NULL,
  `month` tinyint UNSIGNED NOT NULL,
  `day` tinyint UNSIGNED NOT NULL,
  `hour` tinyint UNSIGNED NOT NULL,
  `minute` tinyint UNSIGNED NOT NULL,
  `second` tinyint UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id` ASC, `CharID` ASC) USING BTREE,
  UNIQUE INDEX `id_2`(`id` ASC) USING BTREE,
  INDEX `CharID`(`CharID` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for mute_log
-- ----------------------------
DROP TABLE IF EXISTS `mute_log`;
CREATE TABLE `mute_log`  (
  `CharID` int UNSIGNED NOT NULL,
  `GmAccountID` int UNSIGNED NULL DEFAULT NULL,
  `DurationInMinutes` int UNSIGNED NULL DEFAULT NULL,
  `Reason` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `muteUntil` bigint UNSIGNED NULL DEFAULT NULL,
  `date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`CharID`) USING BTREE,
  UNIQUE INDEX `CharID`(`CharID` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for pickup_log
-- ----------------------------
DROP TABLE IF EXISTS `pickup_log`;
CREATE TABLE `pickup_log`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `tblidx` int UNSIGNED NULL DEFAULT NULL,
  `count` tinyint UNSIGNED NULL DEFAULT 0,
  `CharID` int UNSIGNED NULL DEFAULT NULL,
  `CharName` varchar(17) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for point_add_log
-- ----------------------------
DROP TABLE IF EXISTS `point_add_log`;
CREATE TABLE `point_add_log`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `AccountID` int NULL DEFAULT NULL,
  `CharID` int NULL DEFAULT NULL,
  `Addpoint` int NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for privateshoplogs
-- ----------------------------
DROP TABLE IF EXISTS `privateshoplogs`;
CREATE TABLE `privateshoplogs`  (
  `key` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `SellerCharID` int UNSIGNED NULL DEFAULT NULL,
  `BuyerCharID` int UNSIGNED NULL DEFAULT NULL,
  `Zeni` int UNSIGNED NULL DEFAULT NULL,
  `ItemCount` int UNSIGNED NULL DEFAULT NULL,
  `ItemID_1` bigint UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx_1` int UNSIGNED NULL DEFAULT NULL,
  `ItemCount_1` tinyint UNSIGNED NULL DEFAULT 1,
  `ItemID_2` bigint UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx_2` int UNSIGNED NULL DEFAULT NULL,
  `ItemCount_2` tinyint UNSIGNED NULL DEFAULT 1,
  `ItemID_3` bigint UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx_3` int UNSIGNED NULL DEFAULT NULL,
  `ItemCount_3` tinyint UNSIGNED NULL DEFAULT 1,
  `ItemID_4` bigint UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx_4` int UNSIGNED NULL DEFAULT NULL,
  `ItemCount_4` tinyint UNSIGNED NULL DEFAULT 1,
  `ItemID_5` bigint UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx_5` int UNSIGNED NULL DEFAULT NULL,
  `ItemCount_5` tinyint UNSIGNED NULL DEFAULT 1,
  `ItemID_6` bigint UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx_6` int UNSIGNED NULL DEFAULT NULL,
  `ItemCount_6` tinyint UNSIGNED NULL DEFAULT 1,
  `ItemID_7` bigint UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx_7` int UNSIGNED NULL DEFAULT NULL,
  `ItemCount_7` tinyint UNSIGNED NULL DEFAULT 1,
  `ItemID_8` bigint UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx_8` int UNSIGNED NULL DEFAULT NULL,
  `ItemCount_8` tinyint UNSIGNED NULL DEFAULT 1,
  `ItemID_9` bigint UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx_9` int UNSIGNED NULL DEFAULT NULL,
  `ItemCount_9` tinyint UNSIGNED NULL DEFAULT 1,
  `ItemID_10` bigint UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx_10` int UNSIGNED NULL DEFAULT NULL,
  `ItemCount_10` tinyint UNSIGNED NULL DEFAULT 1,
  `ItemID_11` bigint UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx_11` int UNSIGNED NULL DEFAULT NULL,
  `ItemCount_11` tinyint UNSIGNED NULL DEFAULT 1,
  `ItemID_12` bigint UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx_12` int UNSIGNED NULL DEFAULT NULL,
  `ItemCount_12` tinyint UNSIGNED NULL DEFAULT 1,
  `HasIssues` int NULL DEFAULT NULL,
  `IssueReason` varchar(512) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`key`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for recipe_log
-- ----------------------------
DROP TABLE IF EXISTS `recipe_log`;
CREATE TABLE `recipe_log`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `CharID` int NULL DEFAULT NULL,
  `CharName` varchar(17) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `RecipeTblidx` int UNSIGNED NULL DEFAULT NULL,
  `tblidx` int UNSIGNED NULL DEFAULT NULL,
  `date` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for reward_log
-- ----------------------------
DROP TABLE IF EXISTS `reward_log`;
CREATE TABLE `reward_log`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `CharID` int UNSIGNED NOT NULL DEFAULT 0,
  `tblidx` int UNSIGNED NOT NULL DEFAULT 0,
  `Activity` int UNSIGNED NOT NULL DEFAULT 0,
  `days` tinyint UNSIGNED NOT NULL DEFAULT 0,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for seal_log
-- ----------------------------
DROP TABLE IF EXISTS `seal_log`;
CREATE TABLE `seal_log`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `CharID` int UNSIGNED NOT NULL DEFAULT 0,
  `ITEMID` bigint UNSIGNED NOT NULL DEFAULT 0,
  `tblidx` int UNSIGNED NOT NULL DEFAULT 0,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for shop_sell_log
-- ----------------------------
DROP TABLE IF EXISTS `shop_sell_log`;
CREATE TABLE `shop_sell_log`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `CharID` int UNSIGNED NOT NULL DEFAULT 0,
  `dwZenny` int UNSIGNED NOT NULL DEFAULT 0,
  `bySellCount` tinyint UNSIGNED NOT NULL DEFAULT 0,
  `bytype` tinyint UNSIGNED NOT NULL DEFAULT 0,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for slot_machine_log
-- ----------------------------
DROP TABLE IF EXISTS `slot_machine_log`;
CREATE TABLE `slot_machine_log`  (
  `accountid` int UNSIGNED NULL DEFAULT NULL,
  `charid` int UNSIGNED NULL DEFAULT NULL,
  `extractCount` int UNSIGNED NULL DEFAULT NULL,
  `type` int UNSIGNED NULL DEFAULT NULL,
  `coin` int NULL DEFAULT NULL,
  `currentPoints` int UNSIGNED NULL DEFAULT NULL,
  `newPoints` int UNSIGNED NULL DEFAULT NULL,
  `ProductId1` int UNSIGNED NULL DEFAULT NULL,
  `ProductId2` int UNSIGNED NULL DEFAULT NULL,
  `ProductId3` int UNSIGNED NULL DEFAULT NULL,
  `ProductId4` int UNSIGNED NULL DEFAULT NULL,
  `ProductId5` int UNSIGNED NULL DEFAULT NULL,
  `ProductId6` int UNSIGNED NULL DEFAULT NULL,
  `ProductId7` int UNSIGNED NULL DEFAULT NULL,
  `ProductId8` int UNSIGNED NULL DEFAULT NULL,
  `ProductId9` int UNSIGNED NULL DEFAULT NULL,
  `ProductId10` int UNSIGNED NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for tradelogs
-- ----------------------------
DROP TABLE IF EXISTS `tradelogs`;
CREATE TABLE `tradelogs`  (
  `key` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `CharID` int UNSIGNED NULL DEFAULT NULL,
  `TargetCharID` int NULL DEFAULT NULL,
  `Zeni` int UNSIGNED NULL DEFAULT NULL,
  `ItemCount` int UNSIGNED NULL DEFAULT NULL,
  `ItemID_1` bigint UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx_1` int UNSIGNED NULL DEFAULT NULL,
  `ItemCount_1` int UNSIGNED NULL DEFAULT 0,
  `ItemID_2` bigint UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx_2` int UNSIGNED NULL DEFAULT NULL,
  `ItemCount_2` int UNSIGNED NULL DEFAULT 0,
  `ItemID_3` bigint UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx_3` int UNSIGNED NULL DEFAULT NULL,
  `ItemCount_3` int UNSIGNED NULL DEFAULT 0,
  `ItemID_4` bigint UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx_4` int UNSIGNED NULL DEFAULT NULL,
  `ItemCount_4` int UNSIGNED NULL DEFAULT 0,
  `ItemID_5` bigint UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx_5` int UNSIGNED NULL DEFAULT NULL,
  `ItemCount_5` int UNSIGNED NULL DEFAULT 0,
  `ItemID_6` bigint UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx_6` int UNSIGNED NULL DEFAULT NULL,
  `ItemCount_6` int UNSIGNED NULL DEFAULT 0,
  `ItemID_7` bigint UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx_7` int UNSIGNED NULL DEFAULT NULL,
  `ItemCount_7` int UNSIGNED NULL DEFAULT 0,
  `ItemID_8` bigint UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx_8` int UNSIGNED NULL DEFAULT NULL,
  `ItemCount_8` int UNSIGNED NULL DEFAULT 0,
  `ItemID_9` bigint UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx_9` int UNSIGNED NULL DEFAULT NULL,
  `ItemCount_9` int UNSIGNED NULL DEFAULT 0,
  `ItemID_10` bigint UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx_10` int UNSIGNED NULL DEFAULT NULL,
  `ItemCount_10` int UNSIGNED NULL DEFAULT 0,
  `ItemID_11` bigint UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx_11` int UNSIGNED NULL DEFAULT NULL,
  `ItemCount_11` int UNSIGNED NULL DEFAULT 0,
  `ItemID_12` bigint UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx_12` int UNSIGNED NULL DEFAULT NULL,
  `ItemCount_12` int UNSIGNED NULL DEFAULT 0,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`key`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for useitems_log
-- ----------------------------
DROP TABLE IF EXISTS `useitems_log`;
CREATE TABLE `useitems_log`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `ITEMID` bigint UNSIGNED NULL DEFAULT 0,
  `tblidx` int UNSIGNED NULL DEFAULT NULL,
  `count` tinyint UNSIGNED NULL DEFAULT 0,
  `newCount` tinyint UNSIGNED NULL DEFAULT 0,
  `CharID` int UNSIGNED NULL DEFAULT NULL,
  `partyadd` int UNSIGNED NULL DEFAULT 0,
  `bytype` tinyint UNSIGNED NULL DEFAULT 255,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for weapon_recasting_log
-- ----------------------------
DROP TABLE IF EXISTS `weapon_recasting_log`;
CREATE TABLE `weapon_recasting_log`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `CharID` int UNSIGNED NOT NULL,
  `ItemId` bigint UNSIGNED NOT NULL DEFAULT 0,
  `ItemTblidx` int UNSIGNED NOT NULL,
  `oldItemTblidx` int UNSIGNED NOT NULL,
  `date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for wp_shop_log
-- ----------------------------
DROP TABLE IF EXISTS `wp_shop_log`;
CREATE TABLE `wp_shop_log`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `CharID` int UNSIGNED NOT NULL,
  `tblidx` int UNSIGNED NOT NULL,
  `dwPrice` smallint UNSIGNED NOT NULL DEFAULT 0,
  `byStack` tinyint UNSIGNED NOT NULL DEFAULT 0,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

SET FOREIGN_KEY_CHECKS = 1;
