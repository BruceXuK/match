package com.match.common.oss.exception;

/**
 * OSS异常类
 * <p>
 * 自定义运行时异常，用于处理OSS对象存储相关操作中出现的异常情况。
 * 继承自RuntimeException，支持链式异常处理。
 *
 * @author Lion Li
 */
public class OssException extends RuntimeException {

    private static final long serialVersionUID = 1L;

    /**
     * 构造一个带有详细消息的OSS异常
     *
     * @param msg 异常的详细信息
     */
    public OssException(String msg) {
        super(msg);
    }

}