package com.match.auth.service;

import com.match.auth.form.RegisterBody;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import com.match.common.core.constant.CacheConstants;
import com.match.common.core.constant.Constants;
import com.match.common.core.constant.SecurityConstants;
import com.match.common.core.constant.UserConstants;
import com.match.common.core.domain.R;
import com.match.common.core.enums.UserStatus;
import com.match.common.core.exception.ServiceException;
import com.match.common.core.text.Convert;
import com.match.common.core.utils.DateUtils;
import com.match.common.core.utils.StringUtils;
import com.match.common.core.utils.ip.IpUtils;
import com.match.common.redis.service.RedisService;
import com.match.common.security.utils.SecurityUtils;
import com.match.system.api.RemoteUserService;
import com.match.system.api.domain.SysUser;
import com.match.system.api.model.LoginUser;

/**
 * 登录校验方法
 *
 * @author bruceXuu
 */
@Component
public class SysLoginService
{
    @Autowired
    private RemoteUserService remoteUserService;

    @Autowired
    private SysPasswordService passwordService;

    @Autowired
    private SysRecordLogService recordLogService;

    @Autowired
    private RedisService redisService;

    /**
     * 登录
     */
    public LoginUser login(String username, String password)
    {
        // 用户名或密码为空 错误
        if (StringUtils.isAnyBlank(username, password))
        {
            recordLogService.recordLogininfor(username, Constants.LOGIN_FAIL, "用户/密码必须填写");
            throw new ServiceException("用户/密码必须填写");
        }
        // 密码如果不在指定范围内 错误
        if (password.length() < UserConstants.PASSWORD_MIN_LENGTH
                || password.length() > UserConstants.PASSWORD_MAX_LENGTH)
        {
            recordLogService.recordLogininfor(username, Constants.LOGIN_FAIL, "用户密码不在指定范围");
            throw new ServiceException("用户密码不在指定范围");
        }
        // 用户名不在指定范围内 错误
        if (username.length() < UserConstants.USERNAME_MIN_LENGTH
                || username.length() > UserConstants.USERNAME_MAX_LENGTH)
        {
            recordLogService.recordLogininfor(username, Constants.LOGIN_FAIL, "用户名不在指定范围");
            throw new ServiceException("用户名不在指定范围");
        }
        // IP黑名单校验
        String blackStr = Convert.toStr(redisService.getCacheObject(CacheConstants.SYS_LOGIN_BLACKIPLIST));
        if (IpUtils.isMatchedIp(blackStr, IpUtils.getIpAddr()))
        {
            recordLogService.recordLogininfor(username, Constants.LOGIN_FAIL, "很遗憾，访问IP已被列入系统黑名单");
            throw new ServiceException("很遗憾，访问IP已被列入系统黑名单");
        }
        // 查询用户信息
        R<LoginUser> userResult = remoteUserService.getUserInfo(username, SecurityConstants.INNER);

        if (R.FAIL == userResult.getCode())
        {
            throw new ServiceException(userResult.getMsg());
        }

        LoginUser userInfo = userResult.getData();
        SysUser user = userResult.getData().getSysUser();
        if (UserStatus.DELETED.getCode().equals(user.getDelFlag()))
        {
            recordLogService.recordLogininfor(username, Constants.LOGIN_FAIL, "对不起，您的账号已被删除");
            throw new ServiceException("对不起，您的账号：" + username + " 已被删除");
        }
        if (UserStatus.DISABLE.getCode().equals(user.getStatus()))
        {
            recordLogService.recordLogininfor(username, Constants.LOGIN_FAIL, "用户已停用，请联系管理员");
            throw new ServiceException("对不起，您的账号：" + username + " 已停用");
        }
        passwordService.validate(user, password);
        recordLogService.recordLogininfor(username, Constants.LOGIN_SUCCESS, "登录成功");
        recordLoginInfo(user.getUserId());
        return userInfo;
    }

    /**
     * 记录登录信息
     *
     * @param userId 用户ID
     */
    public void recordLoginInfo(Long userId)
    {
        SysUser sysUser = new SysUser();
        sysUser.setUserId(userId);
        // 更新用户登录IP
        sysUser.setLoginIp(IpUtils.getIpAddr());
        // 更新用户登录时间
        sysUser.setLoginDate(DateUtils.getNowDate());
        remoteUserService.recordUserLogin(sysUser, SecurityConstants.INNER);
    }

    public void logout(String loginName)
    {
        recordLogService.recordLogininfor(loginName, Constants.LOGOUT, "退出成功");
    }

