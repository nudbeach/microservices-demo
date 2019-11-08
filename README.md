# What's updated

- env.var	Externalize eureka references in src\main\resources\*.yml. you can change them with yours(ip address)
- Dockerfile	Example docker build
- run.bat	Batch file to test on Windows

## What's required to build

- JDK 1.8.x
- Maven

## Quick start

- Clone repo

````
git clone https://github.com/nudbeach/microservices-demo.git 
````

- Build Spring Boot source code

to build source code  
 
````
mvn clean package
````

Once build's done successfully you'll find 'microservices-demo-2.0.0.RELEASE.jar' from target directory

- Build container image 

````
docker build -t microservice-demo:{tag} .
````

## Running the app

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

Create your ACK cluster first and publish the image and deploy to it


## Pushing container image to registry

Create your registry first from Container Registry Console

- Login to your registry

````
docker login --username={user id} -p {registry password} {registry end point} 
````

- Tagging your container image

````
docker tag microservice-demo:v1 {registry end point}/{user id}/microservice-demo:v1-reg
docker tag microservice-demo:v1 {registry end point}/{user id}/microservice-demo:v1-acnt
docker tag microservice-demo:v1 {registry end point}/{user id}/microservice-demo:v1-web
````

- Publishing your container image

````
docker push {registry end point}/{user id}/microservice-demo:v1-reg
docker push {registry end point}/{user id}/microservice-demo:v1-acnt
docker push {registry end point}/{user id}/microservice-demo:v1-web
````

For example

````
docker tag d649569a912c registry-intl.ap-northeast-1.aliyuncs.com/krca001/microservice-demo:v1-reg
docker tag d649569a912c registry-intl.ap-northeast-1.aliyuncs.com/krca001/microservice-demo:v1-acnt
docker tag d649569a912c registry-intl.ap-northeast-1.aliyuncs.com/krca001/microservice-demo:v1-web

docker push registry-intl.ap-northeast-1.aliyuncs.com/krca001/microservice-demo:v1-reg
docker push registry-intl.ap-northeast-1.aliyuncs.com/krca001/microservice-demo:v1-acnt
docker push registry-intl.ap-northeast-1.aliyuncs.com/krca001/microservice-demo:v1-web
````

