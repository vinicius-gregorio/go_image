# Build stage
FROM golang:1.19-alpine3.15 AS builder

# Set the working directory
WORKDIR /app

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -a -installsuffix cgo -o app .

FROM scratch

COPY --from=builder /app/app /app

ENTRYPOINT ["/app"]
