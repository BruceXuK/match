package com.match.job;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import com.match.common.security.annotation.EnableCustomConfig;
import com.match.common.security.annotation.EnableRyFeignClients;

/**
 * 定时任务
 *
 * @author bruceXuu
 */
@EnableCustomConfig
@EnableRyFeignClients
@SpringBootApplication
public class MatchJobApplication
{
    public static void main(String[] args)
    {
        SpringApplication.run(MatchJobApplication.class, args);
        System.out.println("(♥◠‿◠)ﾉﾞ  定时任务模块启动成功   ლ(´ڡ`ლ)ﾞ  \n" +
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
