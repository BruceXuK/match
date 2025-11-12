package com.match.common.log.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import com.match.common.core.constant.SecurityConstants;
import com.match.system.api.RemoteLogService;
import com.match.system.api.domain.SysOperLog;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 异步调用日志服务
 * 
 * @author bruceXuu
 */
@Service
public class AsyncLogService
{
    private static final Logger log = LoggerFactory.getLogger(AsyncLogService.class);
    
    @Autowired(required = false)
    private RemoteLogService remoteLogService;

    /**
     * 保存系统日志记录
     */
    @Async
    public void saveSysLog(SysOperLog sysOperLog) throws Exception
    {
        if (remoteLogService != null) {
            remoteLogService.saveLog(sysOperLog, SecurityConstants.INNER);
        } else {
            log.warn("RemoteLogService未配置，操作日志将不被远程保存: {}", sysOperLog);
        }
    }
}