FROM ubuntu:latest
LABEL "author"="Rutu"
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install git -y
RUN apt install apache2 -y
CMD ["/usr/sbin/apache2ctl","-D","FOREGROUND"]
WORKDIR /var/www/html
VOLUME /var/log/apache2
EXPOSE 8080
ADD target/* /var/www/html/
COPY target/* /var/www/html/

#FROM openjdk
#COPY target/*.war /
#EXPOSE 8080
#ENTRYPOINT ["java","-war","/bookstore-example-1.0-SNAPSHOT.war"]






#FROM maven:3.6.0-jdk-11-slim AS build
#COPY src /home/app/src
#COPY pom.xml /home/app
#RUN mvn -f /home/app/pom.xml clean package

#
# Package stage
#
#FROM openjdk:11-jre-slim
#COPY --from=build /home/app/target/demo-0.0.1-SNAPSHOT.jar /usr/local/lib/demo.jar
#EXPOSE 8080
#EXPOSE 9090
#ENTRYPOINT ["java","-jar","/usr/local/lib/demo.jar"]
