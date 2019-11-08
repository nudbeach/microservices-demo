FROM openjdk:8-jdk-alpine
VOLUME /tmp
COPY target/microservices-demo-2.0.0.RELEASE.jar .

ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-Deureka.url=${EUREKA_URL}", "-Deureka.host=${EUREKA_HOST}", "-jar","microservices-demo-2.0.0.RELEASE.jar"]

