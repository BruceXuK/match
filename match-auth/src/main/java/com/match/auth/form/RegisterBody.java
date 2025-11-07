package com.match.auth.form;

/**
 * 用户注册对象
 * 
 * @author bruceXuu
 */
public class RegisterBody extends LoginBody
{
    /**
     * 用户邮箱
     */
    private String email;
    
    /**
     * 邮箱验证码
     */
    private String emailCode;

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getEmailCode() {
        return emailCode;
    }

    public void setEmailCode(String emailCode) {
        this.emailCode = emailCode;
    }
}