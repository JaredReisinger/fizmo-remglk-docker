FROM alpine:latest

LABEL maintainer="jaredreisinger@hotmail.com" \
    remglk-version="0.2.6" \
    libfizmo-version="0.7.14" \
    libglkif-version="0.2.3" \
    fizmo-remglk-version="0.1.2"

RUN apk add --no-cache ca-certificates

# COPY patches, if needed...

RUN set -eux; \
    echo "acquire tools..."; \
	apk add --no-cache --virtual .build-deps \
		# bash \
        musl-dev \
        libxml2-dev \
		gcc \
        make \
        autoconf \
        automake \
        git \
	; \
    echo "acquire sources..."; \
    mkdir -p /tmp; \
    cd /tmp; \
    # TODO: use tags/releases to get specific versions?
    git clone https://github.com/erkyrath/remglk; \
    git clone https://github.com/chrender/libfizmo.git; \
    git clone https://github.com/chrender/libglkif.git; \
    git clone https://github.com/chrender/fizmo-remglk.git; \
    # echo "apply patches..."; \
    echo "build..."; \
    echo "============================================================"; \
    echo "remglk"; \
    echo "============================================================"; \
    cd /tmp/remglk; \
    make; \
    cp lib*.a /usr/local/lib/.; \
    mkdir -p /usr/local/include; \
    cp *.h /usr/local/include/.; \
    echo "============================================================"; \
    echo "libfizmo"; \
    echo "============================================================"; \
    cd /tmp/libfizmo; \
    autoreconf --verbose --force --install; \
    ./configure; \
    make install-dev; \
    echo "============================================================"; \
    echo "libglkif"; \
    echo "============================================================"; \
    cd /tmp/libglkif; \
    autoreconf --verbose --force --install; \
    ./configure; \
    make install-dev; \
    echo "============================================================"; \
    echo "fizmo-remglk"; \
    echo "============================================================"; \
    cd /tmp/fizmo-remglk; \
    autoreconf --verbose --force --install; \
    ./configure; \
    make install; \
    echo "============================================================"; \
    echo "cleanup"; \
    echo "============================================================"; \
    cd /tmp; \
    echo "remove patches/build files..."; \
    # apk del .build-deps; \
    rm -rf /tmp/*; \
    echo "set up games directory"; \
    mkdir -p /usr/local/games; \
    echo "DONE"

COPY play /usr/local/bin/.

VOLUME /usr/local/games
WORKDIR /usr/local/games

# ENTRYPOINT [
#     "/usr/local/bin/fizmo-remglk",
#     "-fixmetrics",
#     "-width", "80",
#     "-height", "50"
# ]
