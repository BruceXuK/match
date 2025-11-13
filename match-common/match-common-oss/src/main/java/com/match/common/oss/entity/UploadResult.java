package com.match.common.oss.entity;

import lombok.Builder;
import lombok.Data;

/**
 * 文件上传结果实体类
 * <p>
 * 封装文件上传操作的返回结果，包含文件访问URL和文件名等信息。
 * 使用Lombok注解简化代码，通过@Builder提供链式调用方式构建对象。
 *
 * @author Lion Li
 */
@Data
@Builder
public class UploadResult {

    /**
     * 文件访问URL
     * 用于存储文件在OSS中的完整访问地址，可以直接通过该URL访问文件
     */
    private String url;

    /**
     * 文件名
     * 存储上传到OSS后的文件名称，通常为系统生成的唯一标识符
     */
    private String filename;
}