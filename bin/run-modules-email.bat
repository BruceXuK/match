@echo off
@REM 启动邮件服务模块

cd /d E:\Bruce\Match\match-modules\match-email
call mvn spring-boot:run
pause