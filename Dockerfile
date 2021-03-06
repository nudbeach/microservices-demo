FROM openjdk:8-jdk-alpine

VOLUME /tmp
COPY target/microservices-demo-2.0.0.RELEASE.jar .
COPY target/web-contents /web-home/

ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-Deureka.url=${EUREKA_URL}", "-Deureka.host=${EUREKA_HOST}", "-Dweb.home=/web-home/", "-jar", "microservices-demo-2.0.0.RELEASE.jar"]

EXPOSE 1111/tcp
EXPOSE 2222/tcp
EXPOSE 3333/tcp
