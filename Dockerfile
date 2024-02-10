# Use an official Maven runtime as a parent image
FROM maven:3.8.4-jdk-11 AS build

# Set the working directory in the container
WORKDIR /home/ec2-user/

# Copy the project files into the container
COPY . .

# Build the Maven project
RUN mvn clean install

# Use AdoptOpenJDK 11 as the base image
FROM tomcat:9.0-jdk11-openjdk-slim

# Set the working directory in the container
WORKDIR /usr/local/tomcat/webapps

# Copy the built artifact from the Maven image
COPY --from=build /home/ec2-user/webapp/target/webapp.war .
