/*
 Navicat Premium Data Transfer

 Source Server         : MySQLServer
 Source Server Type    : MySQL
 Source Server Version : 80033 (8.0.33)
 Source Host           : localhost:3306
 Source Schema         : db2061200719

 Target Server Type    : MySQL
 Target Server Version : 80033 (8.0.33)
 File Encoding         : 65001

 Date: 12/12/2023 14:02:09
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `admin` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '000000',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `admin`(`admin` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'admin', '000000');
INSERT INTO `admin` VALUES (2, 'teacher', '000000');

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course`  (
  `course_number` int NOT NULL AUTO_INCREMENT COMMENT '课程编号',
  `course_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '课程名称',
  `credit` int NOT NULL COMMENT '学分',
  `teacher` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任课老师',
  `period` int NOT NULL COMMENT '学时数',
  PRIMARY KEY (`course_number`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES (1, 'SpringBoot2', 4, '王老师', 48);
INSERT INTO `course` VALUES (2, 'Vue.js', 4, '王老师', 48);
INSERT INTO `course` VALUES (3, '数据库系统概论', 2, '彭老师', 36);
INSERT INTO `course` VALUES (4, '数据结构', 4, '盘老师', 48);
INSERT INTO `course` VALUES (5, '操作系统', 2, '彭老师', 36);
INSERT INTO `course` VALUES (6, '计算机网络', 2, '牙老师', 36);
INSERT INTO `course` VALUES (7, 'Java程序设计', 4, '王老师', 48);
INSERT INTO `course` VALUES (8, '软件工程', 2, '韦老师', 36);
INSERT INTO `course` VALUES (9, 'HTML、CSS、JavaScript网页设计', 4, '朱老师', 48);
INSERT INTO `course` VALUES (10, 'C语言程序设计', 4, '王老师', 48);
INSERT INTO `course` VALUES (11, 'Android程序设计', 2, '李老师', 36);
INSERT INTO `course` VALUES (12, '大学数学', 4, '孙老师', 48);

-- ----------------------------
-- Table structure for score
-- ----------------------------
DROP TABLE IF EXISTS `score`;
CREATE TABLE `score`  (
  `c_id` int NOT NULL COMMENT '课程编号',
  `s_id` int NOT NULL COMMENT '学号',
  `score` float NOT NULL COMMENT '分数',
  PRIMARY KEY (`c_id` DESC, `s_id`) USING BTREE,
  INDEX `学生外键`(`s_id` ASC) USING BTREE,
  INDEX `课程外键`(`c_id` ASC) USING BTREE,
  CONSTRAINT `学生外键` FOREIGN KEY (`s_id`) REFERENCES `student` (`student_number`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `课程外键` FOREIGN KEY (`c_id`) REFERENCES `course` (`course_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of score
-- ----------------------------
INSERT INTO `score` VALUES (10, 3, 95);
INSERT INTO `score` VALUES (9, 2, 89);
INSERT INTO `score` VALUES (7, 4, 97);
INSERT INTO `score` VALUES (5, 1, 93);
INSERT INTO `score` VALUES (4, 3, 94);
INSERT INTO `score` VALUES (3, 2, 90.5);
INSERT INTO `score` VALUES (2, 1, 90);
INSERT INTO `score` VALUES (1, 4, 97.5);

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `student_number` int NOT NULL AUTO_INCREMENT COMMENT '学号',
  `name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '姓名',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '女' COMMENT '性别',
  `grade` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '所在班级',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '联系电话',
  `major` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '专业',
  PRIMARY KEY (`student_number`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES (1, '张三123', '女', '计科7班', '123456789', '计算机科学与技术');
INSERT INTO `student` VALUES (2, '李四', '女', '计科8班', '123456789', '计算机科学与技术');
INSERT INTO `student` VALUES (3, '王五', '男', '通信2班', '123456789', '通信工程');
INSERT INTO `student` VALUES (4, '赵六', '男', '通信1班', '1234589', '通信工程');

SET FOREIGN_KEY_CHECKS = 1;
