# Stage 1: Build
FROM eclipse-temurin:17-jdk-alpine AS builder

WORKDIR /build

COPY src/Main.java .

RUN javac Main.java


# Stage 2: Runtime
FROM eclipse-temurin:17-jre-alpine

# Create non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /app

COPY --from=builder /build/Main.class .

# Change ownership
RUN chown -R appuser:appgroup /app

USER appuser

CMD ["java", "Main"]
