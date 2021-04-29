FROM golang:alpine
WORKDIR /usr/local/go/src/main
COPY main.go .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

FROM scratch
WORKDIR /root/
COPY --from=0 /usr/local/go/src/main .
CMD ["./main"]  