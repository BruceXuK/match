package com.match.common.oss.enums;

import com.amazonaws.services.s3.model.CannedAccessControlList;
import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 存储桶访问策略类型枚举
 * <p>
 * 定义OSS存储桶的访问控制策略，包括私有、公共读和自定义三种类型。
 * 每种策略类型对应不同的文件访问权限和存储桶策略配置。
 *
 * @author 陈賝
 */
@AllArgsConstructor
public enum AccessPolicyType {

    /**
     * 私有策略
     * 存储桶和对象都只能由所有者访问，不允许其他用户访问
     */
    PRIVATE("0", CannedAccessControlList.Private, PolicyType.WRITE),

    /**
     * 公共读策略
     * 存储桶中的对象可以被任何人读取，但只能由所有者写入
     */
    PUBLIC("1", CannedAccessControlList.PublicRead, PolicyType.READ),

    /**
     * 自定义策略
     * 用户可以自定义访问策略，这里默认设置为公共读
     */
    CUSTOM("2",CannedAccessControlList.PublicRead, PolicyType.READ);

    /**
     * 策略类型标识
     * 用于在数据库或配置中标识策略类型，0-私有，1-公共读，2-自定义
     */
    private final String type;

    /**
     * AWS S3访问控制列表
     * 对应AWS S3的预定义访问控制策略，用于设置对象的访问权限
     */
    private final CannedAccessControlList acl;

    /**
     * 策略类型
     * 对应MinIO的策略类型，用于构建存储桶策略JSON
     */
    private final PolicyType policyType;

    /**
     * 根据策略类型标识获取对应的访问策略枚举
     *
     * @param type 策略类型标识字符串
     * @return 对应的访问策略枚举值
     * @throws RuntimeException 当找不到对应的策略类型时抛出异常
     */
    public static AccessPolicyType getByType(String type) {
        for (AccessPolicyType value : values()) {
            if (value.getType().equals(type)) {
                return value;
            }
        }
        throw new RuntimeException("'type' not found By " + type);
    }

    /**
     * 获取策略类型标识
     *
     * @return 策略类型标识字符串
     */
    public String getType() {
        return type;
    }

    /**
     * 获取AWS S3访问控制列表
     *
     * @return AWS S3预定义的访问控制列表
     */
    public CannedAccessControlList getAcl() {
        return acl;
    }

    /**
     * 获取策略类型
     *
     * @return MinIO策略类型枚举值
     */
    public PolicyType getPolicyType() {
        return policyType;
    }
}