@Echo Off

Set JAVA_HOME=c:\Java\jdk1.8.0_202\
Set OPT1=

start java -jar target/microservices-demo-2.0.0.RELEASE.jar registration %OPT1%

timeout /t 10 /nobreak

start java -jar target/microservices-demo-2.0.0.RELEASE.jar accounts

timeout /t 5 /nobreak

start java -jar target/microservices-demo-2.0.0.RELEASE.jar web