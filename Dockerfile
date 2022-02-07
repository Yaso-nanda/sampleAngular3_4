FROM tomcat:8.5.47-jdk8-openjdk
COPY target/angular-frontend.war /usr/local/tomcat/webapps
COPY tomcat-users.xml /usr/local/tomcat/conf/
COPY context.xml /tmp/context.xml
RUN cp -R /usr/local/tomcat/webapps.dist/* /usr/local/tomcat/webapps
