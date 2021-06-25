FROM tomcat:latest
#COPY webapp/target/webapp.war /usr/local/tomcat/webapps
COPY /home/poc-admin/poc/webapp_$BUILD_ID.war /usr/local/tomcat/webapps

