SET NAMES utf8mb4;

-- ----------------------------
-- match-event 模块表结构
-- ----------------------------

-- ----------------------------
-- 1、马拉松赛事表
-- ----------------------------
DROP TABLE IF EXISTS marathon_event;
CREATE TABLE `marathon_event` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '赛事ID',
  `event_name` varchar(100) NOT NULL COMMENT '赛事名称',
  `event_description` varchar(500) DEFAULT NULL COMMENT '赛事描述',
  `event_time` datetime NOT NULL COMMENT '赛事时间',
  `registration_start_time` datetime NOT NULL COMMENT '报名开始时间',
  `registration_end_time` datetime NOT NULL COMMENT '报名截止时间',
  `max_participants` int(11) NOT NULL DEFAULT '0' COMMENT '最大参赛人数',
  `current_participants` int(11) NOT NULL DEFAULT '0' COMMENT '当前参赛人数',
  `status` char(1) NOT NULL DEFAULT '0' COMMENT '赛事状态（0正常 1关闭 2已结束）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='马拉松赛事表';

-- ----------------------------
-- 2、参赛者信息表
-- ----------------------------
DROP TABLE IF EXISTS participant;
CREATE TABLE `participant` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '参赛者ID',
  `registration_id` bigint(20) NOT NULL COMMENT '报名ID',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `emergency_contact` varchar(50) DEFAULT NULL COMMENT '紧急联系人',
  `emergency_phone` varchar(20) DEFAULT NULL COMMENT '紧急联系人电话',
  `photo` varchar(255) DEFAULT NULL COMMENT '参赛者照片',
  `id_card` varchar(18) DEFAULT NULL COMMENT '参赛者身份证号',
  `address` varchar(255) DEFAULT NULL COMMENT '参赛者地址',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `idx_registration_id` (`registration_id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='参赛者信息表';

-- ----------------------------
-- 3、报名记录表
-- ----------------------------
DROP TABLE IF EXISTS registration;
CREATE TABLE `registration` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '报名ID',
  `event_id` bigint(20) NOT NULL COMMENT '赛事ID',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `registration_no` varchar(32) NOT NULL COMMENT '报名编号',
  `user_name` varchar(50) NOT NULL COMMENT '用户姓名',
  `user_phone` varchar(20) NOT NULL COMMENT '用户手机号',
  `user_email` varchar(100) NOT NULL COMMENT '用户邮箱',
  `status` char(1) NOT NULL DEFAULT '0' COMMENT '报名状态（0待支付 1已支付 2已取消 3已完成）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_reg_no` (`registration_no`),
  KEY `idx_event_id` (`event_id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='报名记录表';

-- ----------------------------
-- match-email 模块表结构
-- ----------------------------

-- ----------------------------
-- 4、邮件记录表
-- ----------------------------
DROP TABLE IF EXISTS email_record;
CREATE TABLE `email_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `sender` varchar(100) NOT NULL COMMENT '发送者',
  `receiver` varchar(1000) NOT NULL COMMENT '接收者',
  `subject` varchar(255) NOT NULL COMMENT '邮件主题',
  `content` text NOT NULL COMMENT '邮件内容',
  `status` char(1) NOT NULL DEFAULT '0' COMMENT '发送状态（0成功 1失败）',
  `error_msg` text DEFAULT NULL COMMENT '失败原因',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_sender` (`sender`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='邮件记录表';

-- ----------------------------
-- 初始化-赛事数据
-- ----------------------------
INSERT INTO `marathon_event` VALUES (1, '济南马拉松', '2024济南马拉松赛事，包括全程马拉松、半程马拉松和迷你马拉松', '2024-11-10 08:00:00', '2024-09-01 00:00:00', '2024-10-20 23:59:59', 10000, 0, '0', 'admin', sysdate(), '', NULL, '济南马拉松赛事');