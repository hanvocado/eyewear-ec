FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY .mvn/ .mvn
COPY mvnw pom.xml ./
RUN chmod +x mvnw
RUN ./mvnw dependency:go-offline
COPY src ./src
RUN ./mvnw clean package -DskipTests

FROM tomcat:10.1-jdk17
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war
COPY --from=build /app/src/main/webapp/views /usr/local/tomcat/webapps/ROOT/views
EXPOSE 8080
CMD ["catalina.sh", "run"]