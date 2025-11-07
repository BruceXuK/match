package com.match.event.domain;

import com.match.common.core.annotation.Excel;
import com.match.common.core.web.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 马拉松赛事对象 marathon_event
 *
 * @author bruceXuu
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class MarathonEvent extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 赛事ID */
    private Long id;

    /** 赛事名称 */
    @Excel(name = "赛事名称")
    private String eventName;

    /** 赛事描述 */
    @Excel(name = "赛事描述")
    private String eventDescription;

    /** 赛事时间 */
    @Excel(name = "赛事时间")
    private String eventTime;

    /** 报名开始时间 */
    @Excel(name = "报名开始时间")
    private String registrationStartTime;

    /** 报名截止时间 */
    @Excel(name = "报名截止时间")
    private String registrationEndTime;

    /** 最大参赛人数 */
    @Excel(name = "最大参赛人数")
    private Integer maxParticipants;

    /** 当前参赛人数 */
    @Excel(name = "当前参赛人数")
    private Integer currentParticipants;

    /** 赛事状态（0正常 1关闭 2已结束） */
    @Excel(name = "赛事状态", readConverterExp = "0=正常,1=关闭,2=已结束")
    private String status;
    
    /** 赛事照片 */
    @Excel(name = "赛事照片")
    private String eventPhoto;
}