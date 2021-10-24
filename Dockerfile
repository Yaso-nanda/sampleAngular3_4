FROM alpine/git
WORKDIR /app
RUN git clone https://github.com/Yaso-nanda/sampleAngular3.git

FROM node:12.7-alpine
WORKDIR /app
COPY --from=0 /app/sampleAngular3 /app
RUN npm install -g @angular/cli@10.0.4 && \
    npm install && \
    ng build --prod --base-href /employ/
    
FROM maven:3.6-jdk-11
WORKDIR /app
COPY --from=1 /app /app
RUN mvn clean install -DskipTests

FROM tomcat:8.5.47-jdk8-openjdk
COPY --from=2 /app/target/employ.war /usr/local/tomcat/webapps
