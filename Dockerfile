FROM --platform=$BUILDPLATFORM golang:alpine AS builder

ARG TARGETARCH

WORKDIR /app
COPY . .

RUN CGO_ENABLED=0 GOARCH=${TARGETARCH} go build -o device-plugin .

FROM alpine:latest

COPY --from=builder /app/device-plugin /usr/local/bin/device-plugin

ENTRYPOINT ["/usr/local/bin/device-plugin"]
