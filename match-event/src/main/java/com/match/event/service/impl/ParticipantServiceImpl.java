package com.match.event.service.impl;

import com.match.event.domain.Participant;
import com.match.event.mapper.ParticipantMapper;
import com.match.event.service.IParticipantService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 参赛者信息Service业务层处理
 *
 * @author bruceXuu
 */
@Service
public class ParticipantServiceImpl implements IParticipantService {
    @Autowired
    private ParticipantMapper participantMapper;

    /**
     * 查询参赛者信息
     *
     * @param id 参赛者信息主键
     * @return 参赛者信息
     */
    @Override
    public Participant selectParticipantById(Long id) {
        return participantMapper.selectParticipantById(id);
    }

    /**
     * 查询参赛者信息列表
     *
     * @param participant 参赛者信息
     * @return 参赛者信息
     */
    @Override
    public List<Participant> selectParticipantList(Participant participant) {
        return participantMapper.selectParticipantList(participant);
    }

    /**
     * 新增参赛者信息
     *
     * @param participant 参赛者信息
     * @return 结果
     */
    @Override
    public int insertParticipant(Participant participant) {
        return participantMapper.insertParticipant(participant);
    }

    /**
     * 修改参赛者信息
     *
     * @param participant 参赛者信息
     * @return 结果
     */
    @Override
    public int updateParticipant(Participant participant) {
        return participantMapper.updateParticipant(participant);
    }

    /**
     * 批量删除参赛者信息
     *
     * @param ids 需要删除的参赛者信息主键
     * @return 结果
     */
    @Override
    public int deleteParticipantByIds(Long[] ids) {
        return participantMapper.deleteParticipantByIds(ids);
    }

    /**
     * 删除参赛者信息信息
     *
     * @param id 参赛者信息主键
     * @return 结果
     */
    @Override
    public int deleteParticipantById(Long id) {
        return participantMapper.deleteParticipantById(id);
    }

    /**
     * 根据报名ID查询参赛者信息
     *
     * @param registrationId 报名ID
     * @return 参赛者信息
     */
    @Override
    public Participant selectParticipantByRegistrationId(Long registrationId) {
        return participantMapper.selectParticipantByRegistrationId(registrationId);
    }
}
