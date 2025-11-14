/*
 Navicat Premium Data Transfer

 Source Server         : 乘用车数据库
 Source Server Type    : MySQL
 Source Server Version : 80043 (8.0.43)
 Source Host           : localhost:3306
 Source Schema         : match-cloud

 Target Server Type    : MySQL
 Target Server Version : 80043 (8.0.43)
 File Encoding         : 65001

 Date: 14/11/2025 09:27:37
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for email_record
-- ----------------------------
DROP TABLE IF EXISTS `email_record`;
CREATE TABLE `email_record`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `sender` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '发送者',
  `receiver` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '接收者',
  `subject` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '邮件主题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '邮件内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '发送状态（0成功 1失败）',
  `error_msg` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '失败原因',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_sender`(`sender` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '邮件记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of email_record
-- ----------------------------

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成业务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table
-- ----------------------------

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------

-- ----------------------------
-- Table structure for marathon_event
-- ----------------------------
DROP TABLE IF EXISTS `marathon_event`;
CREATE TABLE `marathon_event`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '赛事ID',
  `event_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '赛事名称',
  `event_description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '赛事描述',
  `event_time` datetime NOT NULL COMMENT '赛事时间',
  `registration_start_time` datetime NOT NULL COMMENT '报名开始时间',
  `registration_end_time` datetime NOT NULL COMMENT '报名截止时间',
  `max_participants` int NOT NULL DEFAULT 0 COMMENT '最大参赛人数',
  `current_participants` int NOT NULL DEFAULT 0 COMMENT '当前参赛人数',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '赛事状态（0正常 1关闭 2已结束）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `event_photo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '赛事照片',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '马拉松赛事表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of marathon_event
-- ----------------------------
INSERT INTO `marathon_event` VALUES (1, '济南马拉松', '2024济南马拉松赛事，包括全程马拉松、半程马拉松和迷你马拉松', '2024-11-10 08:00:00', '2024-09-01 00:00:00', '2024-10-20 23:59:59', 10000, 14, '0', 'admin', '2025-11-06 03:06:06', '', '2025-11-07 11:06:20', '济南马拉松赛事', NULL);
INSERT INTO `marathon_event` VALUES (2, '北京马拉松比赛', NULL, '2025-11-29 00:00:00', '2025-11-01 00:00:00', '2025-11-23 00:00:00', 1000, 2, '0', '', '2025-11-07 03:33:48', '', '2025-11-08 01:20:35', NULL, 'http://127.0.0.1:9000/match/2025/11/08/WIN_20240228_17_09_40_Pro_20251108092033A001.jpg');

-- ----------------------------
-- Table structure for participant
-- ----------------------------
DROP TABLE IF EXISTS `participant`;
CREATE TABLE `participant`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '参赛者ID',
  `registration_id` bigint NOT NULL COMMENT '报名ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `emergency_contact` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '紧急联系人',
  `emergency_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '紧急联系人电话',
  `photo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '参赛者照片',
  `id_card` varchar(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '参赛者身份证号',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '参赛者地址',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_registration_id`(`registration_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '参赛者信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of participant
-- ----------------------------

-- ----------------------------
-- Table structure for registration
-- ----------------------------
DROP TABLE IF EXISTS `registration`;
CREATE TABLE `registration`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '报名ID',
  `event_id` bigint NOT NULL COMMENT '赛事ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `registration_no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '报名编号',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户姓名',
  `user_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户手机号',
  `user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '报名状态（0待支付 1已支付 2已取消 3已完成）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_reg_no`(`registration_no` ASC) USING BTREE,
  INDEX `idx_event_id`(`event_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '报名记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of registration
-- ----------------------------
INSERT INTO `registration` VALUES (16, 2, 1, 'REG1762513345709mtLWQ6', 'admin', '15888888888', '1534975668@qq.com', '1', '', '2025-11-07 11:02:07', '', NULL, NULL);
INSERT INTO `registration` VALUES (17, 1, 1, 'REG1762513598297qboAIu', 'admin', '15888888888', '1534975668@qq.com', '1', '', '2025-11-07 11:06:20', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '参数配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2025-11-05 07:49:29', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2025-11-05 07:49:29', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2025-11-05 07:49:29', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'true', 'Y', 'admin', '2025-11-05 07:49:29', 'admin', '2025-11-06 08:14:33', '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2025-11-05 07:49:29', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');
INSERT INTO `sys_config` VALUES (6, '用户管理-初始密码修改策略', 'sys.account.initPasswordModify', '1', 'Y', 'admin', '2025-11-05 07:49:29', '', NULL, '0：初始密码修改策略关闭，没有任何提示，1：提醒用户，如果未修改初始密码，则在登录时就会提醒修改密码对话框');
INSERT INTO `sys_config` VALUES (7, '用户管理-账号密码更新周期', 'sys.account.passwordValidateDays', '0', 'Y', 'admin', '2025-11-05 07:49:29', '', NULL, '密码更新周期（填写数字，数据初始化值为0不限制，若修改必须为大于0小于365的正整数），如果超过这个周期登录系统时，则在登录时就会提醒修改密码对话框');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 200 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '若依科技', 0, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-11-05 07:49:35', '', NULL);
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '深圳总公司', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-11-05 07:49:35', '', NULL);
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-11-05 07:49:35', '', NULL);
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '研发部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-11-05 07:49:35', '', NULL);
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '市场部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-11-05 07:49:35', '', NULL);
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '测试部门', 3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-11-05 07:49:35', '', NULL);
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-11-05 07:49:35', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-11-05 07:49:35', '', NULL);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-11-05 07:49:35', '', NULL);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-11-05 07:49:35', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2025-11-05 07:49:43', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-11-05 07:49:43', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-11-05 07:49:43', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2025-11-05 07:49:43', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2025-11-05 07:49:43', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2025-11-05 07:49:43', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2025-11-05 07:49:28', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2025-11-05 07:49:28', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2025-11-05 07:49:28', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2025-11-05 07:49:28', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2025-11-05 07:49:28', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2025-11-05 07:49:28', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2025-11-05 07:49:28', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2025-11-05 07:49:28', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2025-11-05 07:49:28', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2025-11-05 07:49:28', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2025-11-05 07:49:28', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-11-05 07:49:29', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-11-05 07:49:29', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-11-05 07:49:29', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-11-05 07:49:29', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2025-11-05 07:49:29', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-11-05 07:49:29', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-11-05 07:49:29', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-11-05 07:49:29', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-11-05 07:49:29', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-11-05 07:49:29', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2025-11-05 07:49:29', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2025-11-05 07:49:29', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (30, 1, '正常', '0', 'event_status', '', 'primary', 'Y', '0', 'admin', '2025-11-07 00:49:56', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (31, 2, '关闭', '1', 'event_status', '', 'danger', 'N', '0', 'admin', '2025-11-07 00:49:56', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (32, 3, '已结束', '2', 'event_status', '', 'warning', 'N', '0', 'admin', '2025-11-07 00:49:56', '', NULL, '已结束状态');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2025-11-05 07:49:42', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2025-11-05 07:49:42', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2025-11-05 07:49:42', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2025-11-05 07:49:42', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2025-11-05 07:49:42', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2025-11-05 07:49:42', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2025-11-05 07:49:42', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2025-11-05 07:49:42', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2025-11-05 07:49:42', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2025-11-05 07:49:42', '', NULL, '登录状态列表');
INSERT INTO `sys_dict_type` VALUES (11, '赛事状态', 'event_status', '0', 'admin', '2025-11-07 00:49:56', '', NULL, '赛事状态列表');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '定时任务调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2025-11-05 07:49:29', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2025-11-05 07:49:30', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2025-11-05 07:49:30', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '提示信息',
  `access_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`access_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 181 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统访问记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '127.0.0.1', '0', '登录成功', '2025-11-05 09:37:07');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '0', '退出成功', '2025-11-05 09:51:49');
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '127.0.0.1', '0', '登录成功', '2025-11-05 09:51:52');
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '127.0.0.1', '0', '登录成功', '2025-11-06 00:53:33');
INSERT INTO `sys_logininfor` VALUES (104, 'admin', '127.0.0.1', '0', '登录成功', '2025-11-06 05:53:08');
INSERT INTO `sys_logininfor` VALUES (105, 'admin', '127.0.0.1', '0', '退出成功', '2025-11-06 07:57:31');
INSERT INTO `sys_logininfor` VALUES (106, 'admin', '127.0.0.1', '0', '登录成功', '2025-11-06 08:13:29');
INSERT INTO `sys_logininfor` VALUES (107, '18363975597', '127.0.0.1', '0', '注册成功', '2025-11-06 08:14:40');
INSERT INTO `sys_logininfor` VALUES (108, 'admin', '127.0.0.1', '0', '退出成功', '2025-11-06 08:14:58');
INSERT INTO `sys_logininfor` VALUES (109, '18363975597', '127.0.0.1', '0', '登录成功', '2025-11-06 08:15:28');
INSERT INTO `sys_logininfor` VALUES (110, '18363975597', '127.0.0.1', '0', '退出成功', '2025-11-06 08:15:28');
INSERT INTO `sys_logininfor` VALUES (111, '18363975597', '127.0.0.1', '0', '登录成功', '2025-11-06 08:17:01');
INSERT INTO `sys_logininfor` VALUES (112, '18363975597', '127.0.0.1', '0', '退出成功', '2025-11-06 08:45:16');
INSERT INTO `sys_logininfor` VALUES (113, '18363975598', '127.0.0.1', '0', '注册成功', '2025-11-06 08:46:32');
INSERT INTO `sys_logininfor` VALUES (114, '18363975598', '127.0.0.1', '0', '登录成功', '2025-11-06 08:46:43');
INSERT INTO `sys_logininfor` VALUES (115, '18363975598', '127.0.0.1', '0', '退出成功', '2025-11-06 09:34:12');
INSERT INTO `sys_logininfor` VALUES (116, 'admin', '127.0.0.1', '0', '登录成功', '2025-11-06 09:34:14');
INSERT INTO `sys_logininfor` VALUES (117, 'admin', '127.0.0.1', '0', '登录成功', '2025-11-07 00:38:33');
INSERT INTO `sys_logininfor` VALUES (118, 'admin', '127.0.0.1', '0', '退出成功', '2025-11-07 02:48:26');
INSERT INTO `sys_logininfor` VALUES (119, 'admin', '127.0.0.1', '0', '登录成功', '2025-11-07 02:48:29');
INSERT INTO `sys_logininfor` VALUES (120, 'admin', '127.0.0.1', '0', '退出成功', '2025-11-07 02:49:15');
INSERT INTO `sys_logininfor` VALUES (121, 'admin', '127.0.0.1', '0', '登录成功', '2025-11-07 02:49:27');
INSERT INTO `sys_logininfor` VALUES (122, 'admin', '127.0.0.1', '0', '登录成功', '2025-11-07 03:05:27');
INSERT INTO `sys_logininfor` VALUES (123, 'admin', '127.0.0.1', '0', '登录成功', '2025-11-07 03:09:06');
INSERT INTO `sys_logininfor` VALUES (124, 'admin', '127.0.0.1', '0', '登录成功', '2025-11-07 03:39:56');
INSERT INTO `sys_logininfor` VALUES (125, 'admin', '127.0.0.1', '0', '登录成功', '2025-11-07 03:52:46');
INSERT INTO `sys_logininfor` VALUES (126, 'admin', '127.0.0.1', '0', '登录成功', '2025-11-07 07:45:29');
INSERT INTO `sys_logininfor` VALUES (127, 'admin', '127.0.0.1', '0', '登录成功', '2025-11-07 10:58:59');
INSERT INTO `sys_logininfor` VALUES (128, 'admin', '127.0.0.1', '0', '登录成功', '2025-11-08 01:20:08');
INSERT INTO `sys_logininfor` VALUES (129, 'admin', '127.0.0.1', '0', '登录成功', '2025-11-10 02:28:52');
INSERT INTO `sys_logininfor` VALUES (130, 'admin', '127.0.0.1', '0', '登录成功', '2025-11-12 01:13:34');
INSERT INTO `sys_logininfor` VALUES (131, 'admin', '127.0.0.1', '0', '退出成功', '2025-11-12 01:43:00');
INSERT INTO `sys_logininfor` VALUES (132, 'admin', '127.0.0.1', '0', '登录成功', '2025-11-12 01:43:30');
INSERT INTO `sys_logininfor` VALUES (133, 'admin', '127.0.0.1', '0', '退出成功', '2025-11-12 02:14:08');
INSERT INTO `sys_logininfor` VALUES (134, 'admin', '127.0.0.1', '0', '登录成功', '2025-11-12 02:13:44');
INSERT INTO `sys_logininfor` VALUES (135, 'admin', '127.0.0.1', '0', '退出成功', '2025-11-12 02:39:08');
INSERT INTO `sys_logininfor` VALUES (136, 'admin', '127.0.0.1', '0', '登录成功', '2025-11-12 02:39:11');
INSERT INTO `sys_logininfor` VALUES (137, 'admin', '127.0.0.1', '0', '退出成功', '2025-11-12 03:06:30');
INSERT INTO `sys_logininfor` VALUES (138, 'admin', '127.0.0.1', '0', '登录成功', '2025-11-12 03:06:32');
INSERT INTO `sys_logininfor` VALUES (139, 'admin', '127.0.0.1', '0', '退出成功', '2025-11-12 03:40:04');
INSERT INTO `sys_logininfor` VALUES (140, 'admin', '127.0.0.1', '0', '退出成功', '2025-11-12 03:40:04');
INSERT INTO `sys_logininfor` VALUES (141, 'admin', '127.0.0.1', '0', '登录成功', '2025-11-12 03:40:06');
INSERT INTO `sys_logininfor` VALUES (142, 'admin', '127.0.0.1', '0', '退出成功', '2025-11-12 05:41:42');
INSERT INTO `sys_logininfor` VALUES (143, 'admin', '127.0.0.1', '0', '登录成功', '2025-11-12 05:41:43');
INSERT INTO `sys_logininfor` VALUES (144, 'admin', '127.0.0.1', '0', '退出成功', '2025-11-12 06:20:53');
INSERT INTO `sys_logininfor` VALUES (145, 'admin', '127.0.0.1', '0', '登录成功', '2025-11-12 06:20:38');
INSERT INTO `sys_logininfor` VALUES (146, 'admin', '127.0.0.1', '0', '退出成功', '2025-11-12 06:46:02');
INSERT INTO `sys_logininfor` VALUES (147, 'admin', '127.0.0.1', '0', '登录成功', '2025-11-12 06:46:30');
INSERT INTO `sys_logininfor` VALUES (148, 'admin', '127.0.0.1', '0', '登录成功', '2025-11-12 07:01:49');
INSERT INTO `sys_logininfor` VALUES (149, 'admin', '127.0.0.1', '0', '登录成功', '2025-11-12 07:46:49');
INSERT INTO `sys_logininfor` VALUES (150, 'admin', '127.0.0.1', '0', '退出成功', '2025-11-12 08:11:14');
INSERT INTO `sys_logininfor` VALUES (151, 'admin', '127.0.0.1', '0', '登录成功', '2025-11-12 08:11:18');
INSERT INTO `sys_logininfor` VALUES (152, 'admin', '127.0.0.1', '0', '退出成功', '2025-11-12 08:38:56');
INSERT INTO `sys_logininfor` VALUES (153, 'admin', '127.0.0.1', '0', '登录成功', '2025-11-12 08:38:59');
INSERT INTO `sys_logininfor` VALUES (154, 'admin', '127.0.0.1', '0', '退出成功', '2025-11-12 09:09:13');
INSERT INTO `sys_logininfor` VALUES (155, 'admin', '127.0.0.1', '0', '登录成功', '2025-11-12 09:09:16');
INSERT INTO `sys_logininfor` VALUES (156, 'admin', '127.0.0.1', '0', '退出成功', '2025-11-12 09:33:51');
INSERT INTO `sys_logininfor` VALUES (157, 'admin', '127.0.0.1', '0', '登录成功', '2025-11-12 09:33:55');
INSERT INTO `sys_logininfor` VALUES (158, 'admin', '127.0.0.1', '0', '退出成功', '2025-11-12 10:28:33');
INSERT INTO `sys_logininfor` VALUES (159, 'admin', '127.0.0.1', '0', '登录成功', '2025-11-12 10:28:36');
INSERT INTO `sys_logininfor` VALUES (160, 'admin', '127.0.0.1', '0', '退出成功', '2025-11-12 11:17:51');
INSERT INTO `sys_logininfor` VALUES (161, 'admin', '127.0.0.1', '0', '登录成功', '2025-11-12 11:17:54');
INSERT INTO `sys_logininfor` VALUES (162, 'admin', '127.0.0.1', '0', '登录成功', '2025-11-13 00:55:09');
INSERT INTO `sys_logininfor` VALUES (163, 'admin', '127.0.0.1', '0', '退出成功', '2025-11-13 01:25:52');
INSERT INTO `sys_logininfor` VALUES (164, 'admin', '127.0.0.1', '0', '登录成功', '2025-11-13 01:25:55');
INSERT INTO `sys_logininfor` VALUES (165, 'admin', '127.0.0.1', '0', '退出成功', '2025-11-13 01:50:44');
INSERT INTO `sys_logininfor` VALUES (166, 'admin', '127.0.0.1', '0', '登录成功', '2025-11-13 01:50:52');
INSERT INTO `sys_logininfor` VALUES (167, 'admin', '127.0.0.1', '0', '退出成功', '2025-11-13 02:46:15');
INSERT INTO `sys_logininfor` VALUES (168, 'admin', '127.0.0.1', '0', '登录成功', '2025-11-13 02:46:17');
INSERT INTO `sys_logininfor` VALUES (169, 'admin', '127.0.0.1', '0', '退出成功', '2025-11-13 03:10:06');
INSERT INTO `sys_logininfor` VALUES (170, 'admin', '127.0.0.1', '0', '登录成功', '2025-11-13 03:10:08');
INSERT INTO `sys_logininfor` VALUES (171, 'admin', '127.0.0.1', '0', '退出成功', '2025-11-13 03:39:22');
INSERT INTO `sys_logininfor` VALUES (172, 'admin', '127.0.0.1', '0', '登录成功', '2025-11-13 03:39:25');
INSERT INTO `sys_logininfor` VALUES (173, 'admin', '127.0.0.1', '0', '退出成功', '2025-11-13 05:41:37');
INSERT INTO `sys_logininfor` VALUES (174, 'admin', '127.0.0.1', '0', '登录成功', '2025-11-13 05:42:00');
INSERT INTO `sys_logininfor` VALUES (175, 'admin', '127.0.0.1', '0', '退出成功', '2025-11-13 06:26:48');
INSERT INTO `sys_logininfor` VALUES (176, 'admin', '127.0.0.1', '0', '登录成功', '2025-11-13 06:26:50');
INSERT INTO `sys_logininfor` VALUES (177, 'admin', '127.0.0.1', '0', '退出成功', '2025-11-13 06:50:24');
INSERT INTO `sys_logininfor` VALUES (178, 'admin', '127.0.0.1', '0', '登录成功', '2025-11-13 06:50:27');
INSERT INTO `sys_logininfor` VALUES (179, 'admin', '127.0.0.1', '0', '退出成功', '2025-11-13 07:14:07');
INSERT INTO `sys_logininfor` VALUES (180, 'admin', '127.0.0.1', '0', '登录成功', '2025-11-13 07:14:09');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '路由名称',
  `is_frame` int NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2018 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, 'system', NULL, '', '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2025-11-05 07:49:36', '', NULL, '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 2, 'monitor', NULL, '', '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2025-11-05 07:49:36', '', NULL, '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 3, 'tool', NULL, '', '', 1, 0, 'M', '1', '0', '', 'tool', 'admin', '2025-11-05 07:49:36', 'admin', '2025-11-05 09:39:02', '系统工具目录');
INSERT INTO `sys_menu` VALUES (4, '若依官网', 0, 4, 'http://ruoyi.vip', NULL, '', '', 0, 0, 'M', '1', '0', '', 'guide', 'admin', '2025-11-05 07:49:36', 'admin', '2025-11-05 09:38:46', '若依官网地址');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2025-11-05 07:49:36', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2025-11-05 07:49:36', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2025-11-05 07:49:36', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2025-11-05 07:49:36', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2025-11-05 07:49:36', '', NULL, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2025-11-05 07:49:36', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2025-11-05 07:49:36', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2025-11-05 07:49:36', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2025-11-05 07:49:36', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2025-11-05 07:49:36', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', '', 1, 0, 'C', '1', '0', 'monitor:job:list', 'job', 'admin', '2025-11-05 07:49:36', 'admin', '2025-11-05 09:39:37', '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, 'Sentinel控制台', 2, 3, 'http://localhost:8718', '', '', '', 0, 0, 'C', '1', '0', 'monitor:sentinel:list', 'sentinel', 'admin', '2025-11-05 07:49:36', 'admin', '2025-11-05 09:39:21', '流量控制菜单');
INSERT INTO `sys_menu` VALUES (112, 'Nacos控制台', 2, 4, 'http://localhost:8848/nacos', '', '', '', 0, 0, 'C', '0', '0', 'monitor:nacos:list', 'nacos', 'admin', '2025-11-05 07:49:36', '', NULL, '服务治理菜单');
INSERT INTO `sys_menu` VALUES (113, 'Admin控制台', 2, 5, 'http://localhost:9100/login', '', '', '', 0, 0, 'C', '1', '0', 'monitor:server:list', 'server', 'admin', '2025-11-05 07:49:36', 'admin', '2025-11-05 09:39:29', '服务监控菜单');
INSERT INTO `sys_menu` VALUES (114, '表单构建', 3, 1, 'build', 'tool/build/index', '', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2025-11-05 07:49:36', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (115, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2025-11-05 07:49:36', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (116, '系统接口', 3, 3, 'http://localhost:8080/swagger-ui/index.html', '', '', '', 0, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2025-11-05 07:49:36', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'system/operlog/index', '', '', 1, 0, 'C', '0', '0', 'system:operlog:list', 'form', 'admin', '2025-11-05 07:49:36', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'system/logininfor/index', '', '', 1, 0, 'C', '0', '0', 'system:logininfor:list', 'logininfor', 'admin', '2025-11-05 07:49:36', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2025-11-05 07:49:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2025-11-05 07:49:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2025-11-05 07:49:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2025-11-05 07:49:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2025-11-05 07:49:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2025-11-05 07:49:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2025-11-05 07:49:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2025-11-05 07:49:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2025-11-05 07:49:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2025-11-05 07:49:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2025-11-05 07:49:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2025-11-05 07:49:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2025-11-05 07:49:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2025-11-05 07:49:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2025-11-05 07:49:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2025-11-05 07:49:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '部门查询', 103, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2025-11-05 07:49:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门新增', 103, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2025-11-05 07:49:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门修改', 103, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2025-11-05 07:49:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门删除', 103, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2025-11-05 07:49:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '岗位查询', 104, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2025-11-05 07:49:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位新增', 104, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2025-11-05 07:49:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位修改', 104, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2025-11-05 07:49:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位删除', 104, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2025-11-05 07:49:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位导出', 104, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2025-11-05 07:49:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2025-11-05 07:49:38', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2025-11-05 07:49:38', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2025-11-05 07:49:38', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2025-11-05 07:49:38', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典导出', 105, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2025-11-05 07:49:38', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '参数查询', 106, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2025-11-05 07:49:38', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数新增', 106, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2025-11-05 07:49:38', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数修改', 106, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2025-11-05 07:49:38', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数删除', 106, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2025-11-05 07:49:38', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数导出', 106, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2025-11-05 07:49:38', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '公告查询', 107, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2025-11-05 07:49:38', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告新增', 107, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2025-11-05 07:49:38', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告修改', 107, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2025-11-05 07:49:38', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告删除', 107, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2025-11-05 07:49:38', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '操作查询', 500, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:operlog:query', '#', 'admin', '2025-11-05 07:49:38', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作删除', 500, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:operlog:remove', '#', 'admin', '2025-11-05 07:49:38', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '日志导出', 500, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:operlog:export', '#', 'admin', '2025-11-05 07:49:38', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '登录查询', 501, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:logininfor:query', '#', 'admin', '2025-11-05 07:49:38', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录删除', 501, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:logininfor:remove', '#', 'admin', '2025-11-05 07:49:38', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '日志导出', 501, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:logininfor:export', '#', 'admin', '2025-11-05 07:49:38', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '账户解锁', 501, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:logininfor:unlock', '#', 'admin', '2025-11-05 07:49:38', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2025-11-05 07:49:38', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2025-11-05 07:49:38', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2025-11-05 07:49:38', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2025-11-05 07:49:38', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2025-11-05 07:49:38', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2025-11-05 07:49:38', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2025-11-05 07:49:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2025-11-05 07:49:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2025-11-05 07:49:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 115, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2025-11-05 07:49:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 115, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2025-11-05 07:49:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 115, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2025-11-05 07:49:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 115, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2025-11-05 07:49:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 115, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2025-11-05 07:49:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 115, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2025-11-05 07:49:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2000, '赛事管理', 1, 10, 'event', 'event/index', '', '', 1, 0, 'C', '0', '0', 'event:event:list', 'education', 'admin', '2025-11-06 10:24:19', '', NULL, '赛事管理菜单');
INSERT INTO `sys_menu` VALUES (2001, '赛事查询', 2000, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'event:event:query', '#', 'admin', '2025-11-06 10:24:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2002, '赛事新增', 2000, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'event:event:add', '#', 'admin', '2025-11-06 10:24:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2003, '赛事修改', 2000, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'event:event:edit', '#', 'admin', '2025-11-06 10:24:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2004, '赛事删除', 2000, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'event:event:remove', '#', 'admin', '2025-11-06 10:24:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2005, '赛事导出', 2000, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'event:event:export', '#', 'admin', '2025-11-06 10:24:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2006, '文件管理', 0, 6, 'file', NULL, NULL, '', 1, 0, 'M', '0', '0', NULL, 'file', 'admin', '2025-11-13 06:26:27', '', NULL, '文件管理目录');
INSERT INTO `sys_menu` VALUES (2007, 'OSS对象存储', 2006, 1, 'oss', 'system/oss/index', NULL, '', 1, 0, 'C', '0', '0', 'system:oss:list', 'upload', 'admin', '2025-11-13 06:26:28', '', NULL, 'OSS对象存储菜单');
INSERT INTO `sys_menu` VALUES (2008, 'OSS对象存储查询', 2006, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:oss:query', '', 'admin', '2025-11-13 06:26:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2009, 'OSS对象存储上传', 2006, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:oss:upload', '', 'admin', '2025-11-13 06:26:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2010, 'OSS对象存储下载', 2006, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:oss:download', '', 'admin', '2025-11-13 06:26:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2011, 'OSS对象存储删除', 2006, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:oss:remove', '', 'admin', '2025-11-13 06:26:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2012, 'OSS配置管理', 2006, 2, 'config', 'system/oss/config', NULL, '', 1, 0, 'C', '0', '0', 'system:oss:list', 'config', 'admin', '2025-11-13 06:26:29', '', NULL, 'OSS配置管理菜单');
INSERT INTO `sys_menu` VALUES (2013, 'OSS配置查询', 2006, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:oss:query', '', 'admin', '2025-11-13 06:26:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2014, 'OSS配置新增', 2006, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:oss:add', '', 'admin', '2025-11-13 06:26:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2015, 'OSS配置修改', 2006, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:oss:edit', '', 'admin', '2025-11-13 06:26:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2016, 'OSS配置删除', 2006, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:oss:remove', '', 'admin', '2025-11-13 06:26:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2017, 'OSS配置导出', 2006, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:oss:export', '', 'admin', '2025-11-13 06:26:29', '', NULL, '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '通知公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '温馨提醒：2018-07-01 若依新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2025-11-05 07:49:30', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (2, '维护通知：2018-07-01 若依系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2025-11-05 07:49:30', '', NULL, '管理员');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint NULL DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 156 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '操作日志记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (100, '菜单管理', 2, 'com.match.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"createTime\":\"2025-11-05 07:49:36\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":4,\"menuName\":\"若依官网\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"http://ruoyi.vip\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-05 09:38:46', 34);
INSERT INTO `sys_oper_log` VALUES (101, '菜单管理', 2, 'com.match.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"createTime\":\"2025-11-05 07:49:36\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":3,\"menuName\":\"系统工具\",\"menuType\":\"M\",\"orderNum\":3,\"params\":{},\"parentId\":0,\"path\":\"tool\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-05 09:39:02', 14);
INSERT INTO `sys_oper_log` VALUES (102, '菜单管理', 2, 'com.match.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"\",\"createTime\":\"2025-11-05 07:49:36\",\"icon\":\"sentinel\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":111,\"menuName\":\"Sentinel控制台\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2,\"path\":\"http://localhost:8718\",\"perms\":\"monitor:sentinel:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-05 09:39:21', 13);
INSERT INTO `sys_oper_log` VALUES (103, '菜单管理', 2, 'com.match.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"\",\"createTime\":\"2025-11-05 07:49:36\",\"icon\":\"server\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":113,\"menuName\":\"Admin控制台\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":2,\"path\":\"http://localhost:9100/login\",\"perms\":\"monitor:server:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-05 09:39:30', 11);
INSERT INTO `sys_oper_log` VALUES (104, '菜单管理', 2, 'com.match.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"monitor/job/index\",\"createTime\":\"2025-11-05 07:49:36\",\"icon\":\"job\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":110,\"menuName\":\"定时任务\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2,\"path\":\"job\",\"perms\":\"monitor:job:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-05 09:39:37', 11);
INSERT INTO `sys_oper_log` VALUES (105, '用户报名', 1, 'com.match.event.controller.UserRegistrationController.register()', 'POST', 1, 'admin', NULL, '/event/user/registration/1', '127.0.0.1', '', '1 {\"params\":{},\"userId\":1}', '{\"msg\":\"报名失败: nested exception is org.apache.ibatis.binding.BindingException: Parameter \'userId\' not found. Available parameters are [arg1, arg0, param1, param2]\",\"code\":500}', 0, NULL, '2025-11-06 03:44:44', 310);
INSERT INTO `sys_oper_log` VALUES (106, '用户报名', 1, 'com.match.event.controller.UserRegistrationController.register()', 'POST', 1, 'admin', NULL, '/event/user/registration/1', '127.0.0.1', '', '1 {\"id\":1,\"params\":{}}', '{\"msg\":\"报名失败: nested exception is org.apache.ibatis.binding.BindingException: Parameter \'userId\' not found. Available parameters are [arg1, arg0, param1, param2]\",\"code\":500}', 0, NULL, '2025-11-06 03:46:38', 8);
INSERT INTO `sys_oper_log` VALUES (107, '用户报名', 1, 'com.match.event.controller.UserRegistrationController.register()', 'POST', 1, 'admin', NULL, '/event/user/registration/1', '127.0.0.1', '', '1 {\"params\":{},\"userId\":1}', '{\"msg\":\"报名失败: nested exception is org.apache.ibatis.binding.BindingException: Parameter \'userId\' not found. Available parameters are [arg1, arg0, param1, param2]\",\"code\":500}', 0, NULL, '2025-11-06 03:47:01', 4);
INSERT INTO `sys_oper_log` VALUES (108, '用户报名', 1, 'com.match.event.controller.UserRegistrationController.register()', 'POST', 1, 'admin', NULL, '/event/user/registration/1', '127.0.0.1', '', '1 {\"params\":{},\"userId\":1}', '{\"msg\":\"用户信息获取失败\",\"code\":500}', 0, NULL, '2025-11-06 03:51:22', 25398);
INSERT INTO `sys_oper_log` VALUES (109, '用户报名', 1, 'com.match.event.controller.UserRegistrationController.register()', 'POST', 1, 'admin', NULL, '/event/user/registration/1', '127.0.0.1', '', '1 {\"params\":{},\"userId\":1}', '{\"msg\":\"用户信息获取失败\",\"code\":500}', 0, NULL, '2025-11-06 03:52:51', 3382);
INSERT INTO `sys_oper_log` VALUES (110, '用户报名', 1, 'com.match.event.controller.UserRegistrationController.register()', 'POST', 1, 'admin', NULL, '/event/user/registration/1', '127.0.0.1', '', '1 {\"params\":{},\"userId\":1}', '{\"msg\":\"用户信息获取失败\",\"code\":500}', 0, NULL, '2025-11-06 04:05:14', 86176);
INSERT INTO `sys_oper_log` VALUES (111, '用户报名', 1, 'com.match.event.controller.UserRegistrationController.register()', 'POST', 1, 'admin', NULL, '/event/user/registration/1', '127.0.0.1', '', '1 {\"params\":{},\"userId\":1}', '{\"msg\":\"用户信息获取失败\",\"code\":500}', 0, NULL, '2025-11-06 04:06:53', 83695);
INSERT INTO `sys_oper_log` VALUES (112, '用户报名', 1, 'com.match.event.controller.UserRegistrationController.register()', 'POST', 1, 'admin', NULL, '/event/user/registration/1', '127.0.0.1', '', '1 {\"params\":{},\"userId\":1}', '{\"msg\":\"用户信息获取失败\",\"code\":500}', 0, NULL, '2025-11-06 04:14:53', 22819);
INSERT INTO `sys_oper_log` VALUES (113, '用户报名', 1, 'com.match.event.controller.UserRegistrationController.register()', 'POST', 1, 'admin', NULL, '/event/user/registration/1', '127.0.0.1', '', '1 {\"params\":{},\"userId\":1}', '{\"msg\":\"用户信息获取失败\",\"code\":500}', 0, NULL, '2025-11-06 05:37:39', 24302);
INSERT INTO `sys_oper_log` VALUES (114, '用户报名', 1, 'com.match.event.controller.UserRegistrationController.register()', 'POST', 1, 'admin', NULL, '/event/user/registration/1', '127.0.0.1', '', '1 {\"params\":{},\"userId\":1}', '{\"msg\":\"用户信息获取失败\",\"code\":500}', 0, NULL, '2025-11-06 05:52:05', 18077);
INSERT INTO `sys_oper_log` VALUES (115, '用户报名', 1, 'com.match.event.controller.UserRegistrationController.register()', 'POST', 1, 'admin', NULL, '/event/user/registration/1', '127.0.0.1', '', '1 {\"params\":{},\"userId\":1}', '{\"msg\":\"用户信息获取失败\",\"code\":500}', 0, NULL, '2025-11-06 05:53:40', 5909);
INSERT INTO `sys_oper_log` VALUES (116, '用户报名', 1, 'com.match.event.controller.UserRegistrationController.register()', 'POST', 1, 'admin', NULL, '/event/user/registration/1', '127.0.0.1', '', '1 {\"params\":{},\"userId\":1}', '{\"msg\":\"用户信息获取失败\",\"code\":500}', 0, NULL, '2025-11-06 05:58:11', 264023);
INSERT INTO `sys_oper_log` VALUES (117, '用户报名', 1, 'com.match.event.controller.UserRegistrationController.register()', 'POST', 1, 'admin', NULL, '/event/user/registration/1', '127.0.0.1', '', '1 {\"params\":{},\"userId\":1}', '{\"msg\":\"用户信息获取失败\",\"code\":500}', 0, NULL, '2025-11-06 06:00:16', 11325);
INSERT INTO `sys_oper_log` VALUES (118, '用户报名', 1, 'com.match.event.controller.UserRegistrationController.register()', 'POST', 1, 'admin', NULL, '/event/user/registration/1', '127.0.0.1', '', '1 {\"params\":{},\"userId\":1}', '{\"msg\":\"用户信息获取失败\",\"code\":500}', 0, NULL, '2025-11-06 06:00:55', 7480);
INSERT INTO `sys_oper_log` VALUES (119, '用户报名', 1, 'com.match.event.controller.UserRegistrationController.register()', 'POST', 1, 'admin', NULL, '/event/user/registration/1', '127.0.0.1', '', '1 {\"params\":{},\"userId\":1}', '{\"msg\":\"用户信息获取失败\",\"code\":500}', 0, NULL, '2025-11-06 06:18:36', 17582);
INSERT INTO `sys_oper_log` VALUES (120, '用户报名', 1, 'com.match.event.controller.UserRegistrationController.register()', 'POST', 1, 'admin', NULL, '/event/user/registration/1', '127.0.0.1', '', '1 {\"params\":{},\"userId\":1}', '{\"msg\":\"用户信息获取失败\",\"code\":500}', 0, NULL, '2025-11-06 06:21:05', 13209);
INSERT INTO `sys_oper_log` VALUES (121, '用户报名', 1, 'com.match.event.controller.UserRegistrationController.register()', 'POST', 1, 'admin', NULL, '/event/user/registration/1', '127.0.0.1', '', '1 {\"params\":{},\"userId\":1}', '{\"msg\":\"用户信息获取失败\",\"code\":500}', 0, NULL, '2025-11-06 06:34:21', 71604);
INSERT INTO `sys_oper_log` VALUES (122, '用户报名', 1, 'com.match.event.controller.UserRegistrationController.register()', 'POST', 1, 'admin', NULL, '/event/user/registration/1', '127.0.0.1', '', '1 {\"eventId\":1,\"id\":1,\"params\":{},\"registrationNo\":\"REG17624116030473v0LGs\",\"status\":\"1\",\"userEmail\":\"ry@163.com\",\"userId\":1,\"userName\":\"admin\",\"userPhone\":\"15888888888\"}', '{\"msg\":\"报名成功\",\"code\":200}', 0, NULL, '2025-11-06 06:46:31', 339494);
INSERT INTO `sys_oper_log` VALUES (123, '用户报名', 1, 'com.match.event.controller.UserRegistrationController.register()', 'POST', 1, 'admin', NULL, '/event/user/registration/1', '127.0.0.1', '', '1 {\"params\":{},\"userId\":1}', '{\"msg\":\"您已报名该赛事\",\"code\":500}', 0, NULL, '2025-11-06 06:47:04', 14);
INSERT INTO `sys_oper_log` VALUES (124, '用户报名', 1, 'com.match.event.controller.UserRegistrationController.register()', 'POST', 1, 'admin', NULL, '/event/user/registration/1', '127.0.0.1', '', '1 {\"eventId\":1,\"id\":3,\"params\":{},\"registrationNo\":\"REG1762412045665C4Ax4i\",\"status\":\"1\",\"userEmail\":\"ry@163.com\",\"userId\":1,\"userName\":\"admin\",\"userPhone\":\"15888888888\"}', '{\"msg\":\"报名成功\",\"code\":200}', 0, NULL, '2025-11-06 06:53:49', 4024);
INSERT INTO `sys_oper_log` VALUES (125, '用户报名', 1, 'com.match.event.controller.UserRegistrationController.register()', 'POST', 1, 'admin', NULL, '/event/user/registration/1', '127.0.0.1', '', '1 {\"eventId\":1,\"id\":2,\"params\":{},\"registrationNo\":\"REG1762412039886esBZsq\",\"status\":\"1\",\"userEmail\":\"ry@163.com\",\"userId\":1,\"userName\":\"admin\",\"userPhone\":\"15888888888\"}', '{\"msg\":\"报名成功\",\"code\":200}', 0, NULL, '2025-11-06 06:54:02', 385511);
INSERT INTO `sys_oper_log` VALUES (126, '用户报名', 1, 'com.match.event.controller.UserRegistrationController.register()', 'POST', 1, 'admin', NULL, '/event/user/registration/1', '127.0.0.1', '', '1 {\"eventId\":1,\"id\":4,\"params\":{},\"registrationNo\":\"REG1762412090553tu4gUc\",\"status\":\"1\",\"userEmail\":\"ry@163.com\",\"userId\":1,\"userName\":\"admin\",\"userPhone\":\"15888888888\"}', '{\"msg\":\"报名成功\",\"code\":200}', 0, NULL, '2025-11-06 06:54:50', 5887);
INSERT INTO `sys_oper_log` VALUES (127, '用户报名', 1, 'com.match.event.controller.UserRegistrationController.register()', 'POST', 1, 'admin', NULL, '/event/user/registration/1', '127.0.0.1', '', '1 {\"params\":{},\"userId\":1}', '{\"msg\":\"您已报名该赛事\",\"code\":500}', 0, NULL, '2025-11-06 06:55:15', 9);
INSERT INTO `sys_oper_log` VALUES (128, '用户报名', 1, 'com.match.event.controller.UserRegistrationController.register()', 'POST', 1, 'admin', NULL, '/event/user/registration/1', '127.0.0.1', '', '1 {\"eventId\":1,\"id\":5,\"params\":{},\"registrationNo\":\"REG1762412167903VS3s3Q\",\"status\":\"1\",\"userEmail\":\"1534975668@qq.com\",\"userId\":1,\"userName\":\"admin\",\"userPhone\":\"15888888888\"}', '{\"msg\":\"报名成功\",\"code\":200}', 0, NULL, '2025-11-06 06:55:51', 3640);
INSERT INTO `sys_oper_log` VALUES (129, '用户报名', 1, 'com.match.event.controller.UserRegistrationController.register()', 'POST', 1, 'admin', NULL, '/event/user/registration/1', '127.0.0.1', '', '1 {\"eventId\":1,\"id\":6,\"params\":{},\"registrationNo\":\"REG17624131902559CNual\",\"status\":\"1\",\"userEmail\":\"1534975668@qq.com\",\"userId\":1,\"userName\":\"admin\",\"userPhone\":\"15888888888\"}', '{\"msg\":\"报名成功\",\"code\":200}', 0, NULL, '2025-11-06 07:12:57', 8469);
INSERT INTO `sys_oper_log` VALUES (130, '参数管理', 2, 'com.match.system.controller.SysConfigController.edit()', 'PUT', 1, 'admin', NULL, '/config', '127.0.0.1', '', '{\"configId\":4,\"configKey\":\"sys.account.registerUser\",\"configName\":\"账号自助-是否开启用户注册功能\",\"configType\":\"Y\",\"configValue\":\"false\",\"createBy\":\"admin\",\"createTime\":\"2025-11-05 07:49:29\",\"params\":{},\"remark\":\"是否开启注册用户功能（true开启，false关闭）\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-06 08:13:43', 44);
INSERT INTO `sys_oper_log` VALUES (131, '参数管理', 9, 'com.match.system.controller.SysConfigController.refreshCache()', 'DELETE', 1, 'admin', NULL, '/config/refreshCache', '127.0.0.1', '', '', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-06 08:14:01', 51);
INSERT INTO `sys_oper_log` VALUES (132, '参数管理', 2, 'com.match.system.controller.SysConfigController.edit()', 'PUT', 1, 'admin', NULL, '/config', '127.0.0.1', '', '{\"configId\":4,\"configKey\":\"sys.account.registerUser\",\"configName\":\"账号自助-是否开启用户注册功能\",\"configType\":\"Y\",\"configValue\":\"true\",\"createBy\":\"admin\",\"createTime\":\"2025-11-05 07:49:29\",\"params\":{},\"remark\":\"是否开启注册用户功能（true开启，false关闭）\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-06 08:13:42\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-06 08:14:33', 21);
INSERT INTO `sys_oper_log` VALUES (133, '参数管理', 9, 'com.match.system.controller.SysConfigController.refreshCache()', 'DELETE', 1, 'admin', NULL, '/config/refreshCache', '127.0.0.1', '', '', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-06 08:14:35', 22);
INSERT INTO `sys_oper_log` VALUES (134, '用户报名', 1, 'com.match.event.controller.UserRegistrationController.register()', 'POST', 1, '18363975598', NULL, '/event/user/registration/1', '127.0.0.1', '', '1 {\"eventId\":1,\"id\":7,\"params\":{},\"registrationNo\":\"REG1762421088023KHKjHh\",\"status\":\"1\",\"userEmail\":\"1534975668@qq.com\",\"userId\":101,\"userName\":\"18363975598\",\"userPhone\":\"18363975598\"}', '{\"msg\":\"报名成功\",\"code\":200}', 0, NULL, '2025-11-06 09:24:52', 4633);
INSERT INTO `sys_oper_log` VALUES (135, '用户报名', 1, 'com.match.event.controller.UserRegistrationController.register()', 'POST', 1, '18363975598', NULL, '/event/user/registration/1', '127.0.0.1', '', '1 {\"params\":{},\"userId\":101}', '{\"msg\":\"您已报名该赛事\",\"code\":500}', 0, NULL, '2025-11-06 09:26:09', 19610);
INSERT INTO `sys_oper_log` VALUES (136, '用户报名', 1, 'com.match.event.controller.UserRegistrationController.register()', 'POST', 1, '18363975598', NULL, '/event/user/registration/1', '127.0.0.1', '', '1 {\"eventId\":1,\"id\":8,\"params\":{},\"registrationNo\":\"REG1762421225562TwNRmh\",\"status\":\"1\",\"userEmail\":\"1534975668@qq.com\",\"userId\":101,\"userName\":\"18363975598\",\"userPhone\":\"18363975598\"}', '{\"msg\":\"报名成功\",\"code\":200}', 0, NULL, '2025-11-06 09:27:02', 33235);
INSERT INTO `sys_oper_log` VALUES (137, '用户报名', 1, 'com.match.event.controller.UserRegistrationController.register()', 'POST', 1, '18363975598', NULL, '/event/user/registration/1', '127.0.0.1', '', '1 {\"eventId\":1,\"id\":9,\"params\":{},\"registrationNo\":\"REG1762421308202omalE4\",\"status\":\"1\",\"userEmail\":\"1534975668@qq.com\",\"userId\":101,\"userName\":\"18363975598\",\"userPhone\":\"18363975598\"}', '{\"msg\":\"报名成功\",\"code\":200}', 0, NULL, '2025-11-06 09:28:11', 2943);
INSERT INTO `sys_oper_log` VALUES (138, '用户报名', 1, 'com.match.event.controller.UserRegistrationController.register()', 'POST', 1, '18363975598', NULL, '/event/user/registration/1', '127.0.0.1', '', '1 {\"eventId\":1,\"id\":10,\"params\":{},\"registrationNo\":\"REG1762421367402nx1zce\",\"status\":\"1\",\"userEmail\":\"1534975668@qq.com\",\"userId\":101,\"userName\":\"18363975598\",\"userPhone\":\"18363975598\"}', '{\"msg\":\"报名成功\",\"code\":200}', 0, NULL, '2025-11-06 09:29:20', 9266);
INSERT INTO `sys_oper_log` VALUES (139, '用户报名', 1, 'com.match.event.controller.UserRegistrationController.register()', 'POST', 1, 'admin', NULL, '/event/user/registration/1', '127.0.0.1', '', '1 {\"eventId\":1,\"id\":11,\"params\":{},\"registrationNo\":\"REG1762421720004zPZKvW\",\"status\":\"1\",\"userEmail\":\"1534975668@qq.com\",\"userId\":1,\"userName\":\"admin\",\"userPhone\":\"15888888888\"}', '{\"msg\":\"报名失败: [503] during [POST] to [http://match-mq/producer/sign-success] [RemoteMqService#sendSignSuccessMessage(SignSuccessMessage)]: [Load balancer does not contain an instance for the service match-mq]\",\"code\":500}', 0, NULL, '2025-11-06 09:35:06', 2669);
INSERT INTO `sys_oper_log` VALUES (140, '用户报名', 1, 'com.match.event.controller.UserRegistrationController.register()', 'POST', 1, 'admin', NULL, '/event/user/registration/1', '127.0.0.1', '', '1 {\"params\":{},\"userId\":1}', '{\"msg\":\"您已报名该赛事\",\"code\":500}', 0, NULL, '2025-11-06 09:38:13', 3);
INSERT INTO `sys_oper_log` VALUES (141, '用户报名', 1, 'com.match.event.controller.UserRegistrationController.register()', 'POST', 1, 'admin', NULL, '/event/user/registration/1', '127.0.0.1', '', '1 {\"params\":{},\"userId\":1}', '{\"msg\":\"您已报名该赛事\",\"code\":500}', 0, NULL, '2025-11-06 09:38:01', 8);
INSERT INTO `sys_oper_log` VALUES (142, '用户报名', 1, 'com.match.event.controller.UserRegistrationController.register()', 'POST', 1, 'admin', NULL, '/event/user/registration/1', '127.0.0.1', '', '1 {\"eventId\":1,\"id\":12,\"params\":{},\"registrationNo\":\"REG17624219185554HcmNW\",\"status\":\"1\",\"userEmail\":\"1534975668@qq.com\",\"userId\":1,\"userName\":\"admin\",\"userPhone\":\"15888888888\"}', '{\"msg\":\"报名成功\",\"code\":200}', 0, NULL, '2025-11-06 09:38:48', 10263);
INSERT INTO `sys_oper_log` VALUES (143, '用户报名', 1, 'com.match.event.controller.UserRegistrationController.register()', 'POST', 1, 'admin', NULL, '/event/user/registration/1', '127.0.0.1', '', '1 {\"params\":{},\"userId\":1}', '{\"msg\":\"您已报名该赛事\",\"code\":500}', 0, NULL, '2025-11-06 09:38:48', 6);
INSERT INTO `sys_oper_log` VALUES (144, '用户报名', 1, 'com.match.event.controller.UserRegistrationController.register()', 'POST', 1, 'admin', NULL, '/event/user/registration/1', '127.0.0.1', '', '1 {\"eventId\":1,\"id\":13,\"params\":{},\"registrationNo\":\"REG1762421964036OYrYW0\",\"status\":\"1\",\"userEmail\":\"1534975668@qq.com\",\"userId\":1,\"userName\":\"admin\",\"userPhone\":\"15888888888\"}', '{\"msg\":\"报名成功\",\"code\":200}', 0, NULL, '2025-11-06 09:39:24', 35);
INSERT INTO `sys_oper_log` VALUES (145, '参数管理', 9, 'com.match.system.controller.SysConfigController.refreshCache()', 'DELETE', 1, 'admin', NULL, '/config/refreshCache', '127.0.0.1', '', '', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-07 00:50:14', 56);
INSERT INTO `sys_oper_log` VALUES (146, '字典类型', 9, 'com.match.system.controller.SysDictTypeController.refreshCache()', 'DELETE', 1, 'admin', NULL, '/dict/type/refreshCache', '127.0.0.1', '', '', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-07 00:50:26', 46);
INSERT INTO `sys_oper_log` VALUES (147, '用户报名', 1, 'com.match.event.controller.UserRegistrationController.register()', 'POST', 1, 'admin', NULL, '/event/user/registration/1', '127.0.0.1', '', '1 {\"eventId\":1,\"id\":14,\"params\":{},\"registrationNo\":\"REG1762485691542mZ1Kjg\",\"status\":\"1\",\"userEmail\":\"1534975668@qq.com\",\"userId\":1,\"userName\":\"admin\",\"userPhone\":\"15888888888\"}', '{\"msg\":\"报名成功\",\"code\":200}', 0, NULL, '2025-11-07 03:21:18', 5186);
INSERT INTO `sys_oper_log` VALUES (148, '赛事', 1, 'com.match.event.controller.EventController.add()', 'POST', 1, 'admin', NULL, '/event', '127.0.0.1', '', '{\"currentParticipants\":0,\"eventName\":\"北京马拉松比赛\",\"eventTime\":\"2025-11-29\",\"id\":2,\"maxParticipants\":1000,\"params\":{},\"registrationEndTime\":\"2025-11-23\",\"registrationStartTime\":\"2025-11-01\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-07 03:33:48', 26);
INSERT INTO `sys_oper_log` VALUES (149, '赛事', 2, 'com.match.event.controller.EventController.edit()', 'PUT', 1, 'admin', NULL, '/event', '127.0.0.1', '', '{\"createBy\":\"\",\"createTime\":\"2025-11-07 03:33:48\",\"currentParticipants\":0,\"eventName\":\"北京马拉松比赛\",\"eventPhoto\":\"http://127.0.0.1:9000/match/2025/11/07/vlcsnap-2024-09-10-14h26m25s535_20251107135206A001.png\",\"eventTime\":\"2025-11-29 00:00:00\",\"id\":2,\"maxParticipants\":1000,\"params\":{},\"registrationEndTime\":\"2025-11-23 00:00:00\",\"registrationStartTime\":\"2025-11-01 00:00:00\",\"status\":\"0\",\"updateBy\":\"\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-07 05:52:26', 108);
INSERT INTO `sys_oper_log` VALUES (150, '赛事', 2, 'com.match.event.controller.EventController.edit()', 'PUT', 1, 'admin', NULL, '/event', '127.0.0.1', '', '{\"createBy\":\"\",\"createTime\":\"2025-11-07 03:33:48\",\"currentParticipants\":0,\"eventName\":\"北京马拉松比赛\",\"eventPhoto\":\"http://127.0.0.1:9000/match/2025/11/07/vlcsnap-2024-09-10-14h27m57s485_20251107154552A001.png\",\"eventTime\":\"2025-11-29 00:00:00\",\"id\":2,\"maxParticipants\":1000,\"params\":{},\"registrationEndTime\":\"2025-11-23 00:00:00\",\"registrationStartTime\":\"2025-11-01 00:00:00\",\"status\":\"0\",\"updateBy\":\"\",\"updateTime\":\"2025-11-07 05:52:26\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-07 07:45:37', 47);
INSERT INTO `sys_oper_log` VALUES (151, '赛事', 2, 'com.match.event.controller.EventController.edit()', 'PUT', 1, 'admin', NULL, '/event', '127.0.0.1', '', '{\"createBy\":\"\",\"createTime\":\"2025-11-07 03:33:48\",\"currentParticipants\":0,\"eventName\":\"北京马拉松比赛\",\"eventPhoto\":\"\",\"eventTime\":\"2025-11-29 00:00:00\",\"id\":2,\"maxParticipants\":1000,\"params\":{},\"registrationEndTime\":\"2025-11-23 00:00:00\",\"registrationStartTime\":\"2025-11-01 00:00:00\",\"status\":\"0\",\"updateBy\":\"\",\"updateTime\":\"2025-11-07 07:45:36\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-07 07:45:45', 12);
INSERT INTO `sys_oper_log` VALUES (152, '用户报名', 1, 'com.match.event.controller.UserRegistrationController.register()', 'POST', 1, 'admin', NULL, '/event/user/registration/2', '127.0.0.1', '', '2 {\"eventId\":2,\"id\":15,\"params\":{},\"registrationNo\":\"REG1762513153594tFneKw\",\"status\":\"1\",\"userEmail\":\"1534975668@qq.com\",\"userId\":1,\"userName\":\"admin\",\"userPhone\":\"15888888888\"}', '{\"msg\":\"报名成功\",\"code\":200}', 0, NULL, '2025-11-07 10:58:56', 433);
INSERT INTO `sys_oper_log` VALUES (153, '用户报名', 1, 'com.match.event.controller.UserRegistrationController.register()', 'POST', 1, 'admin', NULL, '/event/user/registration/2', '127.0.0.1', '', '2 {\"eventId\":2,\"id\":16,\"params\":{},\"registrationNo\":\"REG1762513345709mtLWQ6\",\"status\":\"1\",\"userEmail\":\"1534975668@qq.com\",\"userId\":1,\"userName\":\"admin\",\"userPhone\":\"15888888888\"}', '{\"msg\":\"报名成功\",\"code\":200}', 0, NULL, '2025-11-07 11:02:11', 3314);
INSERT INTO `sys_oper_log` VALUES (154, '用户报名', 1, 'com.match.event.controller.UserRegistrationController.register()', 'POST', 1, 'admin', NULL, '/event/user/registration/1', '127.0.0.1', '', '1 {\"eventId\":1,\"id\":17,\"params\":{},\"registrationNo\":\"REG1762513598297qboAIu\",\"status\":\"1\",\"userEmail\":\"1534975668@qq.com\",\"userId\":1,\"userName\":\"admin\",\"userPhone\":\"15888888888\"}', '{\"msg\":\"报名成功\",\"code\":200}', 0, NULL, '2025-11-07 11:06:20', 50);
INSERT INTO `sys_oper_log` VALUES (155, '赛事', 2, 'com.match.event.controller.EventController.edit()', 'PUT', 1, 'admin', NULL, '/event', '127.0.0.1', '', '{\"createBy\":\"\",\"createTime\":\"2025-11-07 03:33:48\",\"currentParticipants\":2,\"eventName\":\"北京马拉松比赛\",\"eventPhoto\":\"http://127.0.0.1:9000/match/2025/11/08/WIN_20240228_17_09_40_Pro_20251108092033A001.jpg\",\"eventTime\":\"2025-11-29 00:00:00\",\"id\":2,\"maxParticipants\":1000,\"params\":{},\"registrationEndTime\":\"2025-11-23 00:00:00\",\"registrationStartTime\":\"2025-11-01 00:00:00\",\"status\":\"0\",\"updateBy\":\"\",\"updateTime\":\"2025-11-07 11:02:07\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-08 01:20:16', 191);

-- ----------------------------
-- Table structure for sys_oss
-- ----------------------------
DROP TABLE IF EXISTS `sys_oss`;
CREATE TABLE `sys_oss`  (
  `oss_id` bigint NOT NULL AUTO_INCREMENT,
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '文件名',
  `original_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '原名',
  `file_suffix` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '文件后缀名',
  `url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'URL地址',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '上传人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `service` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'minio' COMMENT '服务商',
  `md5` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文件MD5',
  `upload_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '大文件上传任务ID',
  `upload_status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '上传状态',
  PRIMARY KEY (`oss_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 120 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'OSS对象存储表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oss
-- ----------------------------

-- ----------------------------
-- Table structure for sys_oss_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_oss_config`;
CREATE TABLE `sys_oss_config`  (
  `oss_config_id` bigint NOT NULL COMMENT '主建',
  `config_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '配置key',
  `access_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT 'accessKey',
  `secret_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '秘钥',
  `bucket_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '桶名称',
  `prefix` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '前缀',
  `endpoint` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '访问站点',
  `domain` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '自定义域名',
  `is_https` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '是否https（Y=是,N=否）',
  `region` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '域',
  `access_policy` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1' COMMENT '桶权限类型(0=private 1=public 2=custom)',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '状态（0=正常,1=停用）',
  `ext1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '扩展字段',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`oss_config_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '对象存储配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oss_config
-- ----------------------------
INSERT INTO `sys_oss_config` VALUES (1787676726404419585, 'minio', 'minioadmin', 'minioadmin', 'match', '', 'localhost:9000', '', 'N', '', '1', '0', '', 'admin', '2024-05-07 10:51:59', 'admin', '2024-05-07 10:59:02', '');

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '岗位信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2025-11-05 07:49:35', '', NULL, '');
INSERT INTO `sys_post` VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2025-11-05 07:49:35', '', NULL, '');
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2025-11-05 07:49:35', '', NULL, '');
INSERT INTO `sys_post` VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2025-11-05 07:49:35', '', NULL, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2025-11-05 07:49:36', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2025-11-05 07:49:36', '', NULL, '普通角色');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和部门关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100);
INSERT INTO `sys_role_dept` VALUES (2, 101);
INSERT INTO `sys_role_dept` VALUES (2, 105);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (1, 2000);
INSERT INTO `sys_role_menu` VALUES (1, 2001);
INSERT INTO `sys_role_menu` VALUES (1, 2002);
INSERT INTO `sys_role_menu` VALUES (1, 2003);
INSERT INTO `sys_role_menu` VALUES (1, 2004);
INSERT INTO `sys_role_menu` VALUES (1, 2005);
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 2);
INSERT INTO `sys_role_menu` VALUES (2, 3);
INSERT INTO `sys_role_menu` VALUES (2, 4);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 101);
INSERT INTO `sys_role_menu` VALUES (2, 102);
INSERT INTO `sys_role_menu` VALUES (2, 103);
INSERT INTO `sys_role_menu` VALUES (2, 104);
INSERT INTO `sys_role_menu` VALUES (2, 105);
INSERT INTO `sys_role_menu` VALUES (2, 106);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 108);
INSERT INTO `sys_role_menu` VALUES (2, 109);
INSERT INTO `sys_role_menu` VALUES (2, 110);
INSERT INTO `sys_role_menu` VALUES (2, 111);
INSERT INTO `sys_role_menu` VALUES (2, 112);
INSERT INTO `sys_role_menu` VALUES (2, 113);
INSERT INTO `sys_role_menu` VALUES (2, 114);
INSERT INTO `sys_role_menu` VALUES (2, 115);
INSERT INTO `sys_role_menu` VALUES (2, 116);
INSERT INTO `sys_role_menu` VALUES (2, 500);
INSERT INTO `sys_role_menu` VALUES (2, 501);
INSERT INTO `sys_role_menu` VALUES (2, 1000);
INSERT INTO `sys_role_menu` VALUES (2, 1001);
INSERT INTO `sys_role_menu` VALUES (2, 1002);
INSERT INTO `sys_role_menu` VALUES (2, 1003);
INSERT INTO `sys_role_menu` VALUES (2, 1004);
INSERT INTO `sys_role_menu` VALUES (2, 1005);
INSERT INTO `sys_role_menu` VALUES (2, 1006);
INSERT INTO `sys_role_menu` VALUES (2, 1007);
INSERT INTO `sys_role_menu` VALUES (2, 1008);
INSERT INTO `sys_role_menu` VALUES (2, 1009);
INSERT INTO `sys_role_menu` VALUES (2, 1010);
INSERT INTO `sys_role_menu` VALUES (2, 1011);
INSERT INTO `sys_role_menu` VALUES (2, 1012);
INSERT INTO `sys_role_menu` VALUES (2, 1013);
INSERT INTO `sys_role_menu` VALUES (2, 1014);
INSERT INTO `sys_role_menu` VALUES (2, 1015);
INSERT INTO `sys_role_menu` VALUES (2, 1016);
INSERT INTO `sys_role_menu` VALUES (2, 1017);
INSERT INTO `sys_role_menu` VALUES (2, 1018);
INSERT INTO `sys_role_menu` VALUES (2, 1019);
INSERT INTO `sys_role_menu` VALUES (2, 1020);
INSERT INTO `sys_role_menu` VALUES (2, 1021);
INSERT INTO `sys_role_menu` VALUES (2, 1022);
INSERT INTO `sys_role_menu` VALUES (2, 1023);
INSERT INTO `sys_role_menu` VALUES (2, 1024);
INSERT INTO `sys_role_menu` VALUES (2, 1025);
INSERT INTO `sys_role_menu` VALUES (2, 1026);
INSERT INTO `sys_role_menu` VALUES (2, 1027);
INSERT INTO `sys_role_menu` VALUES (2, 1028);
INSERT INTO `sys_role_menu` VALUES (2, 1029);
INSERT INTO `sys_role_menu` VALUES (2, 1030);
INSERT INTO `sys_role_menu` VALUES (2, 1031);
INSERT INTO `sys_role_menu` VALUES (2, 1032);
INSERT INTO `sys_role_menu` VALUES (2, 1033);
INSERT INTO `sys_role_menu` VALUES (2, 1034);
INSERT INTO `sys_role_menu` VALUES (2, 1035);
INSERT INTO `sys_role_menu` VALUES (2, 1036);
INSERT INTO `sys_role_menu` VALUES (2, 1037);
INSERT INTO `sys_role_menu` VALUES (2, 1038);
INSERT INTO `sys_role_menu` VALUES (2, 1039);
INSERT INTO `sys_role_menu` VALUES (2, 1040);
INSERT INTO `sys_role_menu` VALUES (2, 1041);
INSERT INTO `sys_role_menu` VALUES (2, 1042);
INSERT INTO `sys_role_menu` VALUES (2, 1043);
INSERT INTO `sys_role_menu` VALUES (2, 1044);
INSERT INTO `sys_role_menu` VALUES (2, 1045);
INSERT INTO `sys_role_menu` VALUES (2, 1046);
INSERT INTO `sys_role_menu` VALUES (2, 1047);
INSERT INTO `sys_role_menu` VALUES (2, 1048);
INSERT INTO `sys_role_menu` VALUES (2, 1049);
INSERT INTO `sys_role_menu` VALUES (2, 1050);
INSERT INTO `sys_role_menu` VALUES (2, 1051);
INSERT INTO `sys_role_menu` VALUES (2, 1052);
INSERT INTO `sys_role_menu` VALUES (2, 1053);
INSERT INTO `sys_role_menu` VALUES (2, 1054);
INSERT INTO `sys_role_menu` VALUES (2, 1055);
INSERT INTO `sys_role_menu` VALUES (2, 1056);
INSERT INTO `sys_role_menu` VALUES (2, 1057);
INSERT INTO `sys_role_menu` VALUES (2, 1058);
INSERT INTO `sys_role_menu` VALUES (2, 1059);
INSERT INTO `sys_role_menu` VALUES (2, 1060);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '账号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `pwd_update_date` datetime NULL DEFAULT NULL COMMENT '密码最后更新时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 102 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '若依', '00', '1534975668@qq.com', '15888888888', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2025-11-13 15:14:35', '2025-11-05 07:49:35', 'admin', '2025-11-05 07:49:35', '', NULL, '管理员');
INSERT INTO `sys_user` VALUES (2, 105, 'ry', '若依', '00', '1534975668@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2025-11-05 07:49:35', '2025-11-05 07:49:35', 'admin', '2025-11-05 07:49:35', '', NULL, '测试员');
INSERT INTO `sys_user` VALUES (100, NULL, '18363975597', '18363975597', '00', '1534975668@qq.com', '18363975597', '0', '', '$2a$10$jLlaM/7U/Ubiv/1lCZ81eeoL174NwvebYUxeBoYrjHVXsZhGXY/Em', '0', '0', '127.0.0.1', '2025-11-06 16:17:01', '2025-11-06 16:14:57', '', '2025-11-06 08:14:40', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (101, NULL, '18363975598', '18363975598', '00', '1534975668@qq.com', '18363975598', '0', '', '$2a$10$ddMcRL7vhlhfTwEtRj/vlOE/rRWP800XKQtd7KasVxTJu9HJA7Fia', '0', '0', '127.0.0.1', '2025-11-06 16:47:00', '2025-11-06 16:46:33', '', '2025-11-06 08:46:32', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (2, 2);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户和角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);

SET FOREIGN_KEY_CHECKS = 1;
