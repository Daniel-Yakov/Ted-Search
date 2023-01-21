# This Dockerfile dockerize the TED Search app
FROM openjdk:8-jre
WORKDIR /app
COPY target/ application.properties ./
ENTRYPOINT [ "java", "-jar", "embedash-1.1-SNAPSHOT.jar", "--spring.config.location=./application.properties" ]