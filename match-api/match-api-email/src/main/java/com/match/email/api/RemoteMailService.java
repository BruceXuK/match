package com.match.email.api;

import com.match.common.core.constant.ServiceNameConstants;
import com.match.email.api.factory.RemoteMailFallbackFactory;
import com.match.common.core.domain.R;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * 邮件服务
 *
 * @author bruceXuu
 */
@FeignClient(contextId = "remoteMailService", value = ServiceNameConstants.EMAIL_SERVICE, fallbackFactory = RemoteMailFallbackFactory.class)
public interface RemoteMailService
{
    /**
     * 发送邮件
     *
     * @param to 发送目标
     * @param subject 邮件主题
     * @param content 邮件内容
     * @return 结果
     */
    @PostMapping("/mail/sendSimpleMail")
    public R sendMail(@RequestParam("to") String to, @RequestParam("subject") String subject, @RequestParam("content") String content);
}
