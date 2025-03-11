FROM openjdk:21 AS BUILD
COPY . /app/
WORKDIR /app/
RUN ./mvnw clean test package -Pproduction

FROM openjdk:21
COPY --from=BUILD /app/target/*.jar /app/app.jar
WORKDIR /app/
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app.jar"]
