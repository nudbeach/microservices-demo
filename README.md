# What's updated

- env.var	Externalize eureka references in src\main\resources\*.yml. you can change them with yours(ip address)
- Dockerfile	Example docker build
- run.bat	Batch file to test on Windows

## What's required to build

- JDK 1.8.x
- Maven (any)

to run docker build 

```
docker build -t microservice-demo:v1 .
````

## Pushing container image to registry

```
docker login --username={user id} -p {registry password} {registry end point} 
docker tag microservice-demo:v1 {registry end point}/{user id}/microservice-demo:v1
docker push {registry end point}/{user id}/microservice-demo:v1
```

## How to run

- Running services in Spring Boot procedure

Find "Procedure" and "Command line" at the bottom of this page
  
```
java -Deureka.url=http://localhost:1111/eureka/ -Deureka.host=localhost -jar target/microservices-demo-2.0.0.RELEASE.jar registration  
java -Deureka.url=http://localhost:1111/eureka/ -Deureka.host=localhost -jar target/microservices-demo-2.0.0.RELEASE.jar accounts  
java -Deureka.url=http://localhost:1111/eureka/ -Deureka.host=localhost -jar target/microservices-demo-2.0.0.RELEASE.jar web
```  

- Running locally in Docker container 

```
docker run  -p 1111:1111 --network=host --env-file=env.var microservice-demo:v1 registration
docker run  -p 2222:2222 --env-file=env.var microservice-demo:v1 accounts
docker run  -p 3333:3333 --network=host --env-file=env.var microservice-demo:v1 web
```

- Running locally in Docker container with Kubernetes

```
docker run  -p 1111:1111 -p 2222:2222 -p 3333:3333 --name=eureka --env-file=env.var microservice-demo:v1 registration
docker run  --network=container:eureka --env-file=env.var microservice-demo:v1 accounts
docker run  --network=container:eureka --env-file=env.var microservice-demo:v1 web
```

1. Build container

2. Run the containers



# microservices-demo

Demo application to go with my [Microservices Blog](https://spring.io/blog/2015/07/14/microservices-with-spring) on the spring.io website.  **WARNING:** Only maven build has been updated.  Gradle build still to be done.

![Demo System Schematic](https://github.com/paulc4/microservices-demo/blob/master/mini-system.jpg)

Clone it and either load into your favorite IDE or use maven/gradle directly.

_Note for gradle users:_ to make the intructions below build-tool independent, the gradle build copies its artifacts from `build/libs` to `target`.

## Versions

Current version (June 2018) v2.0.0 corresponds to Spring Boot 2 and Finchly release train.

**WARNING:** Only maven build has been updated.  Gradle build still to be done.

Previous versions have been tagged and can be accessed using the `Branch` button above or using `git checkout <version>` - for example `git checkout v1.2.0`.

Tagged versions are:

* v2.0.0 - Spring Boot 2.0 and Spring Cloud release-train Finchley
* v1.2.0 corresponds to Spring Boot 1.5 and Spring Cloud release-train Edgeware
* v1.1.0 corresponds to Spring Cloud release-train Brixton
* v1.0.0 corresponds to Spring Cloud release-train Angel.SR6

## Using an IDE

You can run the system in your IDE by running the three server classes in order: _RegistrationService_, _AccountsService_ and _WebService_.  Each is a Spring Boot application using embedded Tomcat.  In Spring Tool Suite use `Run As ... Spring Boot App` otherwise just run each as a Java application - each has a static `main()` entry point.

As discussed in the Blog, open the Eureka dashboard [http://localhost:1111](http://localhost:1111) in your browser to see that the `ACCOUNTS-SERVICE` and `WEB-SERVICE` applications have registered.  Next open the Demo Home Page [http://localhost:3333](http://localhost:3333) in and click one of the demo links.

The `localhost:3333` web-site is being handled by a Spring MVC Controller in the _WebService_ application, but you should also see logging output from _AccountsService_ showing requests for Account data.

## Command Line

You may find it easier to view the different applications by running them from a command line since you can place the three windows side-by-side and watch their log output

For convenience we are building a 'fat' executble jar whose start-class (main method entry-point) is defined to be in the class `io.pivotal.microservices.services.Main`.  This application expects a single command-line argument that tells it to run as any of our three servers.

```
java -jar target/microservices-demo-2.0.0.RELEASE.jar registration|accounts|web
```

### Priocedure

To run the microservices system from the command-line, open three CMD windows (Windows) or three Terminal windows (MacOS, Linux) and arrange so you can view them conveniently.

 1. In each window, change to the directory where you cloned the demo.
 1. In the first window, build the application using either `mvn clean package` or `gradle clean assemble`.  Either way the
    generated file will be `target/microservices-demo-2.0.0.RELEASE.jar` (even if you used gradle).
 1. In the same window run: `java -jar target/microservices-demo-2.0.0.RELEASE.jar registration`
 1. Switch to the second window and run: `java -jar target/microservices-demo-2.0.0.RELEASE.jar accounts`
 1. In the third window run: `java -jar target/microservices-demo-2.0.0.RELEASE.jar web`
 1. In your favorite browser open the same two links: [http://localhost:1111](http://localhost:1111) and [http://localhost:3333](http://localhost:3333)

You should see servers being registered in the log output of the first (registration) window.
As you interact wiht the Web application, you should logging in the both the second and third windows.

For a list of valid accounts refer to the [data.sql](https://github.com/paulc4/microservices-demo/blob/master/src/main/resources/testdb/data.sql) that is used by the Account Service to set them up.

 1. In a new window, run up a second account-server using HTTP port 2223:
     * `java -jar target/microservices-demo-2.0.0.RELEASE.jar accounts 2223`
 1. Allow it to register itself
 1. Kill the first account-server and see the web-server switch to using the new account-server - no loss of service.

