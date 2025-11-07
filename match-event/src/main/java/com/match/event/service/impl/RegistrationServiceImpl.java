package com.match.event.service.impl;

import com.match.event.domain.Registration;
import com.match.event.mapper.RegistrationMapper;
import com.match.event.service.IRegistrationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 报名记录Service业务层处理
 *
 * @author bruceXuu
 */
@Service
public class RegistrationServiceImpl implements IRegistrationService {
    @Autowired
    private RegistrationMapper registrationMapper;

    /**
     * 查询报名记录
     *
     * @param id 报名记录主键
     * @return 报名记录
     */
    @Override
    public Registration selectRegistrationById(Long id) {
        return registrationMapper.selectRegistrationById(id);
    }

    /**
     * 查询报名记录列表
     *
     * @param registration 报名记录
     * @return 报名记录
     */
    @Override
    public List<Registration> selectRegistrationList(Registration registration) {
        return registrationMapper.selectRegistrationList(registration);
    }

    /**
     * 新增报名记录
     *
     * @param registration 报名记录
     * @return 结果
     */
    @Override
    public int insertRegistration(Registration registration) {
        return registrationMapper.insertRegistration(registration);
    }

    /**
     * 修改报名记录
     *
     * @param registration 报名记录
     * @return 结果
     */
    @Override
    public int updateRegistration(Registration registration) {
        return registrationMapper.updateRegistration(registration);
    }

    /**
     * 批量删除报名记录
     *
     * @param ids 需要删除的报名记录主键
     * @return 结果
     */
    @Override
    public int deleteRegistrationByIds(Long[] ids) {
        return registrationMapper.deleteRegistrationByIds(ids);
    }

    /**
     * 删除报名记录信息
     *
     * @param id 报名记录主键
     * @return 结果
     */
    @Override
    public int deleteRegistrationById(Long id) {
        return registrationMapper.deleteRegistrationById(id);
    }

    /**
     * 根据用户ID和赛事ID查询报名记录
     *
     * @param userId 用户ID
     * @param eventId 赛事ID
     * @return 报名记录
     */
    @Override
    public Registration selectRegistrationByUserIdAndEventId(Long userId, Long eventId) {
        return registrationMapper.selectRegistrationByUserIdAndEventId(userId, eventId);
    }
}