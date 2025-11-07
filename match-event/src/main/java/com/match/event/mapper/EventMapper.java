package com.match.event.mapper;

import com.match.event.domain.MarathonEvent;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 赛事Mapper接口
 *
 * @author bruceXuu
 */
@Mapper
public interface EventMapper {
    /**
     * 查询赛事
     *
     * @param id 赛事主键
     * @return 赛事
     */
    public MarathonEvent selectEventById(Long id);

    /**
     * 查询赛事列表
     *
     * @param event 赛事
     * @return 赛事集合
     */
    public List<MarathonEvent> selectEventList(MarathonEvent event);

    /**
     * 新增赛事
     *
     * @param event 赛事
     * @return 结果
     */
    public int insertEvent(MarathonEvent event);

    /**
     * 修改赛事
     *
     * @param event 赛事
     * @return 结果
     */
    public int updateEvent(MarathonEvent event);

    /**
     * 删除赛事
     *
     * @param id 赛事主键
     * @return 结果
     */
    public int deleteEventById(Long id);

    /**
     * 批量删除赛事
     *
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteEventByIds(Long[] ids);
}
