package com.match.common.oss.constant;

import java.util.Arrays;
import java.util.List;

/**
 * 对象存储常量类
 * <p>
 * 提供OSS对象存储模块所需的各类常量定义，包括默认配置KEY、系统数据IDs、
 * 支持的云服务商列表、HTTPS状态标识以及文件类型分类等。
 *
 * @author Lion Li
 */
public interface OssConstant {

    /**
     * 默认配置KEY
     * 用于标识系统默认的OSS配置，存储在Redis缓存中
     */
    String DEFAULT_CONFIG_KEY = "sys_oss:default_config";

    /**
     * 预览列表资源开关Key
     * 控制是否允许预览列表资源的配置项
     */
    String PEREVIEW_LIST_RESOURCE_KEY = "sys.oss.previewListResource";

    /**
     * 系统数据ids
     * 定义系统内置的OSS配置ID列表，这些ID对应系统核心配置
     */
    List<Long> SYSTEM_DATA_IDS = Arrays.asList(1L, 2L, 3L, 4L);

    /**
     * 云服务商枚举
     * 包含当前系统支持的所有云服务提供商的标识符
     */
    String[] CLOUD_SERVICE = new String[] {"aliyun", "qcloud", "qiniu", "obs"};

    /**
     * https 状态标识
     * 用于判断是否启用HTTPS协议，"Y"表示启用，其他值表示不启用
     */
    String IS_HTTPS = "Y";
    
    /**
     * 图像类型标识
     * 用于标识文件类型为图像的分类标签
     */
    String IMAGE_TYPE = "image";
    
    /**
     * 文件类型标识
     * 用于标识文件类型为普通文件的分类标签
     */
    String FILE_TYPE = "file";
    
    /**
     * 视频类型标识
     * 用于标识文件类型为视频的分类标签
     */
    String VIDEO_TYPE = "video";

}