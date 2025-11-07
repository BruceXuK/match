package com.match.mq.api.domain;

import lombok.Data;
import java.util.Date;

/**
 * 报名成功消息实体
 *
 * @author bruceXuu
 */
@Data
public class SignSuccessMessage {
    private static final long serialVersionUID = 1L;

    /**
     * 赛事ID
     */
    private Long eventId;

    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 用户手机号
     */
    private String userPhone;

    /**
     * 用户邮箱
     */
    private String userEmail;

    /**
     * 报名编号
     */
    private String registrationNo;

    /**
     * 报名时间
     */
    private Date registrationTime;

    /**
     * 赛事时间
     */
    private String eventTime;

    /**
     * 赛事名称
     */
    private String eventName;
}
