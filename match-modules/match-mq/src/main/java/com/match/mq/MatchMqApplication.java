package com.match.mq;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import com.match.common.security.annotation.EnableCustomConfig;
import com.match.common.security.annotation.EnableRyFeignClients;
import org.springframework.context.annotation.ComponentScan;

/**
 * 消息队列模块
 *
 * @author bruceXuu
 */
@EnableCustomConfig
@EnableRyFeignClients
@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class})
public class MatchMqApplication
{
    public static void main(String[] args)
    {
        SpringApplication.run(MatchMqApplication.class, args);
        System.out.println("(♥◠‿◠)ﾉﾞ  消息队列模块启动成功   ლ(´ڡ`ლ)ﾞ  \n" +
                " .-------.       ____     __        \n" +
                " |  _ _   \\      \\   \\   /  /    \n" +
                " | ( ' )  |       \\  _. /  '       \n" +
                " |(_ o _) /        _( )_ .'         \n" +
                " | (_,_).' __  ___(_ o _)'          \n" +
                " |  |\\ \\  |  ||   |(_,_)'         \n" +
                " |  | \\ `'   /|   `-'  /           \n" +
                " |  |  \\    /  \\      /           \n" +
                " ''-'   `'-'    `-..-'              ");
    }
}
