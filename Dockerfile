FROM openjdk:8-jre-alpine
ARG VERSION
WORKDIR /app
COPY target/SpringBootRestApiExample-$VERSION.jar /app/SpringBootRestApiExample.jar
ENTRYPOINT ["java", "-jar", "SpringBootRestApiExample.jar"]
