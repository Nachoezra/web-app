FROM openjdk:8
EXPOSE 8080
ADD target/*war /usr/local/tomcat/webapps
ENTRYPOINT ["java","-war","web-app.war"]
