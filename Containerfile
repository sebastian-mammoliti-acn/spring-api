FROM maven:3.9-eclipse-temurin-17 AS builder

WORKDIR /workspace

COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests

FROM registry.access.redhat.com/ubi9/openjdk-17-runtime

WORKDIR /app

COPY --from=builder /workspace/target/*.jar app.jar

EXPOSE 8080

USER 1001

ENTRYPOINT ["java","-jar","app.jar"]