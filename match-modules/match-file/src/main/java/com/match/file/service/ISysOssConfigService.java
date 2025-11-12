package com.match.file.service;

import java.util.Collection;
import java.util.List;
import com.match.file.domain.SysOssConfig;

/**
 * 对象存储配置Service接口
 *
 * @author bruceXuu
 */
public interface ISysOssConfigService {

    /**
     * 初始化OSS配置
     */
    void init();

    /**
     * 查询单个
     */
    SysOssConfig queryById(Long ossConfigId);

    /**
     * 查询列表
     */
    List<SysOssConfig> queryPageList(SysOssConfig sysOssConfig);


    /**
     * 根据新增业务对象插入对象存储配置
     *
     * @param bo 对象存储配置新增业务对象
     * @return
     */
    Boolean insertByBo(SysOssConfig bo);

    /**
     * 根据编辑业务对象修改对象存储配置
     *
     * @param bo 对象存储配置编辑业务对象
     * @return
     */
    Boolean updateByBo(SysOssConfig bo);

    /**
     * 校验并删除数据
     *
     * @param ids     主键集合
     * @param isValid 是否校验,true-删除前校验,false-不校验
     * @return
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);

    /**
     * 启用停用状态
     */
    int updateOssConfigStatus(SysOssConfig bo);

    /**
     * 查询单个
     */
    SysOssConfig queryByConfigKey(String configKey);

}
