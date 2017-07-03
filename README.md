# fizmo-remglk-docker

Play interactive fiction games via fizmo's remote Glk front-end.


## Usage

The expectation is that this will be used as a base for tools which know how to
interact with the remote-Glk, JSON stdin/stdout interface.  Those consumers of
this image can provide games files in any way they see fit; the
`/usr/local/games` directory is provided (and is the default working directory)
only for convenience and testing.

For testing, you might want to use this image directly:

```sh
docker run --rm \
    --interactive \
    --tty \
    --volume PATH/TO/GAMES:/usr/local/games \
    fizmo-remglk:latest play name-of-game.z5
```

The `play` helper script (at `/usr/local/bin/play`) exists purely to make
manual, ad-hoc testing easier.  It is expected that actual programmatic use of
`fizmo-remglk` will call it directly.


## Other Notes

All of the work to acquire and build the binaries are performed inside the
Dockerfile specification itself.

This is pre-release, and a work in progress.  The current Dockerfile leaves a
lot of build-time resources, because I'm still working on things.
