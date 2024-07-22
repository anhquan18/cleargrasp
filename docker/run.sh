#!/usr/bin/env bash

USERNAME=user

docker run -it --rm \
    --gpus all \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --volume="$PWD:/home/$USERNAME/workspace" \
    --workdir="/home/$USERNAME/workspace" \
    --user=$USERNAME \
    --shm-size=2g \
    --privileged -v /dev/bus/usb:/dev/bus/usb \
    cleargrasp_cuda10 bash
