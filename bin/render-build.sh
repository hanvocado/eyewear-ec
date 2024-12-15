#!/usr/bin/env bash
# exit on error
set -o errexit

# Build the project
./mvnw clean install -DskipTests

# Copy the built JAR file to the deployment directory 
cp target/*.jar app.jar