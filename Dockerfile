FROM alpine:latest

LABEL maintainer="jaredreisinger@hotmail.com" \
    remglk.version="0.2.6" \
    libfizmo.version="0.7.14" \
    libglkif.version="0.2.3" \
    fizmo-remglk.version="0.1.2"

RUN apk add --no-cache ca-certificates

RUN set -eux; \
    echo "acquire tools..."; \
	apk add --no-cache --virtual .build-deps \
        autoconf \
        automake \
        gcc \
        git \
        make \
        musl-dev \
	; \
    # libxml2-dev is separate, because the shared library needs to stick
    # around for running fizmo-remglk.
    apk add --no-cache \
        libxml2-dev \
    ; \
    echo "acquire sources..."; \
    mkdir -p /tmp; \
    cd /tmp; \
    # wget -O libxml2-2.9.4.tar.gz ftp://xmlsoft.org/libxml2/libxml2-2.9.4.tar.gz; \
    # echo "ffb911191e509b966deb55de705387f14156e1a56b21824357cdf0053233633c *libxml2-2.9.4.tar.gz" | sha256sum -c -; \
    # tar -xf libxml2-2.9.4.tar.gz; \
    # TODO: use tags/releases to get specific versions?
    git clone https://github.com/erkyrath/remglk; \
    git clone https://github.com/chrender/libfizmo.git; \
    git clone https://github.com/chrender/libglkif.git; \
    git clone https://github.com/chrender/fizmo-remglk.git; \
    # echo "apply patches..."; \
    echo "build..."; \
    # echo "============================================================"; \
    # echo "libxml2"; \
    # echo "============================================================"; \
    # cd /tmp/libxml2-2.9.4; \
    # ./configure --enable-static --disable-shared --without-zlib --without-lzma; \
    # make install; \
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
    autoreconf --force --install; \
    ./configure; \
    make install-dev; \
    echo "============================================================"; \
    echo "libglkif"; \
    echo "============================================================"; \
    cd /tmp/libglkif; \
    autoreconf --force --install; \
    ./configure; \
    make install-dev; \
    echo "============================================================"; \
    echo "fizmo-remglk"; \
    echo "============================================================"; \
    cd /tmp/fizmo-remglk; \
    autoreconf --force --install; \
    ./configure; \
    # ./configure LDFLAGS=-static; \
    make install; \
    echo "============================================================"; \
    echo "cleanup"; \
    echo "============================================================"; \
    cd /tmp; \
    echo "remove patches/build files..."; \
    apk del .build-deps; \
    rm -rf /tmp/*; \
    echo "set up games directory"; \
    mkdir -p /usr/local/games; \
    echo "DONE"

COPY play /usr/local/bin/.

VOLUME /usr/local/games
WORKDIR /usr/local/games
