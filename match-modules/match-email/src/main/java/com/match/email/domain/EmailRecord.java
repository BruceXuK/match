package com.match.email.domain;

import com.match.common.core.annotation.Excel;
import com.match.common.core.web.domain.BaseEntity;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 邮件记录对象 email_record
 * 
 * @author bruceXuu
 * @date 2022-07-11
 */
public class EmailRecord extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** ID */
    private Long id;

    /** 发送者 */
    @Excel(name = "发送者")
    private String sender;

    /** 接收者 */
    @Excel(name = "接收者")
    private String receiver;

    /** 邮件主题 */
    @Excel(name = "邮件主题")
    private String subject;

    /** 邮件内容 */
    @Excel(name = "邮件内容")
    private String content;

    /** 发送状态（0成功 1失败） */
    @Excel(name = "发送状态", readConverterExp = "0=成功,1=失败")
    private String status;

    /** 失败原因 */
    @Excel(name = "失败原因")
    private String errorMsg;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }
    public void setSender(String sender) 
    {
        this.sender = sender;
    }

    public String getSender() 
    {
        return sender;
    }
    public void setReceiver(String receiver) 
    {
        this.receiver = receiver;
    }

    public String getReceiver() 
    {
        return receiver;
    }
    public void setSubject(String subject) 
    {
        this.subject = subject;
    }

    public String getSubject() 
    {
        return subject;
    }
    public void setContent(String content) 
    {
        this.content = content;
    }

    public String getContent() 
    {
        return content;
    }
    public void setStatus(String status) 
    {
        this.status = status;
    }

    public String getStatus() 
    {
        return status;
    }
    public void setErrorMsg(String errorMsg) 
    {
        this.errorMsg = errorMsg;
    }

    public String getErrorMsg() 
    {
        return errorMsg;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("sender", getSender())
            .append("receiver", getReceiver())
            .append("subject", getSubject())
            .append("content", getContent())
            .append("status", getStatus())
            .append("errorMsg", getErrorMsg())
            .append("createTime", getCreateTime())
            .toString();
    }
}
