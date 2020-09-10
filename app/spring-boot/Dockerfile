FROM debian:10-slim as sleep-binary
FROM gcr.io/distroless/java:8
COPY --from=sleep-binary /bin/sleep /bin/sleep

COPY build/libs/inno-spring-boot-1.0.jar /usr/app/app.jar
ENTRYPOINT ["java", "-server", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseContainerSupport", "-XX:MaxRAMPercentage=75.0", "-jar", "/usr/app/app.jar"]