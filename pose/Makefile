$(shell PATH=$PATH:$GOPATH/bin)
BUILD_ID := $(shell git rev-parse --short HEAD 2>/dev/null || echo no-commit-id)
IMAGE_NAME := isaiahwong/twozerozerosix-pose_rtc
VERSION := 0.0.1

build:
	docker build -t $(IMAGE_NAME):latest . --rm=true

build-sha:
	docker build -t $(IMAGE_NAME):$(BUILD_ID) . --rm=true

push:
	docker push $(IMAGE_NAME):latest


run:
	docker run -p 8080:8080 -it $(IMAGE_NAME)

