FROM openjdk:8-jre-alpine
WORKDIR /app
COPY target/SpringBootRestApiExample-1.0.jar /app
CMD ["java -jar spring-petclinic-1.5.1.jar"]
