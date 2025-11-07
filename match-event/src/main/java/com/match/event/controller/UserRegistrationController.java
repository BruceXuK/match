package com.match.event.controller;

import com.match.common.core.constant.SecurityConstants;
import com.match.common.core.domain.R;
import com.match.common.core.utils.StringUtils;
import com.match.common.core.web.controller.BaseController;
import com.match.common.core.web.domain.AjaxResult;
import com.match.common.log.annotation.Log;
import com.match.common.log.enums.BusinessType;
import com.match.event.domain.MarathonEvent;
import com.match.event.domain.Registration;
import com.match.event.service.IEventService;
import com.match.event.service.IRegistrationService;
import com.match.mq.api.RemoteMqService;
import com.match.mq.api.domain.SignSuccessMessage;
import com.match.system.api.RemoteUserService;
import com.match.system.api.domain.SysUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.Date;

/**
 * 用户报名Controller
 *
 * @author bruceXuu
 */
@RestController
@RequestMapping("/event/user/registration")
public class UserRegistrationController extends BaseController {

    @Autowired
    private IEventService eventService;

    @Autowired
    private IRegistrationService registrationService;

    @Autowired
    private RemoteUserService remoteUserService;

    @Autowired
    private RemoteMqService remoteMqService;

    /**
     * 用户报名赛事
     */
    @Log(title = "用户报名", businessType = BusinessType.INSERT)
    @PostMapping("/{eventId}")
    @Transactional(rollbackFor = Exception.class)
    public AjaxResult register(@PathVariable Long eventId, @RequestBody Registration registration) {
        try {
            // 1. 检查赛事是否存在且可报名
            MarathonEvent event = eventService.selectEventById(eventId);
            if (event == null) {
                return AjaxResult.error("赛事不存在");
            }

            if (!"0".equals(event.getStatus())) {
                return AjaxResult.error("赛事不可报名");
            }

            // 2. 检查用户是否已报名
            Registration existingRegistration = registrationService.selectRegistrationByUserIdAndEventId(
                    registration.getUserId(), eventId);
            if (existingRegistration != null) {
                return AjaxResult.error("您已报名该赛事");
            }

            // 3. 获取用户信息
            R<SysUser> userResult = remoteUserService.getUserInfoById(registration.getUserId(), SecurityConstants.INNER);
            if (userResult.getCode() != 200 || userResult.getData() == null) {
                return AjaxResult.error("用户信息获取失败");
            }
            SysUser user = userResult.getData();

            // 4. 填充报名信息
            registration.setEventId(eventId);
            registration.setUserName(user.getUserName());
            registration.setUserPhone(user.getPhonenumber());
            registration.setUserEmail(user.getEmail());
            registration.setRegistrationNo(generateRegistrationNo());
            registration.setStatus("1"); // 已支付状态

            // 5. 保存报名信息
            registrationService.insertRegistration(registration);

            // 6. 更新赛事参与人数
            event.setCurrentParticipants(event.getCurrentParticipants() + 1);
            eventService.updateEvent(event);

            // 7. 发送报名成功消息到MQ
            SignSuccessMessage message = new SignSuccessMessage();
            message.setEventId(eventId);
            message.setUserId(registration.getUserId());
            message.setUserPhone(user.getPhonenumber());
            message.setUserEmail(user.getEmail());
            message.setRegistrationNo(registration.getRegistrationNo());
            message.setRegistrationTime(new Date());
            message.setEventTime(event.getEventTime());
            message.setEventName(event.getEventName());

            R<Boolean> mqResult = remoteMqService.sendSignSuccessMessage(message);
            if (mqResult.getCode() != 200) {
                // 记录日志，但不中断主流程
                System.err.println("发送MQ消息失败: " + mqResult.getMsg());
            }

            return AjaxResult.success("报名成功");
        } catch (Exception e) {
            return AjaxResult.error("报名失败: " + e.getMessage());
        }
    }

    /**
     * 生成报名编号
     *
     * @return 报名编号
     */
    private String generateRegistrationNo() {
        return "REG" + System.currentTimeMillis() + StringUtils.getRandomString(6);
    }
}
