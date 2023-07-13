FROM openjdk:8
EXPOSE 8080
COPY target/*war /usr/local/tomcat/webapps
ENTRYPOINT ["java","-war","web-app.war"]
