FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY .mvn/ .mvn
COPY mvnw pom.xml ./
# Thêm quyền thực thi cho mvnw
RUN chmod +x mvnw
RUN ./mvnw dependency:go-offline
COPY src ./src
RUN ./mvnw clean package -DskipTests

FROM openjdk:17.0.1-jdk-slim
WORKDIR /app
COPY --from=build /app/target/*.war app.jar
ENV PORT=8080
EXPOSE ${PORT}
CMD ["java", "-Dserver.port=${PORT}", "-Dserver.address=0.0.0.0", "-jar", "app.jar"]