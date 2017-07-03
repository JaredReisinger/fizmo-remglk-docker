IMAGE_TAG := fizmo-remglk:test


image:
	docker build -t ${IMAGE_TAG} .
.PHONY: image

shell:
	docker run \
		--rm \
		--interactive \
		--tty \
		--volume "${GAMES_DIR}":/usr/local/games \
		${IMAGE_TAG} \
		/bin/sh
