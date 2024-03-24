# Stage 1: Build the application
FROM ubuntu AS builder

# Install required dependencies
RUN apt-get update && apt-get install -y openjdk-17-jdk
RUN apt-get install -y maven git

# Clone the application repository
RUN git clone https://github.com/JendareyTechnologies/Jendarey-Engineers-Voting-Result-App-Main-Project.git /app

# Build the application using Maven
WORKDIR /app
RUN mvn clean package

# Stage 2: Create the final image
FROM tomcat:10.1.14-jdk17

# Set metadata for the image
LABEL author="Akin"
LABEL project="jendarey-voting-app-main-project"

# Remove the default Tomcat applications
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the built WAR file from the builder stage
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080 for the application
EXPOSE 8080

# Define the default command to start Tomcat
CMD ["catalina.sh", "run"]




# docker build . -t jendaredocker/jendarey-voting-app-main:v2
# docker-compose up

# docker exec -it ac7 bash 
# ls /usr/local/tomcat/logs
# cat /usr/local/tomcat/logs
# docker logs jendarey-tech-mongo-1
# docker run -d -p 14000:8080 --name=voting-app4 jendaredocker/jendarey-voting-main:latest
# docker run -d -p 16000:8080 --name=cookies-web jendaredocker/jendarey-cookie-company-webpage:latest
# docker pull 10.1.13-jdk17
# Copy the .war file to the `webapps` directory
# docker cp target/a23-webpage.war tomcat:10.1.13-jdk17:/usr/local/tomcat/webapps/
# Start the Tomcat container
# docker run -it -p 8080:8080 tomcat:10.1.13-jdk17
# docker compose up
# docker exec -it ac7 bash 
# /usr/local/tomcat/logs#
# docker logs jendarey-tech-mongo-1
