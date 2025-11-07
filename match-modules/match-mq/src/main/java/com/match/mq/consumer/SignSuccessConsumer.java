package com.match.mq.consumer;

import com.alibaba.fastjson2.JSON;
import com.match.common.core.domain.R;
import com.match.email.api.RemoteMailService;
import com.match.mq.domain.SignSuccessMessage;
import org.apache.rocketmq.spring.annotation.RocketMQMessageListener;
import org.apache.rocketmq.spring.core.RocketMQListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 报名成功消息消费者
 *
 * @author bruceXuu
 */
@Service
@RocketMQMessageListener(
        topic = "marathon-sign-success-topic",
        consumerGroup = "marathon_sign_success_consumer_group"
)
public class SignSuccessConsumer implements RocketMQListener<String> {

    @Autowired
    private RemoteMailService remoteMailService;

    @Override
    public void onMessage(String message) {
        SignSuccessMessage signSuccessMessage = JSON.parseObject(message, SignSuccessMessage.class);

        // 构造邮件内容
        String subject = "马拉松报名成功通知";
        String content = buildEmailContent(signSuccessMessage);

        // 调用邮件服务发送邮件
        R<?> result = remoteMailService.sendMail(
                signSuccessMessage.getUserEmail(),
                subject,
                content);

        if (result.getCode() != 200) {
            // 如果发送失败，可以记录日志或进行其他处理
            System.err.println("发送邮件失败: " + result.getMsg());
        }
    }

    /**
     * 构造邮件内容
     *
     * @param message 报名成功消息
     * @return 邮件内容
     */
    private String buildEmailContent(SignSuccessMessage message) {
        StringBuilder content = new StringBuilder();
        content.append("马拉松报名成功通知\n\n");
        content.append("尊敬的用户，您好！\n\n");
        content.append("您已成功报名参加 ").append(message.getEventName()).append(" 赛事。\n");
        content.append("赛事时间：").append(message.getEventTime()).append("\n");
        content.append("报名编号：").append(message.getRegistrationNo()).append("\n");
        content.append("报名时间：").append(message.getRegistrationTime()).append("\n");
        content.append("感谢您的参与！");
        return content.toString();
    }
}
