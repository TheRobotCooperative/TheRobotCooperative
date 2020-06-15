#!/bin/sh

XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth

docker run -P\
        -it --rm \
        -v $XSOCK:$XSOCK:rw \
        -v $XAUTH:$XAUTH:rw \
        --env XAUTHORITY=${XAUTH} \
        --env DISPLAY=${DISPLAY} \
        -u autoware \
        autoware-image \
        bash
