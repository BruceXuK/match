package com.match.file.service.impl;

import java.util.Collection;
import java.util.List;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.ObjectUtil;
import com.match.common.core.constant.CacheNames;
import com.match.common.core.exception.ServiceException;
import com.match.common.core.utils.StringUtils;
import com.match.common.json.utils.JsonUtils;
import com.match.common.oss.constant.OssConstant;
import com.match.common.redis.utils.CacheUtils;
import com.match.common.redis.utils.RedisUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.match.file.mapper.SysOssConfigMapper;
import com.match.file.domain.SysOssConfig;
import com.match.file.service.ISysOssConfigService;
import org.springframework.transaction.annotation.Transactional;

/**
 * 对象存储配置Service业务层处理
 *
 * @author bruceXuu
 */
@Service
public class SysOssConfigServiceImpl implements ISysOssConfigService {

    @Autowired
    private SysOssConfigMapper sysOssConfigMapper;

    /**
     * 项目启动时，初始化参数到缓存，加载配置类
     */
    @Override
    public void init() {
        List<SysOssConfig> list = sysOssConfigMapper.selectSysOssConfigList(new SysOssConfig());
        // 加载OSS初始化配置
        for (SysOssConfig config : list) {
            String configKey = config.getConfigKey();
            if ("0".equals(config.getStatus())) {
                RedisUtils.setCacheObject(OssConstant.DEFAULT_CONFIG_KEY, configKey);
            }
            CacheUtils.put(CacheNames.SYS_OSS_CONFIG, config.getConfigKey(), JsonUtils.toJsonString(config));
        }
    }

    @Override
    public SysOssConfig queryById(Long ossConfigId) {
        return sysOssConfigMapper.selectSysOssConfigById(ossConfigId);
    }

    @Override
    public List<SysOssConfig> queryPageList(SysOssConfig sysOssConfig) {
        return sysOssConfigMapper.selectSysOssConfigList(sysOssConfig);
    }

    @Override
    public Boolean insertByBo(SysOssConfig bo) {
        SysOssConfig config = BeanUtil.toBean(bo, SysOssConfig.class);
        validEntityBeforeSave(config);
        boolean flag = sysOssConfigMapper.insertSysOssConfig(config) > 0;
        if (flag) {
            CacheUtils.put(CacheNames.SYS_OSS_CONFIG, config.getConfigKey(), JsonUtils.toJsonString(config));
        }
        return flag;
    }

    @Override
    public Boolean updateByBo(SysOssConfig bo) {
        SysOssConfig config = BeanUtil.toBean(bo, SysOssConfig.class);
        validEntityBeforeSave(config);
        boolean flag = sysOssConfigMapper.updateSysOssConfig(config) > 0;
        if (flag) {
            CacheUtils.put(CacheNames.SYS_OSS_CONFIG, config.getConfigKey(), JsonUtils.toJsonString(config));
        }
        return flag;
    }

    /**
     * 保存前的数据校验
     */
    private void validEntityBeforeSave(SysOssConfig entity) {
        if (StringUtils.isNotEmpty(entity.getConfigKey()) && !checkConfigKeyUnique(entity)) {
            throw new ServiceException("操作配置'" + entity.getConfigKey() + "'失败, 配置key已存在!");
        }
    }

    @Override
    public Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid) {
        if (isValid) {
            if (CollUtil.containsAny(ids, OssConstant.SYSTEM_DATA_IDS)) {
                throw new ServiceException("系统内置, 不可删除!");
            }
        }
        // 批量删除配置
        Long[] idArray = ids.toArray(new Long[0]);
        boolean result = sysOssConfigMapper.deleteSysOssConfigByIds(idArray) > 0;
        
        if (result) {
            // 清除缓存
            for (Long id : ids) {
                SysOssConfig config = sysOssConfigMapper.selectSysOssConfigById(id);
                if (config != null) {
                    CacheUtils.evict(CacheNames.SYS_OSS_CONFIG, config.getConfigKey());
                }
            }
        }
        
        return result;
    }

    /**
     * 判断configKey是否唯一
     */
    private boolean checkConfigKeyUnique(SysOssConfig sysOssConfig) {
        SysOssConfig queryConfig = new SysOssConfig();
        queryConfig.setConfigKey(sysOssConfig.getConfigKey());
        List<SysOssConfig> configs = sysOssConfigMapper.selectSysOssConfigList(queryConfig);
        
        // 如果没有找到相同configKey的记录，则唯一
        if (configs.isEmpty()) {
            return true;
        }
        
        // 如果找到了记录，但ID相同，则表示是更新自己，也认为唯一
        if (configs.size() == 1 && 
            configs.get(0).getOssConfigId().equals(sysOssConfig.getOssConfigId())) {
            return true;
        }
        
        // 其他情况都认为不唯一
        return false;
    }

    /**
     * 启用禁用状态
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int updateOssConfigStatus(SysOssConfig bo) {
        // 先将所有配置状态设为停用
        SysOssConfig updateAll = new SysOssConfig();
        updateAll.setStatus("1"); // 1表示停用
        sysOssConfigMapper.updateSysOssConfig(updateAll);
        
        // 再更新指定配置为启用状态
        SysOssConfig targetConfig = new SysOssConfig();
        targetConfig.setOssConfigId(bo.getOssConfigId());
        targetConfig.setStatus("0"); // 0表示启用
        int row = sysOssConfigMapper.updateSysOssConfig(targetConfig);
        
        if (row > 0) {
            RedisUtils.setCacheObject(OssConstant.DEFAULT_CONFIG_KEY, bo.getConfigKey());
        }
        return row;
    }

    @Override
    public SysOssConfig queryByConfigKey(String configKey) {
        SysOssConfig queryConfig = new SysOssConfig();
        queryConfig.setConfigKey(configKey);
        List<SysOssConfig> configs = sysOssConfigMapper.selectSysOssConfigList(queryConfig);
        return configs.isEmpty() ? null : configs.get(0);
    }
}