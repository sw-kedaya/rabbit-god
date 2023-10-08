/*
 Navicat Premium Data Transfer

 Source Server         : longzhu
 Source Server Type    : MySQL
 Source Server Version : 80012
 Source Host           : localhost:3306
 Source Schema         : dbo_char

 Target Server Type    : MySQL
 Target Server Version : 80012
 File Encoding         : 65001

 Date: 19/09/2023 21:01:36
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auctionhouse
-- ----------------------------
DROP TABLE IF EXISTS `auctionhouse`;
CREATE TABLE `auctionhouse`  (
  `id` bigint(20) UNSIGNED NOT NULL,
  `CharID` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `TabType` tinyint(3) UNSIGNED NOT NULL DEFAULT 255,
  `ItemName` varchar(33) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `Seller` varchar(17) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Price` int(10) UNSIGNED NOT NULL,
  `ItemID` bigint(20) UNSIGNED NOT NULL,
  `TimeStart` int(10) UNSIGNED NOT NULL,
  `TimeEnd` int(10) UNSIGNED NULL DEFAULT NULL COMMENT 'time in seconds',
  `ItemLevel` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `NeedClass` int(10) UNSIGNED NOT NULL,
  `ItemType` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`, `CharID`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE,
  INDEX `CharID`(`CharID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auctionhouse
-- ----------------------------

-- ----------------------------
-- Table structure for bannword
-- ----------------------------
DROP TABLE IF EXISTS `bannword`;
CREATE TABLE `bannword`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bannword` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bannword
-- ----------------------------

-- ----------------------------
-- Table structure for bind
-- ----------------------------
DROP TABLE IF EXISTS `bind`;
CREATE TABLE `bind`  (
  `CharID` int(10) UNSIGNED NOT NULL,
  `WorldID` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `BindObjectTblIdx` int(10) UNSIGNED NOT NULL DEFAULT 4294967295,
  `LocX` float(11, 6) NOT NULL,
  `LocY` float(11, 6) NOT NULL,
  `LocZ` float(11, 6) NOT NULL,
  `DirX` float(11, 6) NOT NULL,
  `DirY` float(11, 6) NOT NULL,
  `DirZ` float(11, 6) NOT NULL,
  `Type` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`CharID`) USING BTREE,
  UNIQUE INDEX `CharID`(`CharID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bind
-- ----------------------------

-- ----------------------------
-- Table structure for buffs
-- ----------------------------
DROP TABLE IF EXISTS `buffs`;
CREATE TABLE `buffs`  (
  `CharID` int(10) UNSIGNED NOT NULL,
  `SourceTblidx` int(10) UNSIGNED NOT NULL,
  `SourceType` tinyint(3) UNSIGNED NOT NULL DEFAULT 255 COMMENT '0 skill and 1 item',
  `BuffIndex` tinyint(3) UNSIGNED NOT NULL DEFAULT 255,
  `BuffGroup` tinyint(3) UNSIGNED NOT NULL DEFAULT 255,
  `InitialDuration` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `TimeRemaining` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `effectValue1` double(10, 2) NULL DEFAULT NULL,
  `effectValue2` double(10, 2) NULL DEFAULT NULL,
  `Argument1_0` int(10) UNSIGNED NULL DEFAULT NULL COMMENT 'commonConfigTblidx',
  `Argument1_1` int(10) UNSIGNED NULL DEFAULT NULL COMMENT 'dwRemainTime',
  `Argument1_2` int(10) UNSIGNED NULL DEFAULT NULL COMMENT 'dwRemainValue',
  `Argument2_0` int(10) UNSIGNED NULL DEFAULT NULL COMMENT 'commonConfigTblidx',
  `Argument2_1` int(10) UNSIGNED NULL DEFAULT NULL COMMENT 'dwRemainTime',
  `Argument2_2` int(10) UNSIGNED NULL DEFAULT NULL COMMENT 'dwRemainValue',
  PRIMARY KEY (`CharID`, `BuffIndex`) USING BTREE,
  UNIQUE INDEX `CharID`(`CharID`, `BuffIndex`) USING BTREE,
  INDEX `CharID_2`(`CharID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of buffs
-- ----------------------------

-- ----------------------------
-- Table structure for characters
-- ----------------------------
DROP TABLE IF EXISTS `characters`;
CREATE TABLE `characters`  (
  `CharID` int(10) UNSIGNED NOT NULL,
  `CharName` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `AccountID` int(10) UNSIGNED NOT NULL,
  `Level` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `Exp` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `Race` tinyint(3) UNSIGNED NULL DEFAULT NULL,
  `Class` tinyint(3) UNSIGNED NULL DEFAULT NULL,
  `Gender` tinyint(3) UNSIGNED NULL DEFAULT NULL,
  `Face` tinyint(3) UNSIGNED NULL DEFAULT NULL,
  `Adult` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `Hair` tinyint(3) UNSIGNED NOT NULL,
  `HairColor` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `SkinColor` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `Blood` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `CurLocX` float(11, 6) NOT NULL DEFAULT 78.000000,
  `CurLocY` float(11, 6) NOT NULL DEFAULT 46.000000,
  `CurLocZ` float(11, 6) NOT NULL DEFAULT 168.000000,
  `CurDirX` float(11, 6) NOT NULL DEFAULT 0.000000,
  `CurDirY` float(11, 6) NOT NULL DEFAULT 0.000000,
  `CurDirZ` float(11, 6) NOT NULL DEFAULT 0.000000,
  `WorldID` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `WorldTable` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `MapInfoIndex` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `Money` int(10) UNSIGNED NOT NULL DEFAULT 2333,
  `MoneyBank` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `TutorialFlag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 = start tutorial / 1 = dont start tutorial',
  `TutorialHint` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `NameChange` tinyint(1) NOT NULL DEFAULT 0,
  `Reputation` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `MudosaPoint` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `SpPoint` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'skill points',
  `GameMaster` tinyint(1) NOT NULL DEFAULT 1,
  `GuildID` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `GuildName` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `CurLP` int(11) NOT NULL DEFAULT 15000,
  `CurEP` smallint(5) UNSIGNED NOT NULL DEFAULT 15000,
  `CurRP` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `CurAP` int(11) NOT NULL DEFAULT 450000,
  `MailIsAway` tinyint(1) NOT NULL DEFAULT 0,
  `SrvFarmID` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `DelCharTime` bigint(20) UNSIGNED NULL DEFAULT NULL COMMENT 'time(0) + 43200 = 12 hours',
  `Hoipoi_NormalStart` tinyint(1) NOT NULL DEFAULT 0,
  `Hoipoi_SpecialStart` tinyint(1) NOT NULL DEFAULT 0,
  `Hoipoi_Type` tinyint(3) UNSIGNED NOT NULL DEFAULT 255,
  `Hoipoi_MixLevel` tinyint(3) UNSIGNED NOT NULL DEFAULT 30,
  `Hoipoi_MixExp` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `Title` int(10) UNSIGNED NOT NULL DEFAULT 4294967295,
  `Mascot` int(10) UNSIGNED NOT NULL DEFAULT 4294967295,
  `RpBall` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `Netpy` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Netpy are points the user receives while staying online',
  `WaguPoint` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `IP` varchar(16) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '0.0.0.0' COMMENT 'the last IP in the char',
  `AirState` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '0 = off and 1 = on',
  `InvisibleCostume` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 = false 1 = true',
  `PlayTime` bigint(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'play time in seconds',
  `SuperiorEffectType` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `CreateTime` bigint(20) UNSIGNED NOT NULL COMMENT 'time(0)',
  `Deleteip` varchar(64) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '0.0.0.0',
  `IsOnline` int(11) NOT NULL DEFAULT 0,
  `ttime` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `TeacherID` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '师傅ID',
  `Activity` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '记录活跃程度，每月清空',
  `LastActivity` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '记录上月活跃值',
  `AddSpPoint` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `Sign` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `BlindBox` smallint(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '记录使用盲盒的数量',
  `BlindBox_accumulate` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '累计数量',
  PRIMARY KEY (`CharID`, `CharName`, `SrvFarmID`) USING BTREE,
  UNIQUE INDEX `CharID`(`CharID`) USING BTREE,
  UNIQUE INDEX `CharName`(`CharName`) USING BTREE,
  UNIQUE INDEX `CharID_2`(`CharID`, `SrvFarmID`) USING BTREE,
  UNIQUE INDEX `CharID_3`(`CharID`, `AccountID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of characters
-- ----------------------------

-- ----------------------------
-- Table structure for charextra
-- ----------------------------
DROP TABLE IF EXISTS `charextra`;
CREATE TABLE `charextra`  (
  `CharID` int(10) UNSIGNED NOT NULL,
  `PhysicalOffencePA` tinyint(3) UNSIGNED NULL DEFAULT 0,
  `PhysicalOffencePAEXP` smallint(5) UNSIGNED NULL DEFAULT 0,
  `PhysicalOffencePAMAX` tinyint(3) UNSIGNED NULL DEFAULT 20,
  `EnergyOffencePA` tinyint(3) UNSIGNED NULL DEFAULT 0,
  `EnergyOffencePAEXP` smallint(5) UNSIGNED NULL DEFAULT 0,
  `EnergyOffencePAMAX` tinyint(3) UNSIGNED NULL DEFAULT 20,
  `PhysicalDefensePA` tinyint(3) UNSIGNED NULL DEFAULT 0,
  `PhysicalDefensePAEXP` smallint(5) UNSIGNED NULL DEFAULT 0,
  `PhysicalDefensePAMAX` tinyint(3) UNSIGNED NULL DEFAULT 20,
  `EnergyDefensePA` tinyint(3) UNSIGNED NULL DEFAULT 0,
  `EnergyDefensePAEXP` smallint(5) UNSIGNED NULL DEFAULT 0,
  `EnergyDefensePAMAX` tinyint(3) UNSIGNED NULL DEFAULT 20,
  `RentPAType` tinyint(3) UNSIGNED NULL DEFAULT 0,
  `RentPALevel` tinyint(3) UNSIGNED NULL DEFAULT 0,
  `tmEndTimesRentPA` bigint(20) UNSIGNED NULL DEFAULT 0,
  PRIMARY KEY (`CharID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of charextra
-- ----------------------------

-- ----------------------------
-- Table structure for charother
-- ----------------------------
DROP TABLE IF EXISTS `charother`;
CREATE TABLE `charother`  (
  `CharID` int(10) UNSIGNED NOT NULL,
  `Return_Zeni` int(10) UNSIGNED NULL DEFAULT 0,
  `everyDayReward` int(10) UNSIGNED NULL DEFAULT 0,
  `Last_Return_time` bigint(20) UNSIGNED NULL DEFAULT 0,
  PRIMARY KEY (`CharID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of charother
-- ----------------------------

-- ----------------------------
-- Table structure for dojos
-- ----------------------------
DROP TABLE IF EXISTS `dojos`;
CREATE TABLE `dojos`  (
  `GuildId` int(10) UNSIGNED NOT NULL,
  `DojoTblidx` int(10) UNSIGNED NOT NULL,
  `Level` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `PeaceStatus` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `PeacePoints` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `GuildName` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `LeaderName` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Notice` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ChallengeGuildId` int(10) UNSIGNED NOT NULL DEFAULT 4294967295,
  `SeedCharName` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`DojoTblidx`) USING BTREE,
  UNIQUE INDEX `DojoTblidx`(`DojoTblidx`) USING BTREE,
  UNIQUE INDEX `GuildId`(`GuildId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dojos
-- ----------------------------

-- ----------------------------
-- Table structure for friendlist
-- ----------------------------
DROP TABLE IF EXISTS `friendlist`;
CREATE TABLE `friendlist`  (
  `user_id` int(10) UNSIGNED NOT NULL,
  `friend_id` int(10) UNSIGNED NOT NULL,
  `friend_name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `blacklist` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`user_id`, `friend_id`) USING BTREE,
  UNIQUE INDEX `user_id`(`user_id`, `friend_id`) USING BTREE,
  INDEX `user_id_2`(`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of friendlist
-- ----------------------------

-- ----------------------------
-- Table structure for guild_members
-- ----------------------------
DROP TABLE IF EXISTS `guild_members`;
CREATE TABLE `guild_members`  (
  `GuildID` int(10) UNSIGNED NOT NULL,
  `CharID` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`GuildID`, `CharID`) USING BTREE,
  UNIQUE INDEX `GuildID`(`GuildID`, `CharID`) USING BTREE,
  UNIQUE INDEX `CharID`(`CharID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of guild_members
-- ----------------------------

-- ----------------------------
-- Table structure for guilds
-- ----------------------------
DROP TABLE IF EXISTS `guilds`;
CREATE TABLE `guilds`  (
  `GuildID` int(10) UNSIGNED NOT NULL,
  `GuildName` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `GuildMaster` int(10) UNSIGNED NOT NULL,
  `GuildSecondMaster` int(10) UNSIGNED NOT NULL DEFAULT 4294967295,
  `GuildSecondMaster2` int(10) UNSIGNED NOT NULL DEFAULT 4294967295,
  `GuildSecondMaster3` int(10) UNSIGNED NOT NULL DEFAULT 4294967295,
  `GuildSecondMaster4` int(10) UNSIGNED NOT NULL DEFAULT 4294967295,
  `GuildReputation` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `GuildPointEver` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'max guild points ever received',
  `FunctionFlag` bigint(20) UNSIGNED NOT NULL DEFAULT 7,
  `GuildDisbandTime` int(10) UNSIGNED NULL DEFAULT NULL,
  `MarkInColor` tinyint(3) UNSIGNED NOT NULL DEFAULT 255,
  `MarkInLine` tinyint(3) UNSIGNED NOT NULL DEFAULT 255,
  `MarkMain` tinyint(3) UNSIGNED NOT NULL DEFAULT 255,
  `MarkMainColor` tinyint(3) UNSIGNED NOT NULL DEFAULT 255,
  `MarkOutColor` tinyint(3) UNSIGNED NOT NULL DEFAULT 255,
  `MarkOutLine` tinyint(3) UNSIGNED NOT NULL DEFAULT 255,
  `NoticeBy` varchar(16) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `GuildNotice` varchar(257) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `DojoColor` tinyint(3) UNSIGNED NOT NULL DEFAULT 255,
  `GuildColor` tinyint(3) UNSIGNED NOT NULL DEFAULT 255,
  `DogiType` tinyint(3) UNSIGNED NOT NULL DEFAULT 255,
  `Zeni` int(10) UNSIGNED NULL DEFAULT 0 COMMENT 'Zeni inside guild bank',
  `MarkMainBind` tinyint(3) UNSIGNED NULL DEFAULT 0,
  PRIMARY KEY (`GuildID`, `GuildName`) USING BTREE,
  UNIQUE INDEX `GuildID`(`GuildID`) USING BTREE,
  UNIQUE INDEX `GuildName`(`GuildName`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of guilds
-- ----------------------------

-- ----------------------------
-- Table structure for hoipoi_recipe
-- ----------------------------
DROP TABLE IF EXISTS `hoipoi_recipe`;
CREATE TABLE `hoipoi_recipe`  (
  `CharID` int(10) UNSIGNED NOT NULL,
  `RecipeTblidx` int(10) UNSIGNED NOT NULL,
  `RecipeType` tinyint(3) UNSIGNED NOT NULL DEFAULT 255,
  PRIMARY KEY (`CharID`, `RecipeTblidx`) USING BTREE,
  UNIQUE INDEX `CharID_2`(`CharID`, `RecipeTblidx`) USING BTREE,
  INDEX `CharID`(`CharID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hoipoi_recipe
-- ----------------------------

-- ----------------------------
-- Table structure for htb_skills
-- ----------------------------
DROP TABLE IF EXISTS `htb_skills`;
CREATE TABLE `htb_skills`  (
  `skill_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `owner_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `SlotID` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `TimeRemaining` int(10) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`skill_id`, `owner_id`) USING BTREE,
  UNIQUE INDEX `skill_id`(`skill_id`, `owner_id`) USING BTREE,
  UNIQUE INDEX `owner_id`(`owner_id`, `SlotID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of htb_skills
-- ----------------------------

-- ----------------------------
-- Table structure for items
-- ----------------------------
DROP TABLE IF EXISTS `items`;
CREATE TABLE `items`  (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tblidx` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `owner_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'character id',
  `place` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `pos` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `count` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `rank` tinyint(4) NOT NULL DEFAULT 1,
  `durability` tinyint(3) UNSIGNED NOT NULL DEFAULT 255,
  `grade` tinyint(4) NOT NULL DEFAULT 0,
  `NeedToIdentify` tinyint(1) NOT NULL DEFAULT 0,
  `BattleAttribute` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `Maker` varchar(16) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `OptionTblidx` int(10) UNSIGNED NOT NULL DEFAULT 4294967295 COMMENT 'item_option_data tblidx',
  `OptionTblidx2` int(10) UNSIGNED NOT NULL DEFAULT 4294967295 COMMENT 'item_option_data tblidx',
  `OptionRandomId` smallint(5) UNSIGNED NOT NULL DEFAULT 65535 COMMENT 'item_enchant tblidx',
  `OptionRandomVal` int(10) UNSIGNED NOT NULL DEFAULT 4294967295,
  `OptionRandomId2` smallint(5) UNSIGNED NOT NULL DEFAULT 65535,
  `OptionRandomVal2` int(10) UNSIGNED NOT NULL DEFAULT 4294967295,
  `OptionRandomId3` smallint(5) UNSIGNED NOT NULL DEFAULT 65535,
  `OptionRandomVal3` int(10) UNSIGNED NOT NULL DEFAULT 4294967295,
  `OptionRandomId4` smallint(5) UNSIGNED NOT NULL DEFAULT 65535,
  `OptionRandomVal4` int(10) UNSIGNED NOT NULL DEFAULT 4294967295,
  `OptionRandomId5` smallint(5) UNSIGNED NOT NULL DEFAULT 65535,
  `OptionRandomVal5` int(10) UNSIGNED NOT NULL DEFAULT 4294967295,
  `OptionRandomId6` smallint(5) UNSIGNED NOT NULL DEFAULT 65535,
  `OptionRandomVal6` int(10) UNSIGNED NOT NULL DEFAULT 4294967295,
  `OptionRandomId7` smallint(5) UNSIGNED NOT NULL DEFAULT 65535,
  `OptionRandomVal7` int(10) UNSIGNED NOT NULL DEFAULT 4294967295,
  `OptionRandomId8` smallint(5) UNSIGNED NOT NULL DEFAULT 65535,
  `OptionRandomVal8` int(10) UNSIGNED NOT NULL DEFAULT 4294967295,
  `UseStartTime` bigint(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'max duration time (3600 = 60 minutes)',
  `UseEndTime` bigint(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'current duration time (3600 = 60 minutes)',
  `RestrictState` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `DurationType` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `AccountID` int(10) UNSIGNED NULL DEFAULT 0,
  `GuildID` int(10) UNSIGNED NULL DEFAULT 0,
  `Lucky` int(10) UNSIGNED NULL DEFAULT 0,
  `Broken` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '0正常 数字代码charid',
  `Broken_time` timestamp(0) NULL DEFAULT '2000-01-01 00:00:00',
  `date` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`, `owner_id`, `place`, `pos`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE,
  INDEX `owner_id_idx`(`owner_id`) USING BTREE,
  INDEX `item_vnum_index`(`tblidx`) USING BTREE,
  INDEX `owner_id`(`owner_id`, `place`, `pos`) USING BTREE,
  INDEX `owner_id_2`(`owner_id`, `place`) USING BTREE,
  INDEX `AccountID`(`AccountID`) USING BTREE,
  INDEX `GuildID`(`GuildID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of items
-- ----------------------------

-- ----------------------------
-- Table structure for items_cd
-- ----------------------------
DROP TABLE IF EXISTS `items_cd`;
CREATE TABLE `items_cd`  (
  `CharID` int(10) UNSIGNED NOT NULL,
  `GroupIndex` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `CoolTime` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `TimeRemaining` int(10) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`GroupIndex`, `CharID`) USING BTREE,
  UNIQUE INDEX `CharID`(`CharID`, `GroupIndex`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of items_cd
-- ----------------------------

-- ----------------------------
-- Table structure for mail
-- ----------------------------
DROP TABLE IF EXISTS `mail`;
CREATE TABLE `mail`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
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
  `system` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '系统邮件默认0\r\n',
  `count` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`, `CharID`) USING BTREE,
  UNIQUE INDEX `id_2`(`id`) USING BTREE,
  INDEX `CharID`(`CharID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2453723 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mail
-- ----------------------------

-- ----------------------------
-- Table structure for mall_order
-- ----------------------------
DROP TABLE IF EXISTS `mall_order`;
CREATE TABLE `mall_order`  (
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mall_order
-- ----------------------------

-- ----------------------------
-- Table structure for mascots
-- ----------------------------
DROP TABLE IF EXISTS `mascots`;
CREATE TABLE `mascots`  (
  `CharID` int(10) UNSIGNED NOT NULL,
  `SlotID` tinyint(3) UNSIGNED NOT NULL DEFAULT 255 COMMENT 'index',
  `MascotTblidx` int(10) UNSIGNED NOT NULL,
  `CurVP` int(10) UNSIGNED NOT NULL DEFAULT 100,
  `MaxVP` int(10) UNSIGNED NOT NULL DEFAULT 100,
  `CurExp` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `skillTblidx0` int(10) UNSIGNED NOT NULL DEFAULT 4294967295,
  `skillTblidx1` int(10) UNSIGNED NOT NULL DEFAULT 4294967295,
  `skillTblidx2` int(10) UNSIGNED NOT NULL DEFAULT 4294967295,
  `skillTblidx3` int(10) UNSIGNED NOT NULL DEFAULT 4294967295,
  PRIMARY KEY (`CharID`, `SlotID`) USING BTREE,
  UNIQUE INDEX `CharID`(`CharID`, `SlotID`) USING BTREE,
  INDEX `CharID_2`(`CharID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mascots
-- ----------------------------

-- ----------------------------
-- Table structure for portals
-- ----------------------------
DROP TABLE IF EXISTS `portals`;
CREATE TABLE `portals`  (
  `CharID` int(10) UNSIGNED NOT NULL,
  `Point` tinyint(3) UNSIGNED NOT NULL,
  PRIMARY KEY (`CharID`, `Point`) USING BTREE,
  UNIQUE INDEX `CharID_2`(`CharID`, `Point`) USING BTREE,
  INDEX `CharID`(`CharID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of portals
-- ----------------------------

-- ----------------------------
-- Table structure for questitems
-- ----------------------------
DROP TABLE IF EXISTS `questitems`;
CREATE TABLE `questitems`  (
  `CharID` int(10) UNSIGNED NOT NULL,
  `tblidx` int(10) UNSIGNED NOT NULL,
  `amount` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `pos` tinyint(3) UNSIGNED NOT NULL DEFAULT 255,
  INDEX `CharID_2`(`CharID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of questitems
-- ----------------------------

-- ----------------------------
-- Table structure for quests
-- ----------------------------
DROP TABLE IF EXISTS `quests`;
CREATE TABLE `quests`  (
  `CharID` int(10) UNSIGNED NOT NULL,
  `QuestID` int(10) UNSIGNED NOT NULL,
  `tcQuestInfo` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `taQuestInfo` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `tgExcCGroup` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `tcPreId` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `tcCurId` tinyint(3) UNSIGNED NOT NULL DEFAULT 255,
  `tcId` tinyint(3) UNSIGNED NOT NULL DEFAULT 255,
  `taId` tinyint(3) UNSIGNED NOT NULL DEFAULT 255,
  `evtUserData` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `evtUserData2` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `evtUserData3` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `evtUserData4` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `tcTimeInfo` tinyint(3) UNSIGNED NOT NULL DEFAULT 255,
  `taTimeInfo` tinyint(3) UNSIGNED NOT NULL DEFAULT 255,
  `TimeLeft` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `QState` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`CharID`, `QuestID`) USING BTREE,
  UNIQUE INDEX `CharID_2`(`CharID`, `QuestID`) USING BTREE,
  INDEX `CharID`(`CharID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of quests
-- ----------------------------

-- ----------------------------
-- Table structure for quick_teleport
-- ----------------------------
DROP TABLE IF EXISTS `quick_teleport`;
CREATE TABLE `quick_teleport`  (
  `CharID` int(10) UNSIGNED NOT NULL,
  `SlotNum` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `WorldTblidx` int(10) UNSIGNED NOT NULL,
  `LocX` float(11, 6) NOT NULL,
  `LocY` float(11, 6) NOT NULL,
  `LocZ` float(11, 6) NOT NULL,
  `MapNameTblidx` int(10) UNSIGNED NOT NULL,
  `day` tinyint(3) UNSIGNED NOT NULL,
  `hour` tinyint(3) UNSIGNED NOT NULL,
  `minute` tinyint(3) UNSIGNED NOT NULL,
  `month` tinyint(3) UNSIGNED NOT NULL,
  `second` tinyint(3) UNSIGNED NOT NULL,
  `year` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`CharID`, `SlotNum`) USING BTREE,
  UNIQUE INDEX `CharID`(`CharID`, `SlotNum`) USING BTREE,
  INDEX `CharID_2`(`CharID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of quick_teleport
-- ----------------------------

-- ----------------------------
-- Table structure for quickslot
-- ----------------------------
DROP TABLE IF EXISTS `quickslot`;
CREATE TABLE `quickslot`  (
  `CharID` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `Tblidx` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `Slot` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `Type` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `Item` bigint(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'item unique id',
  PRIMARY KEY (`CharID`, `Slot`) USING BTREE,
  UNIQUE INDEX `CharID`(`CharID`, `Slot`) USING BTREE,
  INDEX `CharID_2`(`CharID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of quickslot
-- ----------------------------

-- ----------------------------
-- Table structure for rank_battle
-- ----------------------------
DROP TABLE IF EXISTS `rank_battle`;
CREATE TABLE `rank_battle`  (
  `CharID` int(10) UNSIGNED NOT NULL,
  `Win` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `Draw` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `Lose` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `StraightKOWin` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `MaxStraightKOWin` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `MaxStraightWin` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `StraightWin` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `Points` float(10, 0) NOT NULL DEFAULT 0,
  PRIMARY KEY (`CharID`) USING BTREE,
  UNIQUE INDEX `CharID`(`CharID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rank_battle
-- ----------------------------

-- ----------------------------
-- Table structure for reset_time
-- ----------------------------
DROP TABLE IF EXISTS `reset_time`;
CREATE TABLE `reset_time`  (
  `ResetTime` bigint(20) UNSIGNED NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reset_time
-- ----------------------------

-- ----------------------------
-- Table structure for skills
-- ----------------------------
DROP TABLE IF EXISTS `skills`;
CREATE TABLE `skills`  (
  `skill_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `owner_id` int(10) UNSIGNED NOT NULL,
  `RpBonusAuto` tinyint(1) NOT NULL DEFAULT 0,
  `RpBonusType` tinyint(3) UNSIGNED NOT NULL DEFAULT 255,
  `SlotID` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'skillIndex',
  `TimeRemaining` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Skill CD Time',
  `Exp` int(10) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`owner_id`, `SlotID`) USING BTREE,
  UNIQUE INDEX `owner_id`(`owner_id`, `SlotID`) USING BTREE,
  INDEX `owner_id_2`(`owner_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of skills
-- ----------------------------

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `CharID` int(10) UNSIGNED NOT NULL,
  `TeacherID` int(10) UNSIGNED NOT NULL,
  `state` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `timestamp` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  `graduationtime` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `CharID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 305 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of teacher
-- ----------------------------

-- ----------------------------
-- Table structure for titles
-- ----------------------------
DROP TABLE IF EXISTS `titles`;
CREATE TABLE `titles`  (
  `CharID` int(10) UNSIGNED NOT NULL,
  `TitleTblidx` int(10) UNSIGNED NOT NULL,
  `date` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  `tmEndTimes` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`CharID`, `TitleTblidx`) USING BTREE,
  UNIQUE INDEX `CharID_2`(`CharID`, `TitleTblidx`) USING BTREE,
  INDEX `CharID`(`CharID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of titles
-- ----------------------------

-- ----------------------------
-- Table structure for warfog
-- ----------------------------
DROP TABLE IF EXISTS `warfog`;
CREATE TABLE `warfog`  (
  `CharID` int(10) UNSIGNED NOT NULL,
  `WarFog` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`CharID`, `WarFog`) USING BTREE,
  UNIQUE INDEX `CharID_2`(`CharID`, `WarFog`) USING BTREE,
  INDEX `CharID`(`CharID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of warfog
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
