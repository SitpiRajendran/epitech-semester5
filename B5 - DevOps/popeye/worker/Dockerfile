FROM maven:3.5-jdk-8-alpine AS builder

ADD . .

RUN mvn dependency:resolve

RUN cd /src

RUN mvn package

##################################################

FROM openjdk:8-jre-alpine

COPY --from=builder target/worker-jar-with-dependencies.jar .

CMD ["java", "-jar", "worker-jar-with-dependencies.jar"]