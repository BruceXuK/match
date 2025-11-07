package com.match.event.api.factory;

import com.match.event.api.RemoteEventService;
import com.match.event.api.domain.Event;
import com.match.event.api.domain.Registration;
import com.match.common.core.domain.R;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cloud.openfeign.FallbackFactory;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * 赛事服务降级处理
 *
 * @author bruceXuu
 */
@Component
public class RemoteEventFallbackFactory implements FallbackFactory<RemoteEventService> {
    private static final Logger log = LoggerFactory.getLogger(RemoteEventFallbackFactory.class);

    @Override
    public RemoteEventService create(Throwable throwable) {
        log.error("赛事服务调用失败:{}", throwable.getMessage());
        return new RemoteEventService() {
            @Override
            public R<List<Event>> selectEventList(Event event) {
                return R.fail("查询赛事列表失败:" + throwable.getMessage());
            }

            @Override
            public R<Event> selectEventById(Long id) {
                return R.fail("获取赛事详情失败:" + throwable.getMessage());
            }

            @Override
            public R<List<Registration>> selectRegistrationList(Registration registration) {
                return R.fail("查询报名记录列表失败:" + throwable.getMessage());
            }

            @Override
            public R<Registration> selectRegistrationById(Long id) {
                return R.fail("获取报名记录详情失败:" + throwable.getMessage());
            }

            @Override
            public R<Integer> insertRegistration(Registration registration) {
                return R.fail("新增报名记录失败:" + throwable.getMessage());
            }
        };
    }
}
