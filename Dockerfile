FROM openjdk:21 AS BUILD
COPY . /app/
WORKDIR /app/
ARG offlinekey
ENV VAADIN_OFFLINE_KEY=$offlinekey
RUN ./mvnw clean test package -Pproduction
# At this point, we have the app (executable jar file):  /app/target/vaadin-demo-1.0-SNAPSHOT.jar

# The "Run" stage. Start with a clean image, and copy over just the app itself, omitting gradle, npm and any intermediate build files.
FROM openjdk:21
COPY --from=BUILD /app/target/vaadin-demo-1.0-SNAPSHOT.jar /app/
WORKDIR /app/
EXPOSE 8080
ENTRYPOINT java -jar vaadin-demo-1.0-SNAPSHOT.jar 8080