package com.match.mq.api;

import com.match.common.core.constant.ServiceNameConstants;
import com.match.mq.api.factory.RemoteMqFallbackFactory;
import com.match.mq.api.domain.SignSuccessMessage;
import com.match.common.core.domain.R;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

/**
 * 消息队列服务
 *
 * @author bruceXuu
 */
@FeignClient(contextId = "remoteMqService", value = ServiceNameConstants.MQ_SERVICE, fallbackFactory = RemoteMqFallbackFactory.class)
public interface RemoteMqService {

    /**
     * 发送报名成功消息
     *
     * @param message 消息内容
     * @return 结果
     */
    @PostMapping("/producer/sign-success")
    public R<Boolean> sendSignSuccessMessage(@RequestBody SignSuccessMessage message);
}
