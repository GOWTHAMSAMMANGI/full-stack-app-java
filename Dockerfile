# Build
FROM debian:10 AS build

RUN apt-get update && apt-get -y install maven

WORKDIR /opt/shipping

COPY pom.xml /opt/shipping/

RUN mvn dependency:resolve

COPY src /opt/shipping/src/

RUN mvn package


# Run
FROM openjdk:8u151-jre-alpine3.7

ENV APP_HOME /usr/src/app

COPY target/shopping-cart-0.0.1-SNAPSHOT.jar $APP_HOME/app.jar

WORKDIR $APP_HOME

EXPOSE 8070

ENTRYPOINT exec java -jar app.jar