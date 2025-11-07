package com.match.email.service.impl;

import com.match.common.core.text.Convert;
import com.match.common.core.utils.DateUtils;
import com.match.email.domain.EmailRecord;
import com.match.email.mapper.EmailRecordMapper;
import com.match.email.service.IEmailRecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 邮件记录Service业务层处理
 *
 * @author bruceXuu
 * @date 2022-07-11
 */
@Service
public class EmailRecordServiceImpl implements IEmailRecordService
{
    @Autowired
    private EmailRecordMapper emailRecordMapper;

    /**
     * 查询邮件记录
     *
     * @param id 邮件记录主键
     * @return 邮件记录
     */
    @Override
    public EmailRecord selectEmailRecordById(Long id)
    {
        return emailRecordMapper.selectEmailRecordById(id);
    }

    /**
     * 查询邮件记录列表
     *
     * @param emailRecord 邮件记录
     * @return 邮件记录
     */
    @Override
    public List<EmailRecord> selectEmailRecordList(EmailRecord emailRecord)
    {
        return emailRecordMapper.selectEmailRecordList(emailRecord);
    }

    /**
     * 新增邮件记录
     *
     * @param emailRecord 邮件记录
     * @return 结果
     */
    @Override
    public int insertEmailRecord(EmailRecord emailRecord)
    {
        emailRecord.setCreateTime(DateUtils.getNowDate());
        return emailRecordMapper.insertEmailRecord(emailRecord);
    }

    /**
     * 修改邮件记录
     *
     * @param emailRecord 邮件记录
     * @return 结果
     */
    @Override
    public int updateEmailRecord(EmailRecord emailRecord)
    {
        return emailRecordMapper.updateEmailRecord(emailRecord);
    }

    /**
     * 批量删除邮件记录
     *
     * @param ids 需要删除的邮件记录主键
     * @return 结果
     */
    @Override
    public int deleteEmailRecordByIds(Long[] ids)
    {
        return emailRecordMapper.deleteEmailRecordByIds(ids);
    }

    /**
     * 删除邮件记录信息
     *
     * @param id 邮件记录主键
     * @return 结果
     */
    @Override
    public int deleteEmailRecordById(Long id)
    {
        return emailRecordMapper.deleteEmailRecordById(id);
    }
}
