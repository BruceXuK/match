package com.match.common.oss.properties;

import lombok.Data;

/**
 * OSS对象存储配置属性类
 * <p>
 * 用于封装OSS对象存储的各种配置参数，包括访问站点、认证信息、存储空间等。
 * 通过Lombok的@Data注解自动生成getter、setter等方法。
 *
 * @author Lion Li
 */
@Data
public class OssProperties {

    /**
     * 访问站点
     * OSS服务的访问地址，如：oss-cn-hangzhou.aliyuncs.com
     */
    private String endpoint;

    /**
     * 自定义域名
     * 用户自定义的访问域名，用于替换默认的OSS访问地址
     */
    private String domain;

    /**
     * 文件路径前缀
     * 上传文件时添加的路径前缀，用于分类管理文件
     */
    private String prefix;

    /**
     * 访问密钥ID
     * 用于身份验证的访问密钥ID
     */
    private String accessKey;

    /**
     * 访问密钥Secret
     * 用于身份验证的访问密钥Secret
     */
    private String secretKey;

    /**
     * 存储空间名
     * OSS中的存储空间(Bucket)名称，用于存储和管理文件
     */
    private String bucketName;

    /**
     * 存储区域
     * OSS服务所在的区域标识，如：cn-hangzhou
     */
    private String region;

    /**
     * 是否启用HTTPS
     * 标识是否使用HTTPS协议进行数据传输，"Y"表示启用，"N"表示不启用
     */
    private String isHttps;

    /**
     * 桶权限类型
     * 存储桶的访问权限类型，"0"-私有，"1"-公共读，"2"-自定义
     */
    private String accessPolicy;

}