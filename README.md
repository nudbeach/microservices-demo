# What's updated

- env.var	Externalize eureka references in src\main\resources\*.yml. you can change them with yours(ip address)
- Dockerfile	Example docker build
- run.bat	Batch file to test on Windows

## What's required to build

- JDK 1.8.x
- Maven

## How to clone the repo

````
git clone https://github.com/nudbeach/microservices-demo.git 
````

## How to build Spring Boot source code

to build source code  
 
````
mvn clean package
````

Once build's done successfully you'll find microservices-demo-2.0.0.RELEASE.jar from target directory

to run docker build 

````
docker build -t microservice-demo:v1 .
````

## How to run

- Running services in Spring Boot procedure

Find "Procedure" and "Command line" at the bottom of this page
  
````
java -Deureka.url=http://localhost:1111/eureka/ -Deureka.host=localhost -jar target/microservices-demo-2.0.0.RELEASE.jar registration  
java -Deureka.url=http://localhost:1111/eureka/ -Deureka.host=localhost -jar target/microservices-demo-2.0.0.RELEASE.jar accounts  
java -Deureka.url=http://localhost:1111/eureka/ -Deureka.host=localhost -jar target/microservices-demo-2.0.0.RELEASE.jar web
````

- Running locally in Docker container 

````
docker run  -p 1111:1111 --network=host --env-file=env.var microservice-demo:v1 registration
docker run  -p 2222:2222 --network=host --env-file=env.var microservice-demo:v1 accounts
docker run  -p 3333:3333 --network=host --env-file=env.var microservice-demo:v1 web
````

- Running remotely at ACK cluster

```
docker run  -p 1111:1111 -p 2222:2222 -p 3333:3333 --name=eureka --env-file=env.var microservice-demo:v1 registration
docker run  --network=container:eureka --env-file=env.var microservice-demo:v1 accounts
docker run  --network=container:eureka --env-file=env.var microservice-demo:v1 web
```

## Pushing container image to registry

```
docker login --username={user id} -p {registry password} {registry end point} 
docker tag microservice-demo:v1 {registry end point}/{user id}/microservice-demo:v1
docker push {registry end point}/{user id}/microservice-demo:v1
```

