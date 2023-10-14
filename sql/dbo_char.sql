/*
 Navicat Premium Data Transfer

 Source Server         : 本机
 Source Server Type    : MySQL
 Source Server Version : 80034 (8.0.34)
 Source Host           : localhost:3306
 Source Schema         : dbo_char

 Target Server Type    : MySQL
 Target Server Version : 80034 (8.0.34)
 File Encoding         : 65001

 Date: 14/10/2023 10:51:44
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auctionhouse
-- ----------------------------
DROP TABLE IF EXISTS `auctionhouse`;
CREATE TABLE `auctionhouse`  (
  `id` bigint UNSIGNED NOT NULL,
  `CharID` int UNSIGNED NOT NULL DEFAULT 0,
  `TabType` tinyint UNSIGNED NOT NULL DEFAULT 255,
  `ItemName` varchar(33) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Seller` varchar(17) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Price` int UNSIGNED NOT NULL,
  `ItemID` bigint UNSIGNED NOT NULL,
  `TimeStart` int UNSIGNED NOT NULL,
  `TimeEnd` int UNSIGNED NULL DEFAULT NULL COMMENT 'time in seconds',
  `ItemLevel` tinyint UNSIGNED NOT NULL DEFAULT 0,
  `NeedClass` int UNSIGNED NOT NULL,
  `ItemType` tinyint UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`, `CharID`) USING BTREE,
  UNIQUE INDEX `id`(`id` ASC) USING BTREE,
  INDEX `CharID`(`CharID` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bannword
-- ----------------------------
DROP TABLE IF EXISTS `bannword`;
CREATE TABLE `bannword`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `bannword` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bind
-- ----------------------------
DROP TABLE IF EXISTS `bind`;
CREATE TABLE `bind`  (
  `CharID` int UNSIGNED NOT NULL,
  `WorldID` int UNSIGNED NOT NULL DEFAULT 1,
  `BindObjectTblIdx` int UNSIGNED NOT NULL DEFAULT 4294967295,
  `LocX` float(11, 6) NOT NULL,
  `LocY` float(11, 6) NOT NULL,
  `LocZ` float(11, 6) NOT NULL,
  `DirX` float(11, 6) NOT NULL,
  `DirY` float(11, 6) NOT NULL,
  `DirZ` float(11, 6) NOT NULL,
  `Type` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`CharID`) USING BTREE,
  UNIQUE INDEX `CharID`(`CharID` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for buffs
-- ----------------------------
DROP TABLE IF EXISTS `buffs`;
CREATE TABLE `buffs`  (
  `CharID` int UNSIGNED NOT NULL,
  `SourceTblidx` int UNSIGNED NOT NULL,
  `SourceType` tinyint UNSIGNED NOT NULL DEFAULT 255 COMMENT '0 skill and 1 item',
  `BuffIndex` tinyint UNSIGNED NOT NULL DEFAULT 255,
  `BuffGroup` tinyint UNSIGNED NOT NULL DEFAULT 255,
  `InitialDuration` int UNSIGNED NOT NULL DEFAULT 0,
  `TimeRemaining` int UNSIGNED NOT NULL DEFAULT 0,
  `effectValue1` double(10, 2) NULL DEFAULT NULL,
  `effectValue2` double(10, 2) NULL DEFAULT NULL,
  `Argument1_0` int UNSIGNED NULL DEFAULT NULL COMMENT 'commonConfigTblidx',
  `Argument1_1` int UNSIGNED NULL DEFAULT NULL COMMENT 'dwRemainTime',
  `Argument1_2` int UNSIGNED NULL DEFAULT NULL COMMENT 'dwRemainValue',
  `Argument2_0` int UNSIGNED NULL DEFAULT NULL COMMENT 'commonConfigTblidx',
  `Argument2_1` int UNSIGNED NULL DEFAULT NULL COMMENT 'dwRemainTime',
  `Argument2_2` int UNSIGNED NULL DEFAULT NULL COMMENT 'dwRemainValue',
  PRIMARY KEY (`CharID`, `BuffIndex`) USING BTREE,
  UNIQUE INDEX `CharID`(`CharID` ASC, `BuffIndex` ASC) USING BTREE,
  INDEX `CharID_2`(`CharID` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for characters
-- ----------------------------
DROP TABLE IF EXISTS `characters`;
CREATE TABLE `characters`  (
  `CharID` int UNSIGNED NOT NULL,
  `CharName` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `AccountID` int UNSIGNED NOT NULL,
  `Level` tinyint UNSIGNED NOT NULL DEFAULT 1,
  `Exp` int UNSIGNED NOT NULL DEFAULT 0,
  `Race` tinyint UNSIGNED NULL DEFAULT NULL,
  `Class` tinyint UNSIGNED NULL DEFAULT NULL,
  `Gender` tinyint UNSIGNED NULL DEFAULT NULL,
  `Face` tinyint UNSIGNED NULL DEFAULT NULL,
  `Adult` tinyint UNSIGNED NOT NULL DEFAULT 0,
  `Hair` tinyint UNSIGNED NOT NULL,
  `HairColor` tinyint UNSIGNED NOT NULL DEFAULT 0,
  `SkinColor` tinyint UNSIGNED NOT NULL DEFAULT 0,
  `Blood` tinyint UNSIGNED NOT NULL DEFAULT 0,
  `CurLocX` float(11, 6) NOT NULL DEFAULT 78.000000,
  `CurLocY` float(11, 6) NOT NULL DEFAULT 46.000000,
  `CurLocZ` float(11, 6) NOT NULL DEFAULT 168.000000,
  `CurDirX` float(11, 6) NOT NULL DEFAULT 0.000000,
  `CurDirY` float(11, 6) NOT NULL DEFAULT 0.000000,
  `CurDirZ` float(11, 6) NOT NULL DEFAULT 0.000000,
  `WorldID` int UNSIGNED NOT NULL DEFAULT 1,
  `WorldTable` int UNSIGNED NOT NULL DEFAULT 1,
  `MapInfoIndex` int UNSIGNED NOT NULL DEFAULT 0,
  `Money` int UNSIGNED NOT NULL DEFAULT 2333,
  `MoneyBank` int UNSIGNED NOT NULL DEFAULT 0,
  `TutorialFlag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 = start tutorial / 1 = dont start tutorial',
  `TutorialHint` int UNSIGNED NOT NULL DEFAULT 0,
  `NameChange` tinyint(1) NOT NULL DEFAULT 0,
  `Reputation` int UNSIGNED NOT NULL DEFAULT 0,
  `MudosaPoint` int UNSIGNED NOT NULL DEFAULT 0,
  `SpPoint` int UNSIGNED NOT NULL DEFAULT 0 COMMENT 'skill points',
  `GameMaster` tinyint(1) NOT NULL DEFAULT 1,
  `GuildID` int UNSIGNED NOT NULL DEFAULT 0,
  `GuildName` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `CurLP` int NOT NULL DEFAULT 15000,
  `CurEP` smallint UNSIGNED NOT NULL DEFAULT 15000,
  `CurRP` smallint UNSIGNED NOT NULL DEFAULT 0,
  `CurAP` int NOT NULL DEFAULT 450000,
  `MailIsAway` tinyint(1) NOT NULL DEFAULT 0,
  `SrvFarmID` int UNSIGNED NOT NULL DEFAULT 0,
  `DelCharTime` bigint UNSIGNED NULL DEFAULT NULL COMMENT 'time(0) + 43200 = 12 hours',
  `Hoipoi_NormalStart` tinyint(1) NOT NULL DEFAULT 0,
  `Hoipoi_SpecialStart` tinyint(1) NOT NULL DEFAULT 0,
  `Hoipoi_Type` tinyint UNSIGNED NOT NULL DEFAULT 255,
  `Hoipoi_MixLevel` tinyint UNSIGNED NOT NULL DEFAULT 30,
  `Hoipoi_MixExp` int UNSIGNED NOT NULL DEFAULT 0,
  `Title` int UNSIGNED NOT NULL DEFAULT 4294967295,
  `Mascot` int UNSIGNED NOT NULL DEFAULT 4294967295,
  `RpBall` tinyint UNSIGNED NOT NULL DEFAULT 0,
  `Netpy` int UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Netpy are points the user receives while staying online',
  `WaguPoint` int UNSIGNED NOT NULL DEFAULT 0,
  `IP` varchar(16) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '0.0.0.0' COMMENT 'the last IP in the char',
  `AirState` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '0 = off and 1 = on',
  `InvisibleCostume` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 = false 1 = true',
  `PlayTime` bigint UNSIGNED NOT NULL DEFAULT 0 COMMENT 'play time in seconds',
  `SuperiorEffectType` tinyint UNSIGNED NOT NULL DEFAULT 0,
  `CreateTime` bigint UNSIGNED NOT NULL COMMENT 'time(0)',
  `Deleteip` varchar(64) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '0.0.0.0',
  `IsOnline` int NOT NULL DEFAULT 0,
  `ttime` bigint UNSIGNED NOT NULL DEFAULT 0,
  `TeacherID` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '师傅ID',
  `Activity` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '记录活跃程度，每月清空',
  `LastActivity` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '记录上月活跃值',
  `AddSpPoint` int UNSIGNED NOT NULL DEFAULT 0,
  `Sign` bigint UNSIGNED NOT NULL DEFAULT 0,
  `BlindBox` smallint UNSIGNED NOT NULL DEFAULT 0 COMMENT '记录使用盲盒的数量',
  `BlindBox_accumulate` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '累计数量',
  `is_get_card` tinyint NOT NULL DEFAULT 0 COMMENT '是否获取过补签卡(0：未获取 1：已获取)',
  PRIMARY KEY (`CharID`, `CharName`, `SrvFarmID`) USING BTREE,
  UNIQUE INDEX `CharID`(`CharID` ASC) USING BTREE,
  UNIQUE INDEX `CharName`(`CharName` ASC) USING BTREE,
  UNIQUE INDEX `CharID_2`(`CharID` ASC, `SrvFarmID` ASC) USING BTREE,
  UNIQUE INDEX `CharID_3`(`CharID` ASC, `AccountID` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for charextra
-- ----------------------------
DROP TABLE IF EXISTS `charextra`;
CREATE TABLE `charextra`  (
  `CharID` int UNSIGNED NOT NULL,
  `PhysicalOffencePA` tinyint UNSIGNED NULL DEFAULT 0,
  `PhysicalOffencePAEXP` smallint UNSIGNED NULL DEFAULT 0,
  `PhysicalOffencePAMAX` tinyint UNSIGNED NULL DEFAULT 20,
  `EnergyOffencePA` tinyint UNSIGNED NULL DEFAULT 0,
  `EnergyOffencePAEXP` smallint UNSIGNED NULL DEFAULT 0,
  `EnergyOffencePAMAX` tinyint UNSIGNED NULL DEFAULT 20,
  `PhysicalDefensePA` tinyint UNSIGNED NULL DEFAULT 0,
  `PhysicalDefensePAEXP` smallint UNSIGNED NULL DEFAULT 0,
  `PhysicalDefensePAMAX` tinyint UNSIGNED NULL DEFAULT 20,
  `EnergyDefensePA` tinyint UNSIGNED NULL DEFAULT 0,
  `EnergyDefensePAEXP` smallint UNSIGNED NULL DEFAULT 0,
  `EnergyDefensePAMAX` tinyint UNSIGNED NULL DEFAULT 20,
  `RentPAType` tinyint UNSIGNED NULL DEFAULT 0,
  `RentPALevel` tinyint UNSIGNED NULL DEFAULT 0,
  `tmEndTimesRentPA` bigint UNSIGNED NULL DEFAULT 0,
  PRIMARY KEY (`CharID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for charother
-- ----------------------------
DROP TABLE IF EXISTS `charother`;
CREATE TABLE `charother`  (
  `CharID` int UNSIGNED NOT NULL,
  `Return_Zeni` int UNSIGNED NULL DEFAULT 0,
  `everyDayReward` int UNSIGNED NULL DEFAULT 0,
  `Last_Return_time` bigint UNSIGNED NULL DEFAULT 0,
  PRIMARY KEY (`CharID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for dojos
-- ----------------------------
DROP TABLE IF EXISTS `dojos`;
CREATE TABLE `dojos`  (
  `GuildId` int UNSIGNED NOT NULL,
  `DojoTblidx` int UNSIGNED NOT NULL,
  `Level` tinyint UNSIGNED NOT NULL DEFAULT 1,
  `PeaceStatus` tinyint UNSIGNED NOT NULL DEFAULT 0,
  `PeacePoints` int UNSIGNED NOT NULL DEFAULT 0,
  `GuildName` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `LeaderName` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Notice` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `ChallengeGuildId` int UNSIGNED NOT NULL DEFAULT 4294967295,
  `SeedCharName` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`DojoTblidx`) USING BTREE,
  UNIQUE INDEX `DojoTblidx`(`DojoTblidx` ASC) USING BTREE,
  UNIQUE INDEX `GuildId`(`GuildId` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for friendlist
-- ----------------------------
DROP TABLE IF EXISTS `friendlist`;
CREATE TABLE `friendlist`  (
  `user_id` int UNSIGNED NOT NULL,
  `friend_id` int UNSIGNED NOT NULL,
  `friend_name` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `blacklist` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`user_id`, `friend_id`) USING BTREE,
  UNIQUE INDEX `user_id`(`user_id` ASC, `friend_id` ASC) USING BTREE,
  INDEX `user_id_2`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for guild_members
-- ----------------------------
DROP TABLE IF EXISTS `guild_members`;
CREATE TABLE `guild_members`  (
  `GuildID` int UNSIGNED NOT NULL,
  `CharID` int UNSIGNED NOT NULL,
  PRIMARY KEY (`GuildID`, `CharID`) USING BTREE,
  UNIQUE INDEX `GuildID`(`GuildID` ASC, `CharID` ASC) USING BTREE,
  UNIQUE INDEX `CharID`(`CharID` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for guilds
-- ----------------------------
DROP TABLE IF EXISTS `guilds`;
CREATE TABLE `guilds`  (
  `GuildID` int UNSIGNED NOT NULL,
  `GuildName` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `GuildMaster` int UNSIGNED NOT NULL,
  `GuildSecondMaster` int UNSIGNED NOT NULL DEFAULT 4294967295,
  `GuildSecondMaster2` int UNSIGNED NOT NULL DEFAULT 4294967295,
  `GuildSecondMaster3` int UNSIGNED NOT NULL DEFAULT 4294967295,
  `GuildSecondMaster4` int UNSIGNED NOT NULL DEFAULT 4294967295,
  `GuildReputation` int UNSIGNED NOT NULL DEFAULT 0,
  `GuildPointEver` int UNSIGNED NOT NULL DEFAULT 0 COMMENT 'max guild points ever received',
  `FunctionFlag` bigint UNSIGNED NOT NULL DEFAULT 7,
  `GuildDisbandTime` int UNSIGNED NULL DEFAULT NULL,
  `MarkInColor` tinyint UNSIGNED NOT NULL DEFAULT 255,
  `MarkInLine` tinyint UNSIGNED NOT NULL DEFAULT 255,
  `MarkMain` tinyint UNSIGNED NOT NULL DEFAULT 255,
  `MarkMainColor` tinyint UNSIGNED NOT NULL DEFAULT 255,
  `MarkOutColor` tinyint UNSIGNED NOT NULL DEFAULT 255,
  `MarkOutLine` tinyint UNSIGNED NOT NULL DEFAULT 255,
  `NoticeBy` varchar(16) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `GuildNotice` varchar(257) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `DojoColor` tinyint UNSIGNED NOT NULL DEFAULT 255,
  `GuildColor` tinyint UNSIGNED NOT NULL DEFAULT 255,
  `DogiType` tinyint UNSIGNED NOT NULL DEFAULT 255,
  `Zeni` int UNSIGNED NULL DEFAULT 0 COMMENT 'Zeni inside guild bank',
  `MarkMainBind` tinyint UNSIGNED NULL DEFAULT 0,
  PRIMARY KEY (`GuildID`, `GuildName`) USING BTREE,
  UNIQUE INDEX `GuildID`(`GuildID` ASC) USING BTREE,
  UNIQUE INDEX `GuildName`(`GuildName` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for hoipoi_recipe
-- ----------------------------
DROP TABLE IF EXISTS `hoipoi_recipe`;
CREATE TABLE `hoipoi_recipe`  (
  `CharID` int UNSIGNED NOT NULL,
  `RecipeTblidx` int UNSIGNED NOT NULL,
  `RecipeType` tinyint UNSIGNED NOT NULL DEFAULT 255,
  PRIMARY KEY (`CharID`, `RecipeTblidx`) USING BTREE,
  UNIQUE INDEX `CharID_2`(`CharID` ASC, `RecipeTblidx` ASC) USING BTREE,
  INDEX `CharID`(`CharID` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for htb_skills
-- ----------------------------
DROP TABLE IF EXISTS `htb_skills`;
CREATE TABLE `htb_skills`  (
  `skill_id` int UNSIGNED NOT NULL DEFAULT 0,
  `owner_id` int UNSIGNED NOT NULL DEFAULT 0,
  `SlotID` smallint UNSIGNED NOT NULL DEFAULT 0,
  `TimeRemaining` int UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`skill_id`, `owner_id`) USING BTREE,
  UNIQUE INDEX `skill_id`(`skill_id` ASC, `owner_id` ASC) USING BTREE,
  UNIQUE INDEX `owner_id`(`owner_id` ASC, `SlotID` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for items
-- ----------------------------
DROP TABLE IF EXISTS `items`;
CREATE TABLE `items`  (
  `id` bigint UNSIGNED NOT NULL,
  `tblidx` int UNSIGNED NOT NULL DEFAULT 0,
  `owner_id` int UNSIGNED NOT NULL DEFAULT 0 COMMENT 'character id',
  `place` tinyint UNSIGNED NOT NULL DEFAULT 1,
  `pos` tinyint UNSIGNED NOT NULL DEFAULT 0,
  `count` tinyint UNSIGNED NOT NULL DEFAULT 1,
  `rank` tinyint NOT NULL DEFAULT 1,
  `durability` tinyint UNSIGNED NOT NULL DEFAULT 255,
  `grade` tinyint NOT NULL DEFAULT 0,
  `NeedToIdentify` tinyint(1) NOT NULL DEFAULT 0,
  `BattleAttribute` tinyint UNSIGNED NOT NULL DEFAULT 0,
  `Maker` varchar(16) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `OptionTblidx` int UNSIGNED NOT NULL DEFAULT 4294967295 COMMENT 'item_option_data tblidx',
  `OptionTblidx2` int UNSIGNED NOT NULL DEFAULT 4294967295 COMMENT 'item_option_data tblidx',
  `OptionRandomId` smallint UNSIGNED NOT NULL DEFAULT 65535 COMMENT 'item_enchant tblidx',
  `OptionRandomVal` int UNSIGNED NOT NULL DEFAULT 4294967295,
  `OptionRandomId2` smallint UNSIGNED NOT NULL DEFAULT 65535,
  `OptionRandomVal2` int UNSIGNED NOT NULL DEFAULT 4294967295,
  `OptionRandomId3` smallint UNSIGNED NOT NULL DEFAULT 65535,
  `OptionRandomVal3` int UNSIGNED NOT NULL DEFAULT 4294967295,
  `OptionRandomId4` smallint UNSIGNED NOT NULL DEFAULT 65535,
  `OptionRandomVal4` int UNSIGNED NOT NULL DEFAULT 4294967295,
  `OptionRandomId5` smallint UNSIGNED NOT NULL DEFAULT 65535,
  `OptionRandomVal5` int UNSIGNED NOT NULL DEFAULT 4294967295,
  `OptionRandomId6` smallint UNSIGNED NOT NULL DEFAULT 65535,
  `OptionRandomVal6` int UNSIGNED NOT NULL DEFAULT 4294967295,
  `OptionRandomId7` smallint UNSIGNED NOT NULL DEFAULT 65535,
  `OptionRandomVal7` int UNSIGNED NOT NULL DEFAULT 4294967295,
  `OptionRandomId8` smallint UNSIGNED NOT NULL DEFAULT 65535,
  `OptionRandomVal8` int UNSIGNED NOT NULL DEFAULT 4294967295,
  `UseStartTime` bigint UNSIGNED NOT NULL DEFAULT 0 COMMENT 'max duration time (3600 = 60 minutes)',
  `UseEndTime` bigint UNSIGNED NOT NULL DEFAULT 0 COMMENT 'current duration time (3600 = 60 minutes)',
  `RestrictState` tinyint UNSIGNED NOT NULL DEFAULT 0,
  `DurationType` tinyint UNSIGNED NOT NULL DEFAULT 0,
  `AccountID` int UNSIGNED NULL DEFAULT 0,
  `GuildID` int UNSIGNED NULL DEFAULT 0,
  `Lucky` int UNSIGNED NULL DEFAULT 0,
  `Broken` int UNSIGNED NULL DEFAULT 0 COMMENT '0正常 数字代码charid',
  `Broken_time` timestamp NULL DEFAULT '1999-12-31 16:00:00',
  `date` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`, `owner_id`, `place`, `pos`) USING BTREE,
  UNIQUE INDEX `id`(`id` ASC) USING BTREE,
  INDEX `owner_id_idx`(`owner_id` ASC) USING BTREE,
  INDEX `item_vnum_index`(`tblidx` ASC) USING BTREE,
  INDEX `owner_id`(`owner_id` ASC, `place` ASC, `pos` ASC) USING BTREE,
  INDEX `owner_id_2`(`owner_id` ASC, `place` ASC) USING BTREE,
  INDEX `AccountID`(`AccountID` ASC) USING BTREE,
  INDEX `GuildID`(`GuildID` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for items_cd
-- ----------------------------
DROP TABLE IF EXISTS `items_cd`;
CREATE TABLE `items_cd`  (
  `CharID` int UNSIGNED NOT NULL,
  `GroupIndex` tinyint UNSIGNED NOT NULL DEFAULT 0,
  `CoolTime` int UNSIGNED NOT NULL DEFAULT 0,
  `TimeRemaining` int UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`GroupIndex`, `CharID`) USING BTREE,
  UNIQUE INDEX `CharID`(`CharID` ASC, `GroupIndex` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for mail
-- ----------------------------
DROP TABLE IF EXISTS `mail`;
CREATE TABLE `mail`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
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
  `system` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '系统邮件默认0\r\n',
  `count` tinyint UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id` ASC, `CharID` ASC) USING BTREE,
  UNIQUE INDEX `id_2`(`id` ASC) USING BTREE,
  INDEX `CharID`(`CharID` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for mall_order
-- ----------------------------
DROP TABLE IF EXISTS `mall_order`;
CREATE TABLE `mall_order`  (
  `id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for mascots
-- ----------------------------
DROP TABLE IF EXISTS `mascots`;
CREATE TABLE `mascots`  (
  `CharID` int UNSIGNED NOT NULL,
  `SlotID` tinyint UNSIGNED NOT NULL DEFAULT 255 COMMENT 'index',
  `MascotTblidx` int UNSIGNED NOT NULL,
  `CurVP` int UNSIGNED NOT NULL DEFAULT 100,
  `MaxVP` int UNSIGNED NOT NULL DEFAULT 100,
  `CurExp` int UNSIGNED NOT NULL DEFAULT 0,
  `skillTblidx0` int UNSIGNED NOT NULL DEFAULT 4294967295,
  `skillTblidx1` int UNSIGNED NOT NULL DEFAULT 4294967295,
  `skillTblidx2` int UNSIGNED NOT NULL DEFAULT 4294967295,
  `skillTblidx3` int UNSIGNED NOT NULL DEFAULT 4294967295,
  PRIMARY KEY (`CharID`, `SlotID`) USING BTREE,
  UNIQUE INDEX `CharID`(`CharID` ASC, `SlotID` ASC) USING BTREE,
  INDEX `CharID_2`(`CharID` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for portals
-- ----------------------------
DROP TABLE IF EXISTS `portals`;
CREATE TABLE `portals`  (
  `CharID` int UNSIGNED NOT NULL,
  `Point` tinyint UNSIGNED NOT NULL,
  PRIMARY KEY (`CharID`, `Point`) USING BTREE,
  UNIQUE INDEX `CharID_2`(`CharID` ASC, `Point` ASC) USING BTREE,
  INDEX `CharID`(`CharID` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for questitems
-- ----------------------------
DROP TABLE IF EXISTS `questitems`;
CREATE TABLE `questitems`  (
  `CharID` int UNSIGNED NOT NULL,
  `tblidx` int UNSIGNED NOT NULL,
  `amount` tinyint UNSIGNED NOT NULL DEFAULT 1,
  `pos` tinyint UNSIGNED NOT NULL DEFAULT 255,
  INDEX `CharID_2`(`CharID` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for quests
-- ----------------------------
DROP TABLE IF EXISTS `quests`;
CREATE TABLE `quests`  (
  `CharID` int UNSIGNED NOT NULL,
  `QuestID` int UNSIGNED NOT NULL,
  `tcQuestInfo` tinyint UNSIGNED NOT NULL DEFAULT 1,
  `taQuestInfo` tinyint UNSIGNED NOT NULL DEFAULT 0,
  `tgExcCGroup` tinyint UNSIGNED NOT NULL DEFAULT 0,
  `tcPreId` tinyint UNSIGNED NOT NULL DEFAULT 0,
  `tcCurId` tinyint UNSIGNED NOT NULL DEFAULT 255,
  `tcId` tinyint UNSIGNED NOT NULL DEFAULT 255,
  `taId` tinyint UNSIGNED NOT NULL DEFAULT 255,
  `evtUserData` int UNSIGNED NOT NULL DEFAULT 0,
  `evtUserData2` int UNSIGNED NOT NULL DEFAULT 0,
  `evtUserData3` int UNSIGNED NOT NULL DEFAULT 0,
  `evtUserData4` int UNSIGNED NOT NULL DEFAULT 0,
  `tcTimeInfo` tinyint UNSIGNED NOT NULL DEFAULT 255,
  `taTimeInfo` tinyint UNSIGNED NOT NULL DEFAULT 255,
  `TimeLeft` int UNSIGNED NOT NULL DEFAULT 0,
  `QState` smallint UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`CharID`, `QuestID`) USING BTREE,
  UNIQUE INDEX `CharID_2`(`CharID` ASC, `QuestID` ASC) USING BTREE,
  INDEX `CharID`(`CharID` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for quick_teleport
-- ----------------------------
DROP TABLE IF EXISTS `quick_teleport`;
CREATE TABLE `quick_teleport`  (
  `CharID` int UNSIGNED NOT NULL,
  `SlotNum` tinyint UNSIGNED NOT NULL DEFAULT 0,
  `WorldTblidx` int UNSIGNED NOT NULL,
  `LocX` float(11, 6) NOT NULL,
  `LocY` float(11, 6) NOT NULL,
  `LocZ` float(11, 6) NOT NULL,
  `MapNameTblidx` int UNSIGNED NOT NULL,
  `day` tinyint UNSIGNED NOT NULL,
  `hour` tinyint UNSIGNED NOT NULL,
  `minute` tinyint UNSIGNED NOT NULL,
  `month` tinyint UNSIGNED NOT NULL,
  `second` tinyint UNSIGNED NOT NULL,
  `year` int UNSIGNED NOT NULL,
  PRIMARY KEY (`CharID`, `SlotNum`) USING BTREE,
  UNIQUE INDEX `CharID`(`CharID` ASC, `SlotNum` ASC) USING BTREE,
  INDEX `CharID_2`(`CharID` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for quickslot
-- ----------------------------
DROP TABLE IF EXISTS `quickslot`;
CREATE TABLE `quickslot`  (
  `CharID` int UNSIGNED NOT NULL DEFAULT 0,
  `Tblidx` int UNSIGNED NOT NULL DEFAULT 0,
  `Slot` int UNSIGNED NOT NULL DEFAULT 0,
  `Type` tinyint UNSIGNED NOT NULL DEFAULT 0,
  `Item` bigint UNSIGNED NOT NULL DEFAULT 0 COMMENT 'item unique id',
  PRIMARY KEY (`CharID`, `Slot`) USING BTREE,
  UNIQUE INDEX `CharID`(`CharID` ASC, `Slot` ASC) USING BTREE,
  INDEX `CharID_2`(`CharID` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for rank_battle
-- ----------------------------
DROP TABLE IF EXISTS `rank_battle`;
CREATE TABLE `rank_battle`  (
  `CharID` int UNSIGNED NOT NULL,
  `Win` int UNSIGNED NOT NULL DEFAULT 0,
  `Draw` int UNSIGNED NOT NULL DEFAULT 0,
  `Lose` int UNSIGNED NOT NULL DEFAULT 0,
  `StraightKOWin` int UNSIGNED NOT NULL DEFAULT 0,
  `MaxStraightKOWin` int UNSIGNED NOT NULL DEFAULT 0,
  `MaxStraightWin` int UNSIGNED NOT NULL DEFAULT 0,
  `StraightWin` int UNSIGNED NOT NULL DEFAULT 0,
  `Points` float(10, 0) NOT NULL DEFAULT 0,
  PRIMARY KEY (`CharID`) USING BTREE,
  UNIQUE INDEX `CharID`(`CharID` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for reset_time
-- ----------------------------
DROP TABLE IF EXISTS `reset_time`;
CREATE TABLE `reset_time`  (
  `ResetTime` bigint UNSIGNED NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for skills
-- ----------------------------
DROP TABLE IF EXISTS `skills`;
CREATE TABLE `skills`  (
  `skill_id` int UNSIGNED NOT NULL DEFAULT 0,
  `owner_id` int UNSIGNED NOT NULL,
  `RpBonusAuto` tinyint(1) NOT NULL DEFAULT 0,
  `RpBonusType` tinyint UNSIGNED NOT NULL DEFAULT 255,
  `SlotID` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT 'skillIndex',
  `TimeRemaining` int UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Skill CD Time',
  `Exp` int UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`owner_id`, `SlotID`) USING BTREE,
  UNIQUE INDEX `owner_id`(`owner_id` ASC, `SlotID` ASC) USING BTREE,
  INDEX `owner_id_2`(`owner_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `CharID` int UNSIGNED NOT NULL,
  `TeacherID` int UNSIGNED NOT NULL,
  `state` tinyint UNSIGNED NOT NULL DEFAULT 0,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `graduationtime` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `CharID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for titles
-- ----------------------------
DROP TABLE IF EXISTS `titles`;
CREATE TABLE `titles`  (
  `CharID` int UNSIGNED NOT NULL,
  `TitleTblidx` int UNSIGNED NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tmEndTimes` bigint UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`CharID`, `TitleTblidx`) USING BTREE,
  UNIQUE INDEX `CharID_2`(`CharID` ASC, `TitleTblidx` ASC) USING BTREE,
  INDEX `CharID`(`CharID` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for warfog
-- ----------------------------
DROP TABLE IF EXISTS `warfog`;
CREATE TABLE `warfog`  (
  `CharID` int UNSIGNED NOT NULL,
  `WarFog` int UNSIGNED NOT NULL,
  PRIMARY KEY (`CharID`, `WarFog`) USING BTREE,
  UNIQUE INDEX `CharID_2`(`CharID` ASC, `WarFog` ASC) USING BTREE,
  INDEX `CharID`(`CharID` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

SET FOREIGN_KEY_CHECKS = 1;
