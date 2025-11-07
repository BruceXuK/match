package com.match.mq.producer;

import com.alibaba.fastjson2.JSON;
import com.match.mq.domain.SignSuccessMessage;
import org.apache.rocketmq.spring.core.RocketMQTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.support.GenericMessage;
import org.springframework.stereotype.Service;

/**
 * 马拉松相关消息生产者
 *
 * @author bruceXuu
 */
@Service
public class MarathonMessageProducer {

    @Autowired
    private RocketMQTemplate rocketMQTemplate;

    /**
     * 发送报名成功消息
     *
     * @param message 消息内容
     */
    public void sendSignSuccessMessage(SignSuccessMessage message) {
        String destination = "marathon-sign-success-topic";
        String payload = JSON.toJSONString(message);
        rocketMQTemplate.send(destination, new GenericMessage<>(payload));
    }
}
