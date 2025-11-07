package com.match.email;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import com.match.common.security.annotation.EnableCustomConfig;
import com.match.common.security.annotation.EnableRyFeignClients;

/**
 * 邮件模块启动程序
 *
 * @author bruceXuu
 */
@SpringBootApplication
@MapperScan("com.match.email.mapper")
@EnableRyFeignClients
public class MatchEmailApplication
{
    public static void main(String[] args)
    {
        SpringApplication.run(MatchEmailApplication.class, args);
        System.out.println("(♥◠‿◠)ﾉﾞ  邮件模块启动成功   ლ(´ڡ`ლ)ﾞ");
    }
}
