/*
 Navicat Premium Data Transfer

 Source Server         : local
 Source Server Type    : MySQL
 Source Server Version : 80026
 Source Host           : localhost:3306
 Source Schema         : test

 Target Server Type    : MySQL
 Target Server Version : 80026
 File Encoding         : 65001

 Date: 22/12/2021 19:35:27
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for break_rule
-- ----------------------------
DROP TABLE IF EXISTS `break_rule`;
CREATE TABLE `break_rule`  (
  `brID` bigint(0) NOT NULL AUTO_INCREMENT,
  `dID` bigint(0) NULL DEFAULT NULL,
  `brName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `brTime` datetime(6) NULL DEFAULT NULL,
  `brLocation` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `carID` bigint(0) NULL DEFAULT NULL,
  `recorder` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`brID`) USING BTREE,
  INDEX `fk_break_rule_carID`(`carID`) USING BTREE,
  INDEX `fk_break_rule_dID`(`dID`) USING BTREE,
  CONSTRAINT `fk_break_rule_carID` FOREIGN KEY (`carID`) REFERENCES `bus` (`carID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_break_rule_dID` FOREIGN KEY (`dID`) REFERENCES `driver` (`dID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of break_rule
-- ----------------------------
INSERT INTO `break_rule` VALUES (1, 2, '闯红灯', '2020-12-12 00:00:00.000000', 'china', 2, 'someone');
INSERT INTO `break_rule` VALUES (2, 1, '闯红灯', '2021-12-21 16:31:59.000000', 'china', 2, 'someone');
INSERT INTO `break_rule` VALUES (3, 6, '压线', '2021-12-21 16:32:03.000000', 'china', 4, 'someone');
INSERT INTO `break_rule` VALUES (4, 7, '闯红灯', '2021-12-21 16:32:05.000000', 'china', 5, 'someone');
INSERT INTO `break_rule` VALUES (16, 2, '闯红灯', '2020-12-12 00:00:00.000000', 'china', 2, 'someone');
INSERT INTO `break_rule` VALUES (19, 3, '闯红灯', '2020-12-12 00:00:00.000000', '1234', 4, 'res');
INSERT INTO `break_rule` VALUES (24, 3, '4312', '1998-12-12 00:00:00.000000', '4312', 3, '4123');
INSERT INTO `break_rule` VALUES (25, 3, '4312', '1998-12-12 00:00:00.000000', '4312', 5, '4123');
INSERT INTO `break_rule` VALUES (32, 6, '酒驾', '2021-12-15 00:00:00.000000', 'china', 13, 'willem');

-- ----------------------------
-- Table structure for bus
-- ----------------------------
DROP TABLE IF EXISTS `bus`;
CREATE TABLE `bus`  (
  `carID` bigint(0) NOT NULL AUTO_INCREMENT,
  `seats` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `brand` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `age` bigint(0) NULL DEFAULT NULL,
  PRIMARY KEY (`carID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bus
-- ----------------------------
INSERT INTO `bus` VALUES (-4, '3', '5', 6);
INSERT INTO `bus` VALUES (1, '3', NULL, NULL);
INSERT INTO `bus` VALUES (2, '3', '5', 6);
INSERT INTO `bus` VALUES (3, '3', '5', 6);
INSERT INTO `bus` VALUES (4, '3', '5', 6);
INSERT INTO `bus` VALUES (5, '3', '5', 6);
INSERT INTO `bus` VALUES (6, '3', '5', 6);
INSERT INTO `bus` VALUES (7, '2', 'new', 6);
INSERT INTO `bus` VALUES (8, '3', '3', 3);
INSERT INTO `bus` VALUES (9, '3', '3', 3);
INSERT INTO `bus` VALUES (10, '2', '2', 2);
INSERT INTO `bus` VALUES (11, '1', '1', 1);
INSERT INTO `bus` VALUES (12, '12', '12', 12);
INSERT INTO `bus` VALUES (13, '1', '1', 1);
INSERT INTO `bus` VALUES (14, '1', '1', 1);
INSERT INTO `bus` VALUES (15, '1', '1', 1);
INSERT INTO `bus` VALUES (16, '1', '1', 1);
INSERT INTO `bus` VALUES (17, '1', '1', 1);
INSERT INTO `bus` VALUES (18, '3', '3', 3);
INSERT INTO `bus` VALUES (19, '3', '3', 3);
INSERT INTO `bus` VALUES (20, '12', '12', 12);
INSERT INTO `bus` VALUES (21, '3', 'TEST', 1);
INSERT INTO `bus` VALUES (22, '3', '3', 3);
INSERT INTO `bus` VALUES (23, '2', 'brs', 3);
INSERT INTO `bus` VALUES (24, '2', 'brs', 3);
INSERT INTO `bus` VALUES (25, '3', '3', 3);
INSERT INTO `bus` VALUES (26, '16', 'buses', 2);

-- ----------------------------
-- Table structure for bus_router
-- ----------------------------
DROP TABLE IF EXISTS `bus_router`;
CREATE TABLE `bus_router`  (
  `carID` bigint(0) NULL DEFAULT NULL,
  `routerID` bigint(0) NULL DEFAULT NULL,
  INDEX `fk_bus_router_carID`(`carID`) USING BTREE,
  INDEX `fk_bus_router_routerID`(`routerID`) USING BTREE,
  CONSTRAINT `fk_bus_router_carID` FOREIGN KEY (`carID`) REFERENCES `bus` (`carID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_bus_router_routerID` FOREIGN KEY (`routerID`) REFERENCES `router` (`routerID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for company
-- ----------------------------
DROP TABLE IF EXISTS `company`;
CREATE TABLE `company`  (
  `companyName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `createdTime` datetime(6) NULL DEFAULT NULL,
  `location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`companyName`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of company
-- ----------------------------
INSERT INTO `company` VALUES ('busCompany', '2021-12-21 00:00:00.000000', 'China');

-- ----------------------------
-- Table structure for driver
-- ----------------------------
DROP TABLE IF EXISTS `driver`;
CREATE TABLE `driver`  (
  `dID` bigint(0) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sex` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `age` bigint(0) NULL DEFAULT NULL,
  `native_place` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `enqueue_time` datetime(6) NULL DEFAULT NULL,
  `tel` bigint(0) NULL DEFAULT NULL,
  `idCard` bigint(0) NULL DEFAULT NULL,
  `position` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `motorcadeID` bigint(0) NULL DEFAULT NULL,
  PRIMARY KEY (`dID`) USING BTREE,
  INDEX `fk_driver_motorcadeID`(`motorcadeID`) USING BTREE,
  CONSTRAINT `fk_driver_motorcadeID` FOREIGN KEY (`motorcadeID`) REFERENCES `motorcade` (`motorcadeID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of driver
-- ----------------------------
INSERT INTO `driver` VALUES (1, 'tom', 'female', 12, 'china', '2020-12-12 00:00:00.000000', 1292383, 192939292935341250, 'none', 3);
INSERT INTO `driver` VALUES (2, 'jerry', 'female', 12, 'china', '2020-12-12 00:00:00.000000', 1292383, 192939292935341251, 'none', 3);
INSERT INTO `driver` VALUES (3, 'willem', 'male', 12, 'china', '2021-12-21 15:19:27.000000', 72829174632, 192939292935341252, 'none', 4);
INSERT INTO `driver` VALUES (4, 'avon', 'male', 12, 'china', '2021-12-21 16:05:22.000000', 312321432143, 192939292935341253, 'none', 4);
INSERT INTO `driver` VALUES (5, 'jeff', 'female', 12, 'china', '2021-12-21 15:19:49.000000', 4321, 192939292935341254, 'none', 4);
INSERT INTO `driver` VALUES (6, 'ref', 'male', 12, 'china', '2021-12-21 15:19:52.000000', 4321, 192939292935341255, 'none', 3);
INSERT INTO `driver` VALUES (7, 'green', 'male', 15, 'china', '2021-12-21 15:19:55.000000', 32142314, 192939292935341256, 'none', 3);
INSERT INTO `driver` VALUES (8, 'cat', 'female', 15, 'china', '2021-12-21 15:19:57.000000', 43214321, 192939292935341257, 'none', 3);
INSERT INTO `driver` VALUES (9, 'midori', 'male', 15, 'china', '2021-12-07 15:20:00.000000', 434322, 4312543545423, 'none', 4);
INSERT INTO `driver` VALUES (10, 'ninja', 'male', 15, 'china', '2021-12-21 15:20:03.000000', 567543, 5656543675, 'none', 3);
INSERT INTO `driver` VALUES (11, 'jenny', 'female', 15, 'china', '2021-12-21 15:20:06.000000', 5423542, 5643265234, 'none', 3);
INSERT INTO `driver` VALUES (12, 'li', 'male', 15, 'china', '2021-12-21 15:20:09.000000', 65436, 54222346542, 'none', 3);
INSERT INTO `driver` VALUES (13, 'wang', 'male', 15, 'china', '2021-12-21 15:20:14.000000', 6543, 8753653465436, 'none', 3);
INSERT INTO `driver` VALUES (14, 'ming', 'female', 15, 'china', '2021-12-21 15:20:16.000000', 5432542, 6775436534, 'none', 4);
INSERT INTO `driver` VALUES (15, 'jerry', 'feamle', 17, 'china', '2021-12-21 15:55:04.000000', 43215, 5432543253, 'none', 3);
INSERT INTO `driver` VALUES (16, 'Leina', 'male', 25, 'America', '2021-12-21 00:00:00.000000', 13234928342, 5423542356423, '?', 3);
INSERT INTO `driver` VALUES (17, 'Leina', 'male', 25, 'America', '2021-12-21 00:00:00.000000', 13234928342, 5423542356423, '?', 3);
INSERT INTO `driver` VALUES (18, 'Leina', 'male', 25, 'America', '2021-12-21 00:00:00.000000', 13234928342, 5423542356423, '?', 3);
INSERT INTO `driver` VALUES (20, 'Willem Zhang', 'female', 23, 'tes', '2020-12-12 00:00:00.000000', 13832266793, 12393824324, 'fest', 3);
INSERT INTO `driver` VALUES (22, 'tetet', 'male', 14, 'china', '2020-12-12 00:00:00.000000', 4321431, 34214231, 'resr', 5);
INSERT INTO `driver` VALUES (23, 'gfag', 'male', 25, 'fdasg', '2021-12-29 00:00:00.000000', 53425, 5432151, '54321512', 3);

-- ----------------------------
-- Table structure for driver_router
-- ----------------------------
DROP TABLE IF EXISTS `driver_router`;
CREATE TABLE `driver_router`  (
  `dID` bigint(0) NULL DEFAULT NULL,
  `routerID` bigint(0) NULL DEFAULT NULL,
  INDEX `fk_driver_router_dID`(`dID`) USING BTREE,
  INDEX `fk_driver_router_routerID`(`routerID`) USING BTREE,
  CONSTRAINT `fk_driver_router_dID` FOREIGN KEY (`dID`) REFERENCES `driver` (`dID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_driver_router_routerID` FOREIGN KEY (`routerID`) REFERENCES `router` (`routerID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for leader
-- ----------------------------
DROP TABLE IF EXISTS `leader`;
CREATE TABLE `leader`  (
  `dID` bigint(0) NULL DEFAULT NULL,
  `motorcateID` bigint(0) NULL DEFAULT NULL,
  INDEX `fk_leader_dID`(`dID`) USING BTREE,
  INDEX `fk_leader_motorcadeID`(`motorcateID`) USING BTREE,
  CONSTRAINT `fk_leader_dID` FOREIGN KEY (`dID`) REFERENCES `driver` (`dID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_leader_motorcadeID` FOREIGN KEY (`motorcateID`) REFERENCES `motorcade` (`motorcadeID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for motorcade
-- ----------------------------
DROP TABLE IF EXISTS `motorcade`;
CREATE TABLE `motorcade`  (
  `motorcadeID` bigint(0) NOT NULL AUTO_INCREMENT,
  `createdTime` datetime(0) NULL DEFAULT NULL,
  `companyName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`motorcadeID`) USING BTREE,
  INDEX `fk_motorcade_companyName`(`companyName`) USING BTREE,
  CONSTRAINT `fk_motorcade_companyName` FOREIGN KEY (`companyName`) REFERENCES `company` (`companyName`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of motorcade
-- ----------------------------
INSERT INTO `motorcade` VALUES (1, '2021-12-22 00:41:38', 'busCompany');
INSERT INTO `motorcade` VALUES (2, '2021-12-22 00:41:53', 'busCompany');
INSERT INTO `motorcade` VALUES (3, '2021-12-21 15:06:19', 'busCompany');
INSERT INTO `motorcade` VALUES (4, '2021-12-21 15:06:40', 'busCompany');
INSERT INTO `motorcade` VALUES (5, '2021-12-22 00:42:28', 'busCompany');

-- ----------------------------
-- Table structure for router
-- ----------------------------
DROP TABLE IF EXISTS `router`;
CREATE TABLE `router`  (
  `routerID` bigint(0) NOT NULL AUTO_INCREMENT,
  `motorcadeID` bigint(0) NULL DEFAULT NULL,
  `createdTime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`routerID`) USING BTREE,
  INDEX `fk_router_motorcadeID`(`motorcadeID`) USING BTREE,
  CONSTRAINT `fk_router_motorcadeID` FOREIGN KEY (`motorcadeID`) REFERENCES `motorcade` (`motorcadeID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
