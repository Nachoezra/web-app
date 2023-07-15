FROM tomcat:alpine
COPY target/*war /usr/local/tomcat/webapps
MAINTAINER  Ezra Ifeanacho
