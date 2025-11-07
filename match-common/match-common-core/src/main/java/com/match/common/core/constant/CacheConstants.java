package com.match.common.core.constant;

/**
 * 缓存的key 常量
 * 
 * @author bruceXuu
 */
public class CacheConstants
{
    /**
     * 登录用户 redis key
     */
    public static final String LOGIN_TOKEN_KEY = "login_tokens:";

    /**
     * 验证码 redis key
     */
    public static final String CAPTCHA_CODE_KEY = "captcha_codes:";

    /**
     * 邮箱验证码 redis key
     */
    public static final String EMAIL_CODE_KEY = "email_code:";
    
    /**
     * 参数管理 cache key
     */
    public static final String SYS_CONFIG_KEY = "sys_config:";

    /**
     * 字典管理 cache key
     */
    public static final String SYS_DICT_KEY = "sys_dict:";

    /**
     * 防重提交 redis key
     */
    public static final String REPEAT_SUBMIT_KEY = "repeat_submit:";

    /**
     * 限流 redis key
     */
    public static final String RATE_LIMIT_KEY = "rate_limit:";

    /**
     * 登录账户密码错误次数 redis key
     */
    public static final String PWD_ERR_CNT_KEY = "pwd_err_cnt:";
    
    /**
     * 密码最大错误次数
     */
    public static final int PASSWORD_MAX_RETRY_COUNT = 5;
    
    /**
     * 密码锁定时间（分钟）
     */
    public static final Long PASSWORD_LOCK_TIME = 10L;
    
    /**
     * 系统黑名单IP redis key
     */
    public static final String SYS_LOGIN_BLACKIPLIST = "sys_login_blackiplist";
    
    /**
     * 令牌自定义标识
     */
    public static final String LOGIN_USER_KEY = "login_user_key";

    /**
     * 用户ID字段
     */
    public static final String DETAILS_USER_ID = "user_id";

    /**
     * 用户名字段
     */
    public static final String DETAILS_USERNAME = "username";

    /**
     * 授权信息字段
     */
    public static final String AUTHORIZATION_HEADER = "authorization";

    /**
     * 请求来源
     */
    public static final String FROM_SOURCE = "from-source";

    /**
     * 内部请求
     */
    public static final String INNER = "inner";

    /**
     * 用户标识
     */
    public static final String USER_KEY = "user_key";

    /**
     * 登录用户
     */
    public static final String LOGIN_USER = "login_user";

    /**
     * 角色权限
     */
    public static final String ROLE_PERMISSION = "role_permission";

    /**
     * 菜单权限
     */
    public static final String MENU_PERMISSION = "menu_permission";

    /**
     * 令牌前缀
     */
    public static final String TOKEN_PREFIX = "Bearer ";

    /**
     * 令牌过期时间（分钟）
     */
    public static final long EXPIRATION = 1440L;

    /**
     * 令牌过期时间（分钟）
     */
    public static final String EXPIRATION_TIME = "1440";

    /**
     * 令牌刷新时间（分钟）
     */
    public static final long REFRESH_TIME = 120L;

    /**
     * 令牌刷新时间（分钟）
     */
    public static final String REFRESH_TIME_TIME = "120";
}