package com.match.file.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.match.common.core.annotation.Excel;
import com.match.common.core.web.domain.BaseEntity;

/**
 * OSS对象存储表 sys_oss
 *
 * @author bruceXuu
 */
public class SysOss extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 对象存储主键 */
    @Excel(name = "对象存储主键")
    private Long ossId;

    /** 文件名 */
    @Excel(name = "文件名")
    private String fileName;

    /** 原名 */
    @Excel(name = "原名")
    private String originalName;

    /** 文件后缀名 */
    @Excel(name = "文件后缀名")
    private String fileSuffix;

    /** URL地址 */
    @Excel(name = "URL地址")
    private String url;

    /** 上传人 */
    @Excel(name = "上传人")
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

    /** 服务商 */
    @Excel(name = "服务商")
    private String service;

    /** 文件MD5 */
    @Excel(name = "文件MD5")
    private String md5;

    /** 大文件上传任务ID */
    @Excel(name = "大文件上传任务ID")
    private String uploadId;

    /** 上传状态 */
    @Excel(name = "上传状态")
    private String uploadStatus;

    public void setOssId(Long ossId)
    {
        this.ossId = ossId;
    }

    public Long getOssId()
    {
        return ossId;
    }
    public void setFileName(String fileName)
    {
        this.fileName = fileName;
    }

    public String getFileName()
    {
        return fileName;
    }
    public void setOriginalName(String originalName)
    {
        this.originalName = originalName;
    }

    public String getOriginalName()
    {
        return originalName;
    }
    public void setFileSuffix(String fileSuffix)
    {
        this.fileSuffix = fileSuffix;
    }

    public String getFileSuffix()
    {
        return fileSuffix;
    }
    public void setUrl(String url)
    {
        this.url = url;
    }

    public String getUrl()
    {
        return url;
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

    public void setService(String service)
    {
        this.service = service;
    }

    public String getService()
    {
        return service;
    }

    public void setMd5(String md5)
    {
        this.md5 = md5;
    }

    public String getMd5()
    {
        return md5;
    }

    public void setUploadId(String uploadId)
    {
        this.uploadId = uploadId;
    }

    public String getUploadId()
    {
        return uploadId;
    }

    public void setUploadStatus(String uploadStatus)
    {
        this.uploadStatus = uploadStatus;
    }

    public String getUploadStatus()
    {
        return uploadStatus;
    }

    @Override
    public String toString() {
        return "SysOss{" +
                "ossId=" + ossId +
                ", fileName='" + fileName + '\'' +
                ", originalName='" + originalName + '\'' +
                ", fileSuffix='" + fileSuffix + '\'' +
                ", url='" + url + '\'' +
                ", createTime=" + createTime +
                ", updateTime=" + updateTime +
                ", service='" + service + '\'' +
                '}';
    }
}
