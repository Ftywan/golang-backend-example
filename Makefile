test:
	@go test -v ./...

run:
	@go run main.go

build:
	@go build -o github.com/Ftywan/golang-backend-example main.go

docker:
	@docker build -t backend .

docker-compose:
	@docker-compose up -d

docker-push:
	@docker push Ftywan/github.com/oniharnantyo/golang-backend-example