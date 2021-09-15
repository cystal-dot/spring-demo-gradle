!#/bin/bash
#dockerコンテナで実行するシェルスクリプト
echo entry docker container

cd spring-demo-gradle

echo start build gradle
gradle build
echo finish build gradle

echo exit from this container

exit