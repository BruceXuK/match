#!/bin/sh

# 复制项目的文件到对应docker路径，便于一键生成镜像。
usage() {
	echo "Usage: sh copy.sh"
	exit 1
}


# copy sql
echo "begin copy sql "
cp ../sql/ry_20250523.sql ./mysql/db
cp ../sql/ry_config_20250224.sql ./mysql/db

# copy html
echo "begin copy html "
cp -r ../match-ui/dist/** ./nginx/html/dist


# copy jar
echo "begin copy match-gateway "
cp ../match-gateway/target/match-gateway.jar ./ruoyi/gateway/jar

echo "begin copy match-auth "
cp ../match-auth/target/match-auth.jar ./ruoyi/auth/jar

echo "begin copy match-visual "
cp ../match-visual/match-monitor/target/match-visual-monitor.jar  ./ruoyi/visual/monitor/jar

echo "begin copy match-modules-system "
cp ../match-modules/match-system/target/match-modules-system.jar ./ruoyi/modules/system/jar

echo "begin copy match-modules-file "
cp ../match-modules/match-file/target/match-modules-file.jar ./ruoyi/modules/file/jar

echo "begin copy match-modules-job "
cp ../match-modules/match-job/target/match-modules-job.jar ./ruoyi/modules/job/jar

echo "begin copy match-modules-gen "
cp ../match-modules/match-gen/target/match-modules-gen.jar ./ruoyi/modules/gen/jar

