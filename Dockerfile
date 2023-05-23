FROM gradle:jdk11 AS builder
WORKDIR /app
COPY . .
RUN gradle build
RUN gradle wrapper
RUN ./gradlew build

# Use a base image with Java and Gradle pre-installed
FROM adoptopenjdk:11-jre-hotspot AS deploy
WORKDIR /app
COPY --from=builder /app/build/libs/*.jar /app/spring-boot-application.jar
# Set the working directory inside the container
CMD ["java", "-jar", "spring-boot-application.jar"]
