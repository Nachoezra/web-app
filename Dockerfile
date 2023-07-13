FROM tomcat:8.0.20-jre8
RUN 
COPY /var/jenkins_home/workspace/mydockerpipeline/target/*war /usr/local/tomcat/webapps
