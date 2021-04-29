# FROM alpine as OS
# RUN 
# COPY . /usr/local/go/src/main
# WORKDIR /usr/local/go/src/main
# ENTRYPOINT go run main

FROM golang:alpine as builder
WORKDIR /usr/local/go/src/main
COPY main.go .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

FROM scratch
# RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=0 /usr/local/go/src/main .
CMD ["./main"]  