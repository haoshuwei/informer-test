FROM docker.io/library/golang:1.19.4 as builder

WORKDIR /go/src/github.com/haoshuwei/informer-test

COPY . .
RUN go mod tidy
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o informer main.go

FROM docker.io/library/alpine:3.13.2

WORKDIR /
COPY --from=builder /go/src/github.com/haoshuwei/informer-test/informer /usr/local/bin/informer