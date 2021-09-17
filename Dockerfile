FROM cystdot/circleci:local_able

WORKDIR /project/spring-demo-gradle

COPY ./build/libs/demogradle-0.0.1-SNAPSHOT.jar .

ARG JAR_FILE

ENTRYPOINT ["java","-jar","demogradle-0.0.1-SNAPSHOT.jar"]