package com.match.email.controller;

import com.match.common.core.domain.R;
import com.match.common.core.utils.StringUtils;
import com.match.common.redis.service.RedisService;
import com.match.email.service.IMailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.concurrent.TimeUnit;

/**
 * 邮件服务Controller
 *
 * @author bruceXuu
 */
@RestController
@RequestMapping("/mail")
public class MailController {

    @Autowired
    private IMailService mailService;

    @Autowired
    private RedisService redisService;

    /**
     * 发送简单邮件
     *
     * @param to      收件人邮箱
     * @param subject 邮件主题
     * @param content 邮件内容
     * @return 结果
     */
    @PostMapping("/sendSimpleMail")
    public R sendSimpleMail(@RequestParam("to") String to, @RequestParam("subject") String subject, @RequestParam("content") String content) {
        try {
            mailService.sendSimpleMail(to, subject, content);
            return R.ok("邮件发送成功");
        } catch (Exception e) {
            return R.fail("邮件发送失败: " + e.getMessage());
        }
    }

    /**
     * 发送邮箱验证码
     *
     * @param params 邮箱地址参数
     * @return 结果
     */
    @PostMapping("/sendEmailCode")
    public R sendEmailCode(@RequestBody Map<String, String> params) {
        String email = params.get("email");
        if (StringUtils.isEmpty(email)) {
            return R.fail("邮箱地址不能为空");
        }

        // 生成6位随机数字验证码
        String code = String.valueOf(100000 + new Random().nextInt(900000));

        // 将验证码存入Redis，有效期5分钟
        String key = "email_code:" + email;
        redisService.setCacheObject(key, code, 5L, TimeUnit.MINUTES);

        // 发送邮件
        try {
            String subject = "注册验证码";
            String content = "您的注册验证码为：" + code + "，有效期5分钟。";
            mailService.sendSimpleMail(email, subject, content);
            return R.ok("验证码发送成功");
        } catch (Exception e) {
            return R.fail("验证码发送失败");
        }
    }
}