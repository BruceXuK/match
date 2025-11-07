package com.match.event.service.impl;

import com.match.event.domain.MarathonEvent;
import com.match.event.mapper.EventMapper;
import com.match.event.service.IEventService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 赛事Service业务层处理
 *
 * @author bruceXuu
 */
@Service
public class EventServiceImpl implements IEventService {
    @Autowired
    private EventMapper eventMapper;

    /**
     * 查询赛事
     *
     * @param id 赛事主键
     * @return 赛事
     */
    @Override
    public MarathonEvent selectEventById(Long id) {
        return eventMapper.selectEventById(id);
    }

    /**
     * 查询赛事列表
     *
     * @param event 赛事
     * @return 赛事
     */
    @Override
    public List<MarathonEvent> selectEventList(MarathonEvent event) {
        return eventMapper.selectEventList(event);
    }

    /**
     * 新增赛事
     *
     * @param event 赛事
     * @return 结果
     */
    @Override
    public int insertEvent(MarathonEvent event) {
        return eventMapper.insertEvent(event);
    }

    /**
     * 修改赛事
     *
     * @param event 赛事
     * @return 结果
     */
    @Override
    public int updateEvent(MarathonEvent event) {
        return eventMapper.updateEvent(event);
    }

    /**
     * 批量删除赛事
     *
     * @param ids 需要删除的赛事主键
     * @return 结果
     */
    @Override
    public int deleteEventByIds(Long[] ids) {
        return eventMapper.deleteEventByIds(ids);
    }

    /**
     * 删除赛事信息
     *
     * @param id 赛事主键
     * @return 结果
     */
    @Override
    public int deleteEventById(Long id) {
        return eventMapper.deleteEventById(id);
    }
}