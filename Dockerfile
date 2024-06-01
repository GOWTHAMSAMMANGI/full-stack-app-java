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

WORKDIR /opt/shipping

COPY target/shopping-cart-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8070

ENTRYPOINT exec java -jar app.jar