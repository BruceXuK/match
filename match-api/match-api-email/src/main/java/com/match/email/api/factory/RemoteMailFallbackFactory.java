package com.match.email.api.factory;

import com.match.email.api.RemoteMailService;
import com.match.common.core.domain.R;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cloud.openfeign.FallbackFactory;
import org.springframework.stereotype.Component;

/**
 * 邮件服务降级处理
 *
 * @author bruceXuu
 */
@Component
public class RemoteMailFallbackFactory implements FallbackFactory<RemoteMailService> {
    private static final Logger log = LoggerFactory.getLogger(RemoteMailFallbackFactory.class);

    @Override
    public RemoteMailService create(Throwable throwable) {
        log.error("邮件服务调用失败:{}", throwable.getMessage());
        return new RemoteMailService() {
            @Override
            public R sendMail(String to, String subject, String content) {
                return R.fail("发送邮件失败:" + throwable.getMessage());
            }
        };
    }
}
