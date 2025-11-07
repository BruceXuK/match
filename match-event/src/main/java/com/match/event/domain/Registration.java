package com.match.event.domain;

import com.match.common.core.annotation.Excel;
import com.match.common.core.web.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 报名记录对象 registration
 *
 * @author bruceXuu
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class Registration extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 报名ID */
    private Long id;

    /** 赛事ID */
    @Excel(name = "赛事ID")
    private Long eventId;

    /** 用户ID */
    @Excel(name = "用户ID")
    private Long userId;

    /** 报名编号 */
    @Excel(name = "报名编号")
    private String registrationNo;

    /** 用户姓名 */
    @Excel(name = "用户姓名")
    private String userName;

    /** 用户手机号 */
    @Excel(name = "用户手机号")
    private String userPhone;

    /** 用户邮箱 */
    @Excel(name = "用户邮箱")
    private String userEmail;

    /** 报名状态（0待支付 1已支付 2已取消 3已完成） */
    @Excel(name = "报名状态", readConverterExp = "0=待支付,1=已支付,2=已取消,3=已完成")
    private String status;
}
