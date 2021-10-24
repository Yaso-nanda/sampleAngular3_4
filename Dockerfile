FROM alpine/git
WORKDIR /apps
RUN git clone https://github.com/Yaso-nanda/sampleAngular3.git

FROM node:12.7-alpine
WORKDIR /apps
COPY --from=0 /apps/sampleAngular3 /apps
RUN ls
RUN npm install -g @angular/cli@10.0.4 && \
    npm install && \
    ng build --prod --base-href /angular-frontend/
RUN ls dist

FROM maven:3.6-jdk-11
WORKDIR /apps
COPY --from=1 /apps /apps
RUN mvn clean install -DskipTests

FROM tomcat:8.5.47-jdk8-openjdk
COPY --from=2 /apps/target/angular-frontend.war /usr/local/tomcat/webapps
