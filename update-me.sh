!#/bin/bash
#dockerコンテナで実行するシェルスクリプト
echo entry docker container

cd spring-demo-gradle

echo start build gradle
sudo build gradle
echo finish build gradle

echo exit from this container

exit