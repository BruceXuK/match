package com.match.file.mapper;

import java.util.List;
import com.match.file.domain.SysOssConfig;
import org.apache.ibatis.annotations.Mapper;

/**
 * 对象存储配置Mapper接口
 *
 * @author bruceXuu
 */
@Mapper
public interface SysOssConfigMapper
{
    /**
     * 查询对象存储配置
     *
     * @param ossConfigId 对象存储配置主键
     * @return 对象存储配置
     */
    public SysOssConfig selectSysOssConfigById(Long ossConfigId);

    /**
     * 查询对象存储配置列表
     *
     * @param sysOssConfig 对象存储配置
     * @return 对象存储配置集合
     */
    public List<SysOssConfig> selectSysOssConfigList(SysOssConfig sysOssConfig);

    /**
     * 新增对象存储配置
     *
     * @param sysOssConfig 对象存储配置
     * @return 结果
     */
    public int insertSysOssConfig(SysOssConfig sysOssConfig);

    /**
     * 修改对象存储配置
     *
     * @param sysOssConfig 对象存储配置
     * @return 结果
     */
    public int updateSysOssConfig(SysOssConfig sysOssConfig);

    /**
     * 删除对象存储配置
     *
     * @param ossConfigId 对象存储配置主键
     * @return 结果
     */
    public int deleteSysOssConfigById(Long ossConfigId);

    /**
     * 批量删除对象存储配置
     *
     * @param ossConfigIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteSysOssConfigByIds(Long[] ossConfigIds);
}