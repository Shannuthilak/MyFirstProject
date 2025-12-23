# Stage 1: Build stage
FROM eclipse-temurin:24-jdk AS build
WORKDIR /app

# Copy gradle executable and configuration files
COPY gradlew .
COPY gradle gradle
COPY build.gradle .
COPY settings.gradle .

# Give execution permission to the gradlew script
RUN chmod +x gradlew

# Download dependencies (this layer is cached if build.gradle doesn't change)
RUN ./gradlew dependencies --no-daemon

# Copy the source code and build the application
COPY src src
RUN ./gradlew bootJar --no-daemon

# Stage 2: Run stage
FROM eclipse-temurin:24-jre AS run
WORKDIR /app

# Create a non-root user for security
RUN addgroup --system spring && adduser --system spring --ingroup spring
USER spring:spring

# Copy only the built JAR from the build stage
COPY --from=build /app/build/libs/*.jar first-project-java.jar

# Expose the default Spring Boot port
EXPOSE 8081

# Run the application
ENTRYPOINT ["java", "-jar", "first-project-java.jar"]