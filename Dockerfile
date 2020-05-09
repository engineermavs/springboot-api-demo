FROM openjdk:8-jre-alpine
ARG POM_VERSION
RUN echo "Building ${POM_VERSION}"
WORKDIR /app
COPY target/SpringBootRestApiExample-1.0.jar /app
ENTRYPOINT ["java", "-jar", "SpringBootRestApiExample-${POM_VERSION}.jar"]
