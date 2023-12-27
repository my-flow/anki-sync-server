DOCKER_USERNAME ?= myflow
IMAGE_NAME ?= anki-sync-server
SHA ?= $(shell git log --format="%h" -n 1)
 
.PHONY: build test guard-% lint

include .env

build: --guard-ANKI_VERSION lint
	docker buildx build context/ \
		--build-arg ANKI_VERSION=${ANKI_VERSION} \
		--build-arg HEALTHCHECK_PATH=${HEALTHCHECK_PATH} \
		--build-arg SYNC_PORT=${SYNC_PORT} \
		--no-cache \
		--platform linux/amd64,linux/arm64 \
		--push \
		--tag ${DOCKER_USERNAME}/${IMAGE_NAME}:${ANKI_VERSION} \
		--tag ${DOCKER_USERNAME}/${IMAGE_NAME}:${SHA}

test: --guard-ANKI_VERSION lint
	docker buildx build context/ \
		--build-arg ANKI_VERSION=${ANKI_VERSION} \
		--build-arg HEALTHCHECK_PATH=${HEALTHCHECK_PATH} \
		--build-arg SYNC_PORT=${SYNC_PORT} \
		--platform linux/amd64,linux/arm64

lint:
	hadolint context/Dockerfile

--guard-%:
	@ if [ "${${*}}" = "" ]; then \
			echo "Environment variable $* not set"; \
			exit 1; \
	fi
