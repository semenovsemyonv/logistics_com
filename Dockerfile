FROM maven:3.9.9-amazoncorretto-23 AS build
COPY . .
RUN mvn clean package -DskipTests

FROM amazoncorretto:8u432-al2023-jre
COPY --from=build /target/logistics-company-0.0.1-SNAPSHOT.jar logistics.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","demo.jar"]