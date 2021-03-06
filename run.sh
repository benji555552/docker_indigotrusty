#!/usr/bin/env bash

# Check args
if [ "$#" -ne 1 ]; then
  echo "usage: ./run.sh IMAGE_NAME"
  return 1
fi

# Get this script's path
pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd`
popd > /dev/null

set -e

# Run the container with shared X11
nvidia-docker run --privileged \
  --net=host\
  --env "DISPLAY" \
  --env="QT_X11_NO_MITSHM=1" \
  -v /dev/video0:/dev/video0 \
  -e SHELL\
  -e DOCKER=1\
  -v "$HOME:$HOME:rw"\
  -v "/tmp/.X11-unix:/tmp/.X11-unix:rw"\
  -it $1 $SHELL
