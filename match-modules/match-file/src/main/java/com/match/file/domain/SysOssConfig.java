package com.match.file.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.match.common.core.annotation.Excel;
import com.match.common.core.web.domain.BaseEntity;

/**
 * 对象存储配置表 sys_oss_config
 * 
 * @author bruceXuu
 */
public class SysOssConfig extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主建 */
    @Excel(name = "主建")
    private Long ossConfigId;

    /** 配置key */
    @Excel(name = "配置key")
    private String configKey;

    /** accessKey */
    @Excel(name = "accessKey")
    private String accessKey;

    /** 秘钥 */
    @Excel(name = "秘钥")
    private String secretKey;

    /** 桶名称 */
    @Excel(name = "桶名称")
    private String bucketName;

    /** 前缀 */
    @Excel(name = "前缀")
    private String prefix;

    /** 访问站点 */
    @Excel(name = "访问站点")
    private String endpoint;

    /** 自定义域名 */
    @Excel(name = "自定义域名")
    private String domain;

    /** 是否https（Y=是,N=否） */
    @Excel(name = "是否https", readConverterExp = "Y=是,N=否")
    private String isHttps;

    /** 域 */
    @Excel(name = "域")
    private String region;

    /** 桶权限类型(0=private 1=public 2=custom) */
    @Excel(name = "桶权限类型", readConverterExp = "0=private,1=public,2=custom")
    private String accessPolicy;

    /** 状态（0=正常,1=停用） */
    @Excel(name = "状态", readConverterExp = "0=正常,1=停用")
    private String status;

    /** 扩展字段 */
    @Excel(name = "扩展字段")
    private String ext1;

    /** 创建者 */
    @Excel(name = "创建者")
    private String createBy;

    /** 创建时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "创建时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    /** 更新者 */
    @Excel(name = "更新者")
    private String updateBy;

    /** 更新时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "更新时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date updateTime;

    /** 备注 */
    @Excel(name = "备注")
    private String remark;

    public void setOssConfigId(Long ossConfigId) 
    {
        this.ossConfigId = ossConfigId;
    }

    public Long getOssConfigId() 
    {
        return ossConfigId;
    }
    public void setConfigKey(String configKey) 
    {
        this.configKey = configKey;
    }

    public String getConfigKey() 
    {
        return configKey;
    }
    public void setAccessKey(String accessKey) 
    {
        this.accessKey = accessKey;
    }

    public String getAccessKey() 
    {
        return accessKey;
    }
    public void setSecretKey(String secretKey) 
    {
        this.secretKey = secretKey;
    }

    public String getSecretKey() 
    {
        return secretKey;
    }
    public void setBucketName(String bucketName) 
    {
        this.bucketName = bucketName;
    }

    public String getBucketName() 
    {
        return bucketName;
    }
    public void setPrefix(String prefix) 
    {
        this.prefix = prefix;
    }

    public String getPrefix() 
    {
        return prefix;
    }
    public void setEndpoint(String endpoint) 
    {
        this.endpoint = endpoint;
    }

    public String getEndpoint() 
    {
        return endpoint;
    }
    public void setDomain(String domain) 
    {
        this.domain = domain;
    }

    public String getDomain() 
    {
        return domain;
    }
    public void setIsHttps(String isHttps) 
    {
        this.isHttps = isHttps;
    }

    public String getIsHttps() 
    {
        return isHttps;
    }
    public void setRegion(String region) 
    {
        this.region = region;
    }

    public String getRegion() 
    {
        return region;
    }
    public void setAccessPolicy(String accessPolicy) 
    {
        this.accessPolicy = accessPolicy;
    }

    public String getAccessPolicy() 
    {
        return accessPolicy;
    }
    public void setStatus(String status) 
    {
        this.status = status;
    }

    public String getStatus() 
    {
        return status;
    }
    public void setExt1(String ext1) 
    {
        this.ext1 = ext1;
    }

    public String getExt1() 
    {
        return ext1;
    }
    public void setCreateBy(String createBy) 
    {
        this.createBy = createBy;
    }

    public String getCreateBy() 
    {
        return createBy;
    }
    public void setCreateTime(Date createTime) 
    {
        this.createTime = createTime;
    }

    public Date getCreateTime() 
    {
        return createTime;
    }
    public void setUpdateBy(String updateBy) 
    {
        this.updateBy = updateBy;
    }

    public String getUpdateBy() 
    {
        return updateBy;
    }
    public void setUpdateTime(Date updateTime) 
    {
        this.updateTime = updateTime;
    }

    public Date getUpdateTime() 
    {
        return updateTime;
    }
    public void setRemark(String remark) 
    {
        this.remark = remark;
    }

    public String getRemark() 
    {
        return remark;
    }

    @Override
    public String toString() {
        return "SysOssConfig{" +
                "ossConfigId=" + ossConfigId +
                ", configKey='" + configKey + '\'' +
                ", accessKey='" + accessKey + '\'' +
                ", secretKey='" + secretKey + '\'' +
                ", bucketName='" + bucketName + '\'' +
                ", prefix='" + prefix + '\'' +
                ", endpoint='" + endpoint + '\'' +
                ", domain='" + domain + '\'' +
                ", isHttps='" + isHttps + '\'' +
                ", region='" + region + '\'' +
                ", accessPolicy='" + accessPolicy + '\'' +
                ", status='" + status + '\'' +
                ", ext1='" + ext1 + '\'' +
                ", createBy='" + createBy + '\'' +
                ", createTime=" + createTime +
                ", updateBy='" + updateBy + '\'' +
                ", updateTime=" + updateTime +
                ", remark='" + remark + '\'' +
                '}';
    }
}