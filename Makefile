IMAGE_NAME    := jaredreisinger/fizmo-remglk
IMAGE_VERSION := 0.1

.DEFAULT_GOAL := image

image:
	docker build \
		-t ${IMAGE_NAME}:${IMAGE_VERSION} \
		-t ${IMAGE_NAME}:latest \
		.
.PHONY: image

shell:
	docker run \
		--rm \
		--interactive \
		--tty \
		${IMAGE_NAME}:latest \
		/bin/sh

	@#	--volume "${GAMES_DIR}":/usr/local/games \
