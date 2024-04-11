FROM golang:alpine

RUN apk update && apk add --no-cache gcc musl-dev

WORKDIR /github.com/Ftywan/golang-backend-example

COPY . .

RUN go build -o run

CMD ["/github.com/Ftywan/golang-backend-example/run"]