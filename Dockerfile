FROM openjdk:8-jre-alpine
ENV VERSION
WORKDIR /app
COPY target/SpringBootRestApiExample-${VERSION}.jar /app
ENTRYPOINT ["java", "-jar", "SpringBootRestApiExample-${VERSION}.jar"]
