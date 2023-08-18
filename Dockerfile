# Build stage
FROM golang:1.19-alpine3.15 AS builder

# Set the working directory
WORKDIR /app

# Copy the Go source files
COPY . .

# Compile the Go app to a static binary
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -a -installsuffix cgo -o app .

# Final stage
FROM scratch

# Copy the compiled binary from the builder stage
COPY --from=builder /app/app /app

# Command to run the application
ENTRYPOINT ["/app"]
