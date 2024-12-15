FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY .mvn/ .mvn
COPY mvnw pom.xml ./
RUN chmod +x mvnw
RUN ./mvnw dependency:go-offline
COPY src ./src
RUN ./mvnw clean package -DskipTests

FROM tomcat:9.0-jdk17

ENV CATALINA_OPTS="-Dorg.apache.catalina.webresources.Cache.cacheMaxSize=100000"
ENV JAVA_OPTS="-XX:+UseContainerSupport -Xmx512m -Xms256m"
ENV PORT=8080
ENV APP_URL="https://eyewear-spring-app.onrender.com"

RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]