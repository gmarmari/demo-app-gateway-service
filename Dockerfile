FROM openjdk:17-slim-bullseye

LABEL org.opencontainers.image.authors="Georgios Marmaris"

RUN groupadd --system nonroot && useradd --no-log-init --system --no-create-home -g nonroot nonroot
USER nonroot

VOLUME ["/app/log"]

ENTRYPOINT ["java", "-jar", "/app/gateway-service.jar"]

COPY --chown=nonroot:nonroot target/gateway-service-*.jar /app/gateway-service.jar