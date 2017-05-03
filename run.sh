#!/bin/bash
robot=$1

# WARNING: this is hyper-insecure and lazy
xhost local:root

docker run --rm \
  -e DISPLAY=unix$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -it \
  christimperley/robots:${robot} \
  /bin/bash
