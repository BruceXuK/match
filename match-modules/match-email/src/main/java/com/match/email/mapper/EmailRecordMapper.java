package com.match.email.mapper;

import com.match.email.domain.EmailRecord;

import java.util.List;

/**
 * 邮件记录Mapper接口
 * 
 * @author bruceXuu
 * @date 2022-07-11
 */
public interface EmailRecordMapper 
{
    /**
     * 查询邮件记录
     * 
     * @param id 邮件记录主键
     * @return 邮件记录
     */
    public EmailRecord selectEmailRecordById(Long id);

    /**
     * 查询邮件记录列表
     * 
     * @param emailRecord 邮件记录
     * @return 邮件记录集合
     */
    public List<EmailRecord> selectEmailRecordList(EmailRecord emailRecord);

    /**
     * 新增邮件记录
     * 
     * @param emailRecord 邮件记录
     * @return 结果
     */
    public int insertEmailRecord(EmailRecord emailRecord);

    /**
     * 修改邮件记录
     * 
     * @param emailRecord 邮件记录
     * @return 结果
     */
    public int updateEmailRecord(EmailRecord emailRecord);

    /**
     * 删除邮件记录
     * 
     * @param id 邮件记录主键
     * @return 结果
     */
    public int deleteEmailRecordById(Long id);

    /**
     * 批量删除邮件记录
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteEmailRecordByIds(Long[] ids);
}
