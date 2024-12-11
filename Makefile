# Load environment variables from .env file
ifneq (,$(wildcard ./.env))
    include .env
    export
endif


run: build
	@./bin/hsmda

build:
	@go build -o bin/hsmda main.go

test:
	@go test -v ./...

mongo:
	@docker start mongo

db-down:
	@GOOSE_DRIVER=$(DB_DRIVER) GOOSE_DBSTRING=$(DB_NAME) go run github.com/pressly/goose/v3/cmd/goose@latest -dir=$(MIGRATION_DIR) down

db-up:
	@GOOSE_DRIVER=$(DB_DRIVER) GOOSE_DBSTRING=$(DB_NAME) go run github.com/pressly/goose/v3/cmd/goose@latest -dir=$(MIGRATION_DIR) up

