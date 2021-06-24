FROM tomcat:9
COPY webapp/target/webapp.war /usr/local/tomcat/webapps
