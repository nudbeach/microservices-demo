@Echo Off

Rem --

Set JAVA_HOME=c:\Java\jdk1.8.0_202\
Set VERSION=2.0.0.RELEASE
Set OPT1=-Deureka.url=http://localhost:1111/eureka/ -Deureka.host=localhost

start java %OPT1% -jar target/microservices-demo-%VERSION%.jar registration

timeout /t 10 /nobreak

start java %OPT1% -jar target/microservices-demo-%VERSION%.jar accounts

timeout /t 5 /nobreak

start java %OPT1% -jar target/microservices-demo-%VERSION%.jar web