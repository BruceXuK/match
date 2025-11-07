package com.match.event.mapper;

import com.match.event.domain.Registration;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 报名记录Mapper接口
 *
 * @author bruceXuu
 */
@Mapper
public interface RegistrationMapper {
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
     * 删除报名记录
     *
     * @param id 报名记录主键
     * @return 结果
     */
    public int deleteRegistrationById(Long id);

    /**
     * 批量删除报名记录
     *
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteRegistrationByIds(Long[] ids);

    /**
     * 根据用户ID和赛事ID查询报名记录
     *
     * @param userId 用户ID
     * @param eventId 赛事ID
     * @return 报名记录
     */
    public Registration selectRegistrationByUserIdAndEventId(@Param("userId") Long userId, @Param("eventId") Long eventId);
}