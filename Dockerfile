FROM jenkins/jenkins:alpine
USER root
RUN curl -sSL https://get.docker.com/|sh
USER jenkins

FROM tomcat:8.0.20-jre8
ADD target/*war /usr/local/tomcat/webapps
ENTRYPOINT ["java","-war","web-app.war"]
