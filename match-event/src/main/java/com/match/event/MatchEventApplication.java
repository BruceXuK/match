package com.match.event;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import com.match.common.security.annotation.EnableCustomConfig;
import com.match.common.security.annotation.EnableRyFeignClients;
import org.springframework.context.annotation.ComponentScan;

/**
 * 赛事模块
 *
 * @author bruceXuu
 */
@EnableCustomConfig
@EnableRyFeignClients
@SpringBootApplication
public class MatchEventApplication
{
    public static void main(String[] args)
    {
        SpringApplication.run(MatchEventApplication.class, args);
        System.out.println("(♥◠‿◠)ﾉﾞ  赛事模块启动成功   ლ(´ڡ`ლ)ﾞ  \n" +
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
