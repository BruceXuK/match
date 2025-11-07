package com.match.event.api;

import com.match.common.core.constant.ServiceNameConstants;
import com.match.event.api.factory.RemoteEventFallbackFactory;
import com.match.event.api.domain.Event;
import com.match.event.api.domain.Registration;
import com.match.common.core.domain.R;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;

/**
 * 赛事服务
 *
 * @author bruceXuu
 */
@FeignClient(contextId = "remoteEventService", value = ServiceNameConstants.EVENT_SERVICE, fallbackFactory = RemoteEventFallbackFactory.class)
public interface RemoteEventService {

    /**
     * 查询赛事列表
     *
     * @param event 赛事信息
     * @return 赛事列表
     */
    @GetMapping("/event/list")
    public R<List<Event>> selectEventList(Event event);

    /**
     * 获取赛事详细信息
     *
     * @param id 赛事ID
     * @return 赛事信息
     */
    @GetMapping("/event/{id}")
    public R<Event> selectEventById(@PathVariable("id") Long id);

    /**
     * 查询报名记录列表
     *
     * @param registration 报名信息
     * @return 报名列表
     */
    @GetMapping("/registration/list")
    public R<List<Registration>> selectRegistrationList(Registration registration);

    /**
     * 获取报名记录详细信息
     *
     * @param id 报名记录ID
     * @return 报名信息
     */
    @GetMapping("/registration/{id}")
    public R<Registration> selectRegistrationById(@PathVariable("id") Long id);

    /**
     * 新增报名记录
     *
     * @param registration 报名信息
     * @return 结果
     */
    @PostMapping("/registration")
    public R<Integer> insertRegistration(@RequestBody Registration registration);
}
