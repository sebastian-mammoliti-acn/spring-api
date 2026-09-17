FROM maven:3.9-eclipse-temurin-17 AS builder

WORKDIR /workspace

RUN git clone https://github.com/sebastian-mammoliti-acn/spring-api.git .

RUN mvn clean package -DskipTests

FROM registry.access.redhat.com/ubi9/openjdk-17-runtime

WORKDIR /app

COPY --from=builder /workspace/target/*.jar /app/app.jar

EXPOSE 8080

USER 1001

ENTRYPOINT ["java","-jar","/app/app.jar"]