FROM maven:3.8.5-openjdk-17 AS build
COPY . .
# Thêm lệnh cài đặt Lombok
RUN mvn lombok:delombok
RUN mvn clean package -DskipTests

FROM openjdk:17.0.1-jdk-slim
COPY --from=build /target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app.jar"]