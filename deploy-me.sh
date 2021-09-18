#!/bin/bash
cd workspace/spring-demo-gradle

git fetch origin master
git reset --hard origin/master

#動いてるコンテナ止める
docker stop production

#イメージとコンテナ全部消す
docker ps -aq | xargs docker rm
docker images -aq | xargs docker rmi

echo ----------------------------start build----------------------------
chmod +x gradlew
sudo ./gradlew build
echo -------------------------build completed!!!------------------------

#最新のdockerimageをpull
docker pull cystdot/circleci

#Dockerfileを元にimageを作成する
docker build --build-arg JAR_FILE=build/libs/\*.jar -t cystdot/circleci:mainbranch /home/ec2-user/workspace/spring-demo-gradle/
#docker build -t cystdot/circleci:madebyshell /home/ec2-user/workspace/spring-demo-gradle/


#ビルドしたイメージをhubにあげる
docker push cystdot/circleci:mainbranch


#アプリケーション起動
docker run --name production -p 8080:8080 cystdot/circleci:mainbranch
