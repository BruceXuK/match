package com.match.event.service;

import com.match.event.domain.Registration;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 报名记录Service接口
 *
 * @author bruceXuu
 */
public interface IRegistrationService {
    /**
     * 查询报名记录
     *
     * @param id 报名记录主键
     * @return 报名记录
     */
    public Registration selectRegistrationById(Long id);

    /**
     * 查询报名记录列表
     *
     * @param registration 报名记录
     * @return 报名记录集合
     */
    public List<Registration> selectRegistrationList(Registration registration);

    /**
     * 新增报名记录
     *
     * @param registration 报名记录
     * @return 结果
     */
    public int insertRegistration(Registration registration);

    /**
     * 修改报名记录
     *
     * @param registration 报名记录
     * @return 结果
     */
    public int updateRegistration(Registration registration);

    /**
     * 批量删除报名记录
     *
     * @param ids 需要删除的报名记录主键集合
     * @return 结果
     */
    public int deleteRegistrationByIds(Long[] ids);

    /**
     * 删除报名记录信息
     *
     * @param id 报名记录主键
     * @return 结果
     */
    public int deleteRegistrationById(Long id);

    /**
     * 根据用户ID和赛事ID查询报名记录
     *
     * @param userId 用户ID
     * @param eventId 赛事ID
     * @return 报名记录
     */
    public Registration selectRegistrationByUserIdAndEventId(@Param("userId") Long userId, @Param("eventId") Long eventId);
}