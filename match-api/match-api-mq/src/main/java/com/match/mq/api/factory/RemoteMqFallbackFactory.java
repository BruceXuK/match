package com.match.mq.api.factory;

import com.match.mq.api.RemoteMqService;
import com.match.mq.api.domain.SignSuccessMessage;
import com.match.common.core.domain.R;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cloud.openfeign.FallbackFactory;
import org.springframework.stereotype.Component;

/**
 * 消息队列服务降级处理
 *
 * @author bruceXuu
 */
@Component
public class RemoteMqFallbackFactory implements FallbackFactory<RemoteMqService> {
    private static final Logger log = LoggerFactory.getLogger(RemoteMqFallbackFactory.class);

    @Override
    public RemoteMqService create(Throwable throwable) {
        log.error("消息队列服务调用失败:{}", throwable.getMessage());
        return new RemoteMqService() {
            @Override
            public R<Boolean> sendSignSuccessMessage(SignSuccessMessage message) {
                return R.fail("发送报名成功消息失败:" + throwable.getMessage());
            }
        };
    }
}
