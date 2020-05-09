FROM openjdk:8-jre-alpine
ARG VERSION
WORKDIR /app
COPY target/SpringBootRestApiExample-$VERSION.jar /app
ENTRYPOINT ["java", "-jar", "SpringBootRestApiExample-$VERSION.jar"]
