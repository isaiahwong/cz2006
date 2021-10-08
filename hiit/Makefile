$(shell PATH=$PATH:$GOPATH/bin)
BUILD_ID := $(shell git rev-parse --short HEAD 2>/dev/null || echo no-commit-id)
IMAGE_NAME := isaiahwong/twozerozerosix-hiit_relay
VERSION := 0.0.1

PROTO_DIR := ../../pb

.DEFAULT_GOAL := help

help: ## List targets & descriptions
	@cat Makefile* | grep -E '^[a-zA-Z_-]+:.*?## .*$$' | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build:
	docker build -t $(IMAGE_NAME):latest . --rm=true

build-sha:
	docker build -t $(IMAGE_NAME):$(BUILD_ID) . --rm=true

push:
	docker push $(IMAGE_NAME):latest

push-sha:
	docker push $(IMAGE_NAME):$(BUILD_ID)

build-all:
	docker build -t $(IMAGE_NAME):latest -t $(IMAGE_NAME):$(BUILD_ID) . --rm=true

push-all:
	make push
	make push-sha

build-push:
	make build-all
	make push-all

clean:
	docker rmi $( docker images | grep '<none>') --force 2>/dev/null

set-image:
	kubectl set image deployments/hiit-deployment hiit=$(IMAGE_NAME)

set-image-latest:
	kubectl set image deployments/hiit-deployment hiit=$(IMAGE_NAME):latest

set-image-sha:
	kubectl set image deployments/hiit-deployment hiit=$(IMAGE_NAME):${BUILD_ID}

run:
	docker run -p 50051:50051 -it $(IMAGE_NAME)