    /**
     * 注册
     */
    public void register(String username, String password)
    {
        // 用户名或密码为空 错误
        if (StringUtils.isAnyBlank(username, password))
        {
            throw new ServiceException("用户/密码必须填写");
        }
        if (username.length() < UserConstants.USERNAME_MIN_LENGTH
                || username.length() > UserConstants.USERNAME_MAX_LENGTH)
        {
            throw new ServiceException("账户长度必须在2到20个字符之间");
        }
        if (password.length() < UserConstants.PASSWORD_MIN_LENGTH
                || password.length() > UserConstants.PASSWORD_MAX_LENGTH)
        {
            throw new ServiceException("密码长度必须在5到20个字符之间");
        }

        // 注册用户信息
        SysUser sysUser = new SysUser();
        sysUser.setUserName(username);
        sysUser.setNickName(username);
        sysUser.setPhonenumber(username); // 手机号作为用户名
        sysUser.setPwdUpdateDate(DateUtils.getNowDate());
        sysUser.setPassword(SecurityUtils.encryptPassword(password));
        R<?> registerResult = remoteUserService.registerUserInfo(sysUser, SecurityConstants.INNER);

        if (R.FAIL == registerResult.getCode())
        {
            throw new ServiceException(registerResult.getMsg());
        }
        recordLogService.recordLogininfor(username, Constants.REGISTER, "注册成功");
    }

    /**
     * 普通用户注册（带邮箱验证码）
     */
    public void registerUser(RegisterBody registerBody)
    {
        String username = registerBody.getUsername();
        String password = registerBody.getPassword();
        String email = registerBody.getEmail();
        String emailCode = registerBody.getEmailCode();

        // 用户名、密码、邮箱或验证码为空 错误
        if (StringUtils.isAnyBlank(username, password, email, emailCode))
        {
            throw new ServiceException("用户信息不完整");
        }

        // 验证手机号格式
        if (!checkPhone(username)) {
            throw new ServiceException("请输入正确的手机号");
        }

        if (username.length() < UserConstants.USERNAME_MIN_LENGTH
                || username.length() > UserConstants.USERNAME_MAX_LENGTH)
        {
            throw new ServiceException("账户长度必须在2到20个字符之间");
        }
        if (password.length() < UserConstants.PASSWORD_MIN_LENGTH
                || password.length() > UserConstants.PASSWORD_MAX_LENGTH)
        {
            throw new ServiceException("密码长度必须在5到20个字符之间");
        }

        // 验证邮箱验证码（从Redis中获取验证码进行比对）
        String codeKey = CacheConstants.EMAIL_CODE_KEY + email;
        String codeFromRedis = redisService.getCacheObject(codeKey);
        if (StringUtils.isNull(codeFromRedis)) {
            throw new ServiceException("验证码已过期，请重新获取");
        }
        if (!codeFromRedis.equals(emailCode)) {
            throw new ServiceException("验证码错误，请重新输入");
        }

        // 验证邮箱是否已被使用
//        R<Boolean> uniqueEmail = remoteUserService.checkEmailUnique(email, SecurityConstants.INNER);
//        if (R.FAIL == uniqueEmail.getCode()) {
//            throw new ServiceException(uniqueEmail.getMsg());
//        }
//        if (!uniqueEmail.getData()) {
//            throw new ServiceException("该邮箱已被使用");
//        }

        // 验证手机号是否已被使用
//        R<Boolean> uniquePhone = remoteUserService.checkPhoneUnique(username, SecurityConstants.INNER);
//        if (R.FAIL == uniquePhone.getCode()) {
//            throw new ServiceException(uniquePhone.getMsg());
//        }
//        if (!uniquePhone.getData()) {
//            throw new ServiceException("该手机号已被使用");
//        }

        // 注册用户信息
        SysUser sysUser = new SysUser();
        sysUser.setUserName(username);
        sysUser.setNickName(username);
        sysUser.setPhonenumber(username); // 手机号作为用户名
        sysUser.setEmail(email);
        sysUser.setPwdUpdateDate(DateUtils.getNowDate());
        sysUser.setPassword(SecurityUtils.encryptPassword(password));
        R<?> registerResult = remoteUserService.registerUserInfo(sysUser, SecurityConstants.INNER);

        if (R.FAIL == registerResult.getCode())
        {
            throw new ServiceException(registerResult.getMsg());
        }

        // 删除已使用的验证码
        redisService.deleteObject(codeKey);

        recordLogService.recordLogininfor(username, Constants.REGISTER, "注册成功");
    }

    /**
     * 验证手机号格式
     *
     * @param phone 手机号
     * @return 是否正确
     */
    private boolean checkPhone(String phone) {
        String regex = "^1[3|4|5|6|7|8|9][0-9]\\d{8}$";
        return phone.matches(regex);
    }
}
