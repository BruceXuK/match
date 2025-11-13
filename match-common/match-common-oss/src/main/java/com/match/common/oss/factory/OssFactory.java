package com.match.common.oss.factory;

import com.match.common.core.constant.CacheNames;
import com.match.common.core.utils.StringUtils;
import com.match.common.json.utils.JsonUtils;
import com.match.common.oss.constant.OssConstant;
import com.match.common.oss.core.OssClient;
import com.match.common.oss.exception.OssException;
import com.match.common.oss.properties.OssProperties;
import com.match.common.redis.utils.CacheUtils;
import com.match.common.redis.utils.RedisUtils;
import lombok.extern.slf4j.Slf4j;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 文件上传工厂类
 * <p>
 * 负责创建和管理OSS客户端实例，采用单例模式和缓存机制提高性能。
 * 通过配置键获取对应的OSS客户端实例，并支持动态重载配置。
 *
 * @author Lion Li
 */
@Slf4j
public class OssFactory {

    /**
     * OSS客户端实例缓存
     * 使用线程安全的ConcurrentHashMap存储不同配置键对应的OSS客户端实例，
     * 避免重复创建相同配置的客户端，提高系统性能。
     */
    private static final Map<String, OssClient> CLIENT_CACHE = new ConcurrentHashMap<>();

    /**
     * 获取默认OSS客户端实例
     * <p>
     * 从Redis缓存中获取默认配置键，然后根据该配置键获取对应的OSS客户端实例。
     *
     * @return 默认的OSS客户端实例
     * @throws OssException 当无法找到文件存储服务类型时抛出异常
     */
    public static OssClient instance() {
        // 获取redis 默认类型
        String configKey = RedisUtils.getCacheObject(OssConstant.DEFAULT_CONFIG_KEY);
        if (StringUtils.isEmpty(configKey)) {
            throw new OssException("文件存储服务类型无法找到!");
        }
        return instance(configKey);
    }

    /**
     * 根据配置键获取OSS客户端实例
     * <p>
     * 首先从缓存中获取配置信息，然后检查是否存在对应的客户端实例。
     * 如果不存在或配置发生变化，则创建新的客户端实例。
     *
     * @param configKey 配置键，用于标识不同的OSS配置
     * @return 对应配置键的OSS客户端实例
     * @throws OssException 当配置信息不存在时抛出异常
     */
    public static OssClient instance(String configKey) {
        String json = CacheUtils.get(CacheNames.SYS_OSS_CONFIG, configKey);
        if (json == null) {
            throw new OssException("系统异常, '" + configKey + "'配置信息不存在!");
        }
        OssProperties properties = JsonUtils.parseObject(json, OssProperties.class);
        OssClient client = CLIENT_CACHE.get(configKey);
        if (client == null) {
            CLIENT_CACHE.put(configKey, new OssClient(configKey, properties));
            log.info("创建OSS实例 key => {}", configKey);
            return CLIENT_CACHE.get(configKey);
        }
        // 配置不相同则重新构建
        if (!client.checkPropertiesSame(properties)) {
            CLIENT_CACHE.put(configKey, new OssClient(configKey, properties));
            log.info("重载OSS实例 key => {}", configKey);
            return CLIENT_CACHE.get(configKey);
        }
        return client;
    }

}