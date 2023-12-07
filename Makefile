DOCKER_USERNAME ?= myflow
IMAGE_NAME ?= anki-sync-server
GIT_HASH ?= $(shell git log --format="%h" -n 1)
 
.PHONY: build guard-% lint

include .env

build: --guard-ANKI_VERSION lint
	docker buildx build context/ \
		--build-arg ANKI_VERSION=${ANKI_VERSION} \
		--build-arg SYNC_BASE=${SYNC_BASE} \
		--build-arg SYNC_PORT=${SYNC_PORT} \
		--no-cache \
		--platform linux/386,linux/amd64,linux/arm64 \
		--push \
		--tag ${DOCKER_USERNAME}/${IMAGE_NAME}:${ANKI_VERSION} \
		--tag ${DOCKER_USERNAME}/${IMAGE_NAME}:${GIT_HASH}

lint:
	hadolint context/Dockerfile

--guard-%:
	@ if [ "${${*}}" = "" ]; then \
			echo "Environment variable $* not set"; \
			exit 1; \
	fi
