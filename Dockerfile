FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY .mvn/ .mvn
COPY mvnw pom.xml ./
RUN chmod +x mvnw
RUN ./mvnw dependency:go-offline
COPY src ./src
RUN ./mvnw clean package -DskipTests

FROM tomcat:9.0-jdk17
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war
COPY --from=build /app/src/main/webapp/views /usr/local/tomcat/webapps/ROOT/views

ENV APP_URL=${APP_URL}
ENV PORT=${PORT}
ENV JAVA_OPTS=${JAVA_OPTS}
ENV CATALINA_OPTS="-Dorg.apache.catalina.connector.RECYCLE_FACADES=true"
ENV SPRING_PROFILES_ACTIVE=prod

ENV CATALINA_OPTS="${CATALINA_OPTS} ${JAVA_OPTS}"

EXPOSE ${PORT}
CMD ["catalina.sh", "run"]