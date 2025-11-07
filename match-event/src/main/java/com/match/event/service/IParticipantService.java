package com.match.event.service;

import com.match.event.domain.Participant;

import java.util.List;

/**
 * 参赛者信息Service接口
 *
 * @author bruceXuu
 */
public interface IParticipantService {
    /**
     * 查询参赛者信息
     *
     * @param id 参赛者信息主键
     * @return 参赛者信息
     */
    public Participant selectParticipantById(Long id);

    /**
     * 查询参赛者信息列表
     *
     * @param participant 参赛者信息
     * @return 参赛者信息集合
     */
    public List<Participant> selectParticipantList(Participant participant);

    /**
     * 新增参赛者信息
     *
     * @param participant 参赛者信息
     * @return 结果
     */
    public int insertParticipant(Participant participant);

    /**
     * 修改参赛者信息
     *
     * @param participant 参赛者信息
     * @return 结果
     */
    public int updateParticipant(Participant participant);

    /**
     * 批量删除参赛者信息
     *
     * @param ids 需要删除的参赛者信息主键集合
     * @return 结果
     */
    public int deleteParticipantByIds(Long[] ids);

    /**
     * 删除参赛者信息信息
     *
     * @param id 参赛者信息主键
     * @return 结果
     */
    public int deleteParticipantById(Long id);

    /**
     * 根据报名ID查询参赛者信息
     *
     * @param registrationId 报名ID
     * @return 参赛者信息
     */
    public Participant selectParticipantByRegistrationId(Long registrationId);
}
