FROM openjdk:8-jre-alpine
WORKDIR /app
COPY target/SpringBootRestApiExample-1.0.jar /app
ENTRYPOINT ["java", "-jar", "SpringBootRestApiExample-2.0.jar"]
