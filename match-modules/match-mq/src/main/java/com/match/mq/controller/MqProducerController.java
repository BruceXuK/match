package com.match.mq.controller;

import com.match.common.core.web.controller.BaseController;
import com.match.common.core.web.domain.AjaxResult;
import com.match.mq.domain.SignSuccessMessage;
import com.match.mq.producer.MarathonMessageProducer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * MQ生产者控制器
 *
 * @author bruceXuu
 */
@RestController
@RequestMapping("/producer")
public class MqProducerController extends BaseController {

    @Autowired
    private MarathonMessageProducer marathonMessageProducer;

    /**
     * 发送报名成功消息
     *
     * @param message 消息内容
     * @return 结果
     */
    @PostMapping("/sign-success")
    public AjaxResult sendSignSuccessMessage(@RequestBody SignSuccessMessage message) {
        try {
            marathonMessageProducer.sendSignSuccessMessage(message);
            return AjaxResult.success(true);
        } catch (Exception e) {
            return AjaxResult.error("消息发送失败: " + e.getMessage());
        }
    }
}
