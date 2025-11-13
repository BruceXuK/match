package com.match.common.oss.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * MinIO策略类型枚举
 * <p>
 * 定义MinIO存储桶的访问策略类型，包括只读、只写和读写三种权限模式。
 *
 * @author Lion Li
 */
@Getter
@AllArgsConstructor
public enum PolicyType {

    /**
     * 只读策略
     * 允许用户读取存储桶中的对象，但不允许写入或修改
     */
    READ("read-only"),

    /**
     * 只写策略
     * 允许用户向存储桶写入对象，但不允许读取
     */
    WRITE("write-only"),

    /**
     * 读写策略
     * 允许用户既可读取也可写入存储桶中的对象
     */
    READ_WRITE("read-write");

    /**
     * 策略类型标识
     * 存储策略类型的字符串表示，用于构建存储桶策略JSON
     */
    private final String type;

}