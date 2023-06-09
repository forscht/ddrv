FROM golang:1.20 AS build

WORKDIR /app

COPY go.* ./
RUN go mod download

COPY . .

RUN make build-docker

FROM scratch

COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

WORKDIR /app

COPY --from=build /app/ddrv /app/ddrv

ENTRYPOINT ["/app/ddrv"]