package com.match.event.api.domain;

import com.match.common.core.web.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 赛事对象 event
 *
 * @author bruceXuu
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class Event extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /**
     * 赛事ID
     */
    private Long id;

    /**
     * 赛事名称
     */
    private String eventName;

    /**
     * 赛事描述
     */
    private String eventDescription;

    /**
     * 赛事时间
     */
    private String eventTime;

    /**
     * 报名开始时间
     */
    private String registrationStartTime;

    /**
     * 报名截止时间
     */
    private String registrationEndTime;

    /**
     * 最大参赛人数
     */
    private Integer maxParticipants;

    /**
     * 当前参赛人数
     */
    private Integer currentParticipants;

    /**
     * 赛事状态（0正常 1关闭 2已结束）
     */
    private String status;
}
