FROM openjdk:8-jre-alpine
ARG POM_VERSION
RUN echo "Building $POM_VERSION"
WORKDIR /app
COPY target/SpringBootRestApiExample-$POM_VERSION.jar /app
ENTRYPOINT ["java", "-jar", "SpringBootRestApiExample-$POM_VERSION.jar"]
