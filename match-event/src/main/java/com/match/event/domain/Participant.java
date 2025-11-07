package com.match.event.domain;

import com.match.common.core.annotation.Excel;
import com.match.common.core.web.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 参赛者信息对象 participant
 *
 * @author bruceXuu
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class Participant extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 参赛者ID */
    private Long id;

    /** 报名ID */
    @Excel(name = "报名ID")
    private Long registrationId;

    /** 用户ID */
    @Excel(name = "用户ID")
    private Long userId;

    /** 紧急联系人 */
    @Excel(name = "紧急联系人")
    private String emergencyContact;

    /** 紧急联系人电话 */
    @Excel(name = "紧急联系人电话")
    private String emergencyPhone;

    /** 参赛者照片 */
    @Excel(name = "参赛者照片")
    private String photo;

    /** 参赛者身份证号 */
    @Excel(name = "参赛者身份证号")
    private String idCard;

    /** 参赛者地址 */
    @Excel(name = "参赛者地址")
    private String address;
}
