/*
 Navicat Premium Data Transfer

 Source Server         : longzhu
 Source Server Type    : MySQL
 Source Server Version : 80012
 Source Host           : localhost:3306
 Source Schema         : dbo_log

 Target Server Type    : MySQL
 Target Server Version : 80012
 File Encoding         : 65001

 Date: 19/09/2023 21:01:45
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for additem_log
-- ----------------------------
DROP TABLE IF EXISTS `additem_log`;
CREATE TABLE `additem_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tblidx` int(10) UNSIGNED NULL DEFAULT NULL,
  `count` tinyint(3) UNSIGNED NULL DEFAULT 0,
  `CharID` int(10) UNSIGNED NULL DEFAULT NULL,
  `CharName` varchar(17) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `timestamp` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 103 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of additem_log
-- ----------------------------

-- ----------------------------
-- Table structure for auctionhouse_log
-- ----------------------------
DROP TABLE IF EXISTS `auctionhouse_log`;
CREATE TABLE `auctionhouse_log`  (
  `Seller` int(10) UNSIGNED NULL DEFAULT NULL,
  `Buyer` int(10) UNSIGNED NULL DEFAULT NULL,
  `Price` int(10) UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx` int(10) UNSIGNED NULL DEFAULT NULL,
  `ItemID` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `timestamp` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0)
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auctionhouse_log
-- ----------------------------

-- ----------------------------
-- Table structure for auth_login_log
-- ----------------------------
DROP TABLE IF EXISTS `auth_login_log`;
CREATE TABLE `auth_login_log`  (
  `AccountID` int(10) UNSIGNED NOT NULL,
  `IP` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `timestamp` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  INDEX `AccountID`(`AccountID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_login_log
-- ----------------------------

-- ----------------------------
-- Table structure for bobo_log
-- ----------------------------
DROP TABLE IF EXISTS `bobo_log`;
CREATE TABLE `bobo_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ChannelID` tinyint(3) UNSIGNED NULL DEFAULT NULL,
  `count` int(10) UNSIGNED NULL DEFAULT 0,
  `date` date NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 176 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bobo_log
-- ----------------------------

-- ----------------------------
-- Table structure for budokai
-- ----------------------------
DROP TABLE IF EXISTS `budokai`;
CREATE TABLE `budokai`  (
  `SeasonCount` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Amount of budokais. 0 = 1, 10 = 11 ...',
  `DefaultOpenTime` int(10) UNSIGNED NULL DEFAULT 0,
  `RankPointInitialized` bit(1) NULL DEFAULT b'0',
  `StateData_State` tinyint(3) UNSIGNED NULL DEFAULT 0 COMMENT 'Budokai State',
  `StateData_NextStepTime` int(10) UNSIGNED NULL DEFAULT 0 COMMENT 'budokai next step time',
  `IndividualStateData_State` tinyint(3) UNSIGNED NULL DEFAULT 0 COMMENT 'Solo match state',
  `IndividualStateData_NextStepTime` int(10) UNSIGNED NULL DEFAULT 0 COMMENT 'solo match next step time',
  `TeamStateData_State` tinyint(3) UNSIGNED NULL DEFAULT 0 COMMENT 'team match state',
  `TeamStateData_NextStepTime` int(10) UNSIGNED NULL DEFAULT 0 COMMENT 'Team match next state time'
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of budokai
-- ----------------------------

-- ----------------------------
-- Table structure for budokai_signup
-- ----------------------------
DROP TABLE IF EXISTS `budokai_signup`;
CREATE TABLE `budokai_signup`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `BudokaiNumber` int(11) NULL DEFAULT NULL,
  `Type` tinyint(1) NULL DEFAULT NULL,
  `MatchType` tinyint(1) NULL DEFAULT NULL,
  `CharID` int(10) UNSIGNED NULL DEFAULT 0,
  `CharName` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `JoinID` int(10) UNSIGNED NULL DEFAULT 0,
  `timestamp` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17693 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of budokai_signup
-- ----------------------------

-- ----------------------------
-- Table structure for budokai_winners
-- ----------------------------
DROP TABLE IF EXISTS `budokai_winners`;
CREATE TABLE `budokai_winners`  (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `BudokaiNumber` int(10) UNSIGNED NULL DEFAULT 0,
  `Type` tinyint(1) NULL DEFAULT 0 COMMENT '0 = junior, 1 = adult',
  `MatchType` tinyint(1) NULL DEFAULT 0 COMMENT '0 = individual, 1 = team',
  `WinnerCharID1` int(10) UNSIGNED NULL DEFAULT 0,
  `WinnerCharID2` int(10) UNSIGNED NULL DEFAULT 0,
  `WinnerCharID3` int(10) UNSIGNED NULL DEFAULT 0,
  `WinnerCharID4` int(10) UNSIGNED NULL DEFAULT 0,
  `WinnerCharID5` int(10) UNSIGNED NULL DEFAULT 0,
  `Date` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  `Reward` int(11) NULL DEFAULT 0 COMMENT '0=meifa  1=yijingfafang',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 987 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of budokai_winners
-- ----------------------------

-- ----------------------------
-- Table structure for budokai_winners_old
-- ----------------------------
DROP TABLE IF EXISTS `budokai_winners_old`;
CREATE TABLE `budokai_winners_old`  (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `BudokaiNumber` int(10) UNSIGNED NULL DEFAULT 0,
  `Type` tinyint(1) NULL DEFAULT 0 COMMENT '0 = junior, 1 = adult',
  `MatchType` tinyint(1) NULL DEFAULT 0 COMMENT '0 = individual, 1 = team',
  `WinnerCharID1` int(10) UNSIGNED NULL DEFAULT 0,
  `WinnerCharID2` int(10) UNSIGNED NULL DEFAULT 0,
  `WinnerCharID3` int(10) UNSIGNED NULL DEFAULT 0,
  `WinnerCharID4` int(10) UNSIGNED NULL DEFAULT 0,
  `WinnerCharID5` int(10) UNSIGNED NULL DEFAULT 0,
  `Date` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  `Reward` int(11) NULL DEFAULT 0 COMMENT '0=meifa  1=yijingfafang',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 531 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of budokai_winners_old
-- ----------------------------

-- ----------------------------
-- Table structure for ccdb_log
-- ----------------------------
DROP TABLE IF EXISTS `ccdb_log`;
CREATE TABLE `ccdb_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ITEMID` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `tblidx` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `CharID` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `CharName` varchar(17) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `PartyID` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `startStage` tinyint(3) UNSIGNED NULL DEFAULT 0,
  `count` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `timestamp` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 96254 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ccdb_log
-- ----------------------------

-- ----------------------------
-- Table structure for change_char_name
-- ----------------------------
DROP TABLE IF EXISTS `change_char_name`;
CREATE TABLE `change_char_name`  (
  `CharID` int(10) UNSIGNED NOT NULL,
  `Name` varchar(17) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `newName` varchar(17) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `date` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0)
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of change_char_name
-- ----------------------------

-- ----------------------------
-- Table structure for character_delete_log
-- ----------------------------
DROP TABLE IF EXISTS `character_delete_log`;
CREATE TABLE `character_delete_log`  (
  `AccountID` int(10) UNSIGNED NOT NULL,
  `CharID` int(11) NOT NULL,
  `deleteip` varchar(64) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '0.0.0.0',
  `DelCharTime` bigint(20) UNSIGNED NULL DEFAULT 0,
  `timestamp` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0)
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of character_delete_log
-- ----------------------------

-- ----------------------------
-- Table structure for dragonballdropcount_log
-- ----------------------------
DROP TABLE IF EXISTS `dragonballdropcount_log`;
CREATE TABLE `dragonballdropcount_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ChannelID` tinyint(3) UNSIGNED NULL DEFAULT NULL,
  `count` int(10) UNSIGNED NULL DEFAULT 0,
  `date` date NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 685 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dragonballdropcount_log
-- ----------------------------

-- ----------------------------
-- Table structure for dynamic_field_count
-- ----------------------------
DROP TABLE IF EXISTS `dynamic_field_count`;
CREATE TABLE `dynamic_field_count`  (
  `serverIndex` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`serverIndex`) USING BTREE,
  UNIQUE INDEX `serverIndex`(`serverIndex`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci COMMENT = 'When the server restarts it will save & load the progress from this table.\r\nSince it takes many days to reach max count it is very important.' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dynamic_field_count
-- ----------------------------

-- ----------------------------
-- Table structure for exchange_log
-- ----------------------------
DROP TABLE IF EXISTS `exchange_log`;
CREATE TABLE `exchange_log`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `CharID` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `CharName` varchar(17) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tblidx` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `byNeedItem` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `byNeedItemStack` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `dwNeedZenny` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `byNpcTblidx` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `timestamp` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 268937 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of exchange_log
-- ----------------------------

-- ----------------------------
-- Table structure for field_boss
-- ----------------------------
DROP TABLE IF EXISTS `field_boss`;
CREATE TABLE `field_boss`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `boss_tblidx` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `fDifficulty` smallint(5) UNSIGNED NULL DEFAULT 100,
  `isOn` tinyint(3) UNSIGNED NULL DEFAULT 1 COMMENT '1=可用',
  `notes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of field_boss
-- ----------------------------

-- ----------------------------
-- Table structure for field_boss_position
-- ----------------------------
DROP TABLE IF EXISTS `field_boss_position`;
CREATE TABLE `field_boss_position`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `CurLocX` float(11, 6) NOT NULL DEFAULT 78.000000,
  `CurLocY` float(11, 6) NOT NULL DEFAULT 46.000000,
  `CurLocZ` float(11, 6) NOT NULL DEFAULT 168.000000,
  `Position_Name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of field_boss_position
-- ----------------------------

-- ----------------------------
-- Table structure for founder_log
-- ----------------------------
DROP TABLE IF EXISTS `founder_log`;
CREATE TABLE `founder_log`  (
  `Username` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `forumname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `date` datetime(0) NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of founder_log
-- ----------------------------

-- ----------------------------
-- Table structure for gm_log
-- ----------------------------
DROP TABLE IF EXISTS `gm_log`;
CREATE TABLE `gm_log`  (
  `CharID` int(10) UNSIGNED NOT NULL,
  `LogType` int(10) UNSIGNED NULL DEFAULT NULL,
  `String` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `timestamp` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0)
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gm_log
-- ----------------------------

-- ----------------------------
-- Table structure for guild_name_change_log
-- ----------------------------
DROP TABLE IF EXISTS `guild_name_change_log`;
CREATE TABLE `guild_name_change_log`  (
  `key` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `GuildID` int(10) UNSIGNED NULL DEFAULT NULL,
  `CurrentName` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `NewName` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `timestamp` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`key`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 163 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of guild_name_change_log
-- ----------------------------

-- ----------------------------
-- Table structure for guildbank_log
-- ----------------------------
DROP TABLE IF EXISTS `guildbank_log`;
CREATE TABLE `guildbank_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `guildID` int(10) UNSIGNED NULL DEFAULT NULL,
  `CharID` int(10) UNSIGNED NULL DEFAULT NULL,
  `dwZenny` int(10) UNSIGNED NULL DEFAULT 0,
  `deposit` tinyint(3) UNSIGNED NULL DEFAULT 255 COMMENT '存钱=1  取钱=0',
  `timestamp` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of guildbank_log
-- ----------------------------

-- ----------------------------
-- Table structure for item_upgrade16_log
-- ----------------------------
DROP TABLE IF EXISTS `item_upgrade16_log`;
CREATE TABLE `item_upgrade16_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `charId` int(10) UNSIGNED NOT NULL,
  `itemId` bigint(20) UNSIGNED NOT NULL,
  `itemTblidx` int(10) UNSIGNED NOT NULL,
  `grade` int(11) NOT NULL,
  `byte` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `date` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of item_upgrade16_log
-- ----------------------------

-- ----------------------------
-- Table structure for item_upgrade_log
-- ----------------------------
DROP TABLE IF EXISTS `item_upgrade_log`;
CREATE TABLE `item_upgrade_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `charId` int(10) UNSIGNED NOT NULL,
  `IsSuccess` bit(1) NOT NULL,
  `itemId` bigint(20) UNSIGNED NOT NULL,
  `itemTblidx` int(10) UNSIGNED NOT NULL,
  `grade` int(11) NOT NULL,
  `newGrade` int(11) NOT NULL,
  `StoneItemId` bigint(20) UNSIGNED NOT NULL,
  `StoneItemTblidx` int(10) UNSIGNED NOT NULL,
  `CoreItemUse` bit(1) NOT NULL,
  `coreItemId` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `coreItemTblidx` int(10) UNSIGNED NOT NULL,
  `date` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 167513 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of item_upgrade_log
-- ----------------------------

-- ----------------------------
-- Table structure for item_use_log
-- ----------------------------
DROP TABLE IF EXISTS `item_use_log`;
CREATE TABLE `item_use_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `CharID` int(10) UNSIGNED NOT NULL,
  `ITEMID` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `tblidx` int(10) UNSIGNED NOT NULL,
  `type` tinyint(3) UNSIGNED NULL DEFAULT 0,
  `timestamp` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of item_use_log
-- ----------------------------

-- ----------------------------
-- Table structure for mail_deleted
-- ----------------------------
DROP TABLE IF EXISTS `mail_deleted`;
CREATE TABLE `mail_deleted`  (
  `id` int(10) UNSIGNED NOT NULL,
  `CharID` int(10) UNSIGNED NOT NULL,
  `SenderType` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `MailType` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `TextSize` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `Text` varchar(127) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Zenny` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `itemId` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `TargetName` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `FromName` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `IsAccept` tinyint(1) NOT NULL DEFAULT 0,
  `IsLock` tinyint(1) NOT NULL DEFAULT 0,
  `IsRead` tinyint(1) NOT NULL DEFAULT 0,
  `CreateTime` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `EndTime` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `RemainDay` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `year` int(10) UNSIGNED NOT NULL,
  `month` tinyint(3) UNSIGNED NOT NULL,
  `day` tinyint(3) UNSIGNED NOT NULL,
  `hour` tinyint(3) UNSIGNED NOT NULL,
  `minute` tinyint(3) UNSIGNED NOT NULL,
  `second` tinyint(3) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`, `CharID`) USING BTREE,
  UNIQUE INDEX `id_2`(`id`) USING BTREE,
  INDEX `CharID`(`CharID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mail_deleted
-- ----------------------------

-- ----------------------------
-- Table structure for mute_log
-- ----------------------------
DROP TABLE IF EXISTS `mute_log`;
CREATE TABLE `mute_log`  (
  `CharID` int(10) UNSIGNED NOT NULL,
  `GmAccountID` int(10) UNSIGNED NULL DEFAULT NULL,
  `DurationInMinutes` int(10) UNSIGNED NULL DEFAULT NULL,
  `Reason` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `muteUntil` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `date` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`CharID`) USING BTREE,
  UNIQUE INDEX `CharID`(`CharID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mute_log
-- ----------------------------

-- ----------------------------
-- Table structure for pickup_log
-- ----------------------------
DROP TABLE IF EXISTS `pickup_log`;
CREATE TABLE `pickup_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tblidx` int(10) UNSIGNED NULL DEFAULT NULL,
  `count` tinyint(3) UNSIGNED NULL DEFAULT 0,
  `CharID` int(10) UNSIGNED NULL DEFAULT NULL,
  `CharName` varchar(17) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `timestamp` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2395 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pickup_log
-- ----------------------------

-- ----------------------------
-- Table structure for point_add_log
-- ----------------------------
DROP TABLE IF EXISTS `point_add_log`;
CREATE TABLE `point_add_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `date` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  `AccountID` int(11) NULL DEFAULT NULL,
  `CharID` int(11) NULL DEFAULT NULL,
  `Addpoint` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5743 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of point_add_log
-- ----------------------------

-- ----------------------------
-- Table structure for privateshoplogs
-- ----------------------------
DROP TABLE IF EXISTS `privateshoplogs`;
CREATE TABLE `privateshoplogs`  (
  `key` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `SellerCharID` int(10) UNSIGNED NULL DEFAULT NULL,
  `BuyerCharID` int(10) UNSIGNED NULL DEFAULT NULL,
  `Zeni` int(10) UNSIGNED NULL DEFAULT NULL,
  `ItemCount` int(10) UNSIGNED NULL DEFAULT NULL,
  `ItemID_1` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx_1` int(10) UNSIGNED NULL DEFAULT NULL,
  `ItemCount_1` tinyint(3) UNSIGNED NULL DEFAULT 1,
  `ItemID_2` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx_2` int(10) UNSIGNED NULL DEFAULT NULL,
  `ItemCount_2` tinyint(3) UNSIGNED NULL DEFAULT 1,
  `ItemID_3` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx_3` int(10) UNSIGNED NULL DEFAULT NULL,
  `ItemCount_3` tinyint(3) UNSIGNED NULL DEFAULT 1,
  `ItemID_4` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx_4` int(10) UNSIGNED NULL DEFAULT NULL,
  `ItemCount_4` tinyint(3) UNSIGNED NULL DEFAULT 1,
  `ItemID_5` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx_5` int(10) UNSIGNED NULL DEFAULT NULL,
  `ItemCount_5` tinyint(3) UNSIGNED NULL DEFAULT 1,
  `ItemID_6` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx_6` int(10) UNSIGNED NULL DEFAULT NULL,
  `ItemCount_6` tinyint(3) UNSIGNED NULL DEFAULT 1,
  `ItemID_7` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx_7` int(10) UNSIGNED NULL DEFAULT NULL,
  `ItemCount_7` tinyint(3) UNSIGNED NULL DEFAULT 1,
  `ItemID_8` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx_8` int(10) UNSIGNED NULL DEFAULT NULL,
  `ItemCount_8` tinyint(3) UNSIGNED NULL DEFAULT 1,
  `ItemID_9` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx_9` int(10) UNSIGNED NULL DEFAULT NULL,
  `ItemCount_9` tinyint(3) UNSIGNED NULL DEFAULT 1,
  `ItemID_10` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx_10` int(10) UNSIGNED NULL DEFAULT NULL,
  `ItemCount_10` tinyint(3) UNSIGNED NULL DEFAULT 1,
  `ItemID_11` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx_11` int(10) UNSIGNED NULL DEFAULT NULL,
  `ItemCount_11` tinyint(3) UNSIGNED NULL DEFAULT 1,
  `ItemID_12` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx_12` int(10) UNSIGNED NULL DEFAULT NULL,
  `ItemCount_12` tinyint(3) UNSIGNED NULL DEFAULT 1,
  `HasIssues` int(11) NULL DEFAULT NULL,
  `IssueReason` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `timestamp` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`key`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7176 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of privateshoplogs
-- ----------------------------

-- ----------------------------
-- Table structure for recipe_log
-- ----------------------------
DROP TABLE IF EXISTS `recipe_log`;
CREATE TABLE `recipe_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `CharID` int(11) NULL DEFAULT NULL,
  `CharName` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `RecipeTblidx` int(10) UNSIGNED NULL DEFAULT NULL,
  `tblidx` int(10) UNSIGNED NULL DEFAULT NULL,
  `date` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 44340 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of recipe_log
-- ----------------------------

-- ----------------------------
-- Table structure for reward_log
-- ----------------------------
DROP TABLE IF EXISTS `reward_log`;
CREATE TABLE `reward_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `CharID` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `tblidx` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `Activity` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `days` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `timestamp` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 236 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reward_log
-- ----------------------------

-- ----------------------------
-- Table structure for seal_log
-- ----------------------------
DROP TABLE IF EXISTS `seal_log`;
CREATE TABLE `seal_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `CharID` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `ITEMID` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `tblidx` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `timestamp` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 150 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of seal_log
-- ----------------------------

-- ----------------------------
-- Table structure for shop_sell_log
-- ----------------------------
DROP TABLE IF EXISTS `shop_sell_log`;
CREATE TABLE `shop_sell_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `CharID` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `dwZenny` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `bySellCount` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `bytype` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `timestamp` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 62639 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shop_sell_log
-- ----------------------------

-- ----------------------------
-- Table structure for slot_machine_log
-- ----------------------------
DROP TABLE IF EXISTS `slot_machine_log`;
CREATE TABLE `slot_machine_log`  (
  `accountid` int(10) UNSIGNED NULL DEFAULT NULL,
  `charid` int(10) UNSIGNED NULL DEFAULT NULL,
  `extractCount` int(10) UNSIGNED NULL DEFAULT NULL,
  `type` int(10) UNSIGNED NULL DEFAULT NULL,
  `coin` int(11) NULL DEFAULT NULL,
  `currentPoints` int(10) UNSIGNED NULL DEFAULT NULL,
  `newPoints` int(10) UNSIGNED NULL DEFAULT NULL,
  `ProductId1` int(10) UNSIGNED NULL DEFAULT NULL,
  `ProductId2` int(10) UNSIGNED NULL DEFAULT NULL,
  `ProductId3` int(10) UNSIGNED NULL DEFAULT NULL,
  `ProductId4` int(10) UNSIGNED NULL DEFAULT NULL,
  `ProductId5` int(10) UNSIGNED NULL DEFAULT NULL,
  `ProductId6` int(10) UNSIGNED NULL DEFAULT NULL,
  `ProductId7` int(10) UNSIGNED NULL DEFAULT NULL,
  `ProductId8` int(10) UNSIGNED NULL DEFAULT NULL,
  `ProductId9` int(10) UNSIGNED NULL DEFAULT NULL,
  `ProductId10` int(10) UNSIGNED NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of slot_machine_log
-- ----------------------------

-- ----------------------------
-- Table structure for tradelogs
-- ----------------------------
DROP TABLE IF EXISTS `tradelogs`;
CREATE TABLE `tradelogs`  (
  `key` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `CharID` int(10) UNSIGNED NULL DEFAULT NULL,
  `TargetCharID` int(11) NULL DEFAULT NULL,
  `Zeni` int(10) UNSIGNED NULL DEFAULT NULL,
  `ItemCount` int(10) UNSIGNED NULL DEFAULT NULL,
  `ItemID_1` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx_1` int(10) UNSIGNED NULL DEFAULT NULL,
  `ItemCount_1` int(10) UNSIGNED NULL DEFAULT 0,
  `ItemID_2` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx_2` int(10) UNSIGNED NULL DEFAULT NULL,
  `ItemCount_2` int(10) UNSIGNED NULL DEFAULT 0,
  `ItemID_3` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx_3` int(10) UNSIGNED NULL DEFAULT NULL,
  `ItemCount_3` int(10) UNSIGNED NULL DEFAULT 0,
  `ItemID_4` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx_4` int(10) UNSIGNED NULL DEFAULT NULL,
  `ItemCount_4` int(10) UNSIGNED NULL DEFAULT 0,
  `ItemID_5` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx_5` int(10) UNSIGNED NULL DEFAULT NULL,
  `ItemCount_5` int(10) UNSIGNED NULL DEFAULT 0,
  `ItemID_6` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx_6` int(10) UNSIGNED NULL DEFAULT NULL,
  `ItemCount_6` int(10) UNSIGNED NULL DEFAULT 0,
  `ItemID_7` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx_7` int(10) UNSIGNED NULL DEFAULT NULL,
  `ItemCount_7` int(10) UNSIGNED NULL DEFAULT 0,
  `ItemID_8` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx_8` int(10) UNSIGNED NULL DEFAULT NULL,
  `ItemCount_8` int(10) UNSIGNED NULL DEFAULT 0,
  `ItemID_9` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx_9` int(10) UNSIGNED NULL DEFAULT NULL,
  `ItemCount_9` int(10) UNSIGNED NULL DEFAULT 0,
  `ItemID_10` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx_10` int(10) UNSIGNED NULL DEFAULT NULL,
  `ItemCount_10` int(10) UNSIGNED NULL DEFAULT 0,
  `ItemID_11` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx_11` int(10) UNSIGNED NULL DEFAULT NULL,
  `ItemCount_11` int(10) UNSIGNED NULL DEFAULT 0,
  `ItemID_12` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `ItemTblidx_12` int(10) UNSIGNED NULL DEFAULT NULL,
  `ItemCount_12` int(10) UNSIGNED NULL DEFAULT 0,
  `timestamp` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`key`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 417815 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tradelogs
-- ----------------------------

-- ----------------------------
-- Table structure for useitems_log
-- ----------------------------
DROP TABLE IF EXISTS `useitems_log`;
CREATE TABLE `useitems_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ITEMID` bigint(20) UNSIGNED NULL DEFAULT 0,
  `tblidx` int(10) UNSIGNED NULL DEFAULT NULL,
  `count` tinyint(3) UNSIGNED NULL DEFAULT 0,
  `newCount` tinyint(3) UNSIGNED NULL DEFAULT 0,
  `CharID` int(10) UNSIGNED NULL DEFAULT NULL,
  `partyadd` int(10) UNSIGNED NULL DEFAULT 0,
  `bytype` tinyint(3) UNSIGNED NULL DEFAULT 255,
  `timestamp` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15124 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of useitems_log
-- ----------------------------

-- ----------------------------
-- Table structure for weapon_recasting_log
-- ----------------------------
DROP TABLE IF EXISTS `weapon_recasting_log`;
CREATE TABLE `weapon_recasting_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `CharID` int(10) UNSIGNED NOT NULL,
  `ItemId` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `ItemTblidx` int(10) UNSIGNED NOT NULL,
  `oldItemTblidx` int(10) UNSIGNED NOT NULL,
  `date` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of weapon_recasting_log
-- ----------------------------

-- ----------------------------
-- Table structure for wp_shop_log
-- ----------------------------
DROP TABLE IF EXISTS `wp_shop_log`;
CREATE TABLE `wp_shop_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `CharID` int(10) UNSIGNED NOT NULL,
  `tblidx` int(10) UNSIGNED NOT NULL,
  `dwPrice` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `byStack` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `timestamp` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wp_shop_log
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
