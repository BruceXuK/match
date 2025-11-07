package com.match.email.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * 邮件配置
 *
 * @author bruceXuu
 */
@Configuration
public class MailConfig {

    /**
     * 邮件异步处理
     *
     * @return
     */
    @Bean("mailAsync")
    public Boolean mailAsync() {
        return true;
    }
}
