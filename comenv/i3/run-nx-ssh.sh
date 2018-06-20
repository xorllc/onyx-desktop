#!/bin/bash

IMAGE=nx-ssh
xhost +"local:docker@"

docker rm -f nx-ssh
docker run -d \
  -p 2222:22 \
  --name nx-ssh \
  --group-add $(getent group audio | cut -d: -f3) \
  -e DISPLAY \
  -e PULSE_SERVER=unix:${XDG_RUNTIME_DIR}/pulse/native \
  -e ${XAUTHORITY}:/root/.Xauthority \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v ${XDG_RUNTIME_DIR}/pulse/native:${XDG_RUNTIME_DIR}/pulse/native:Z \
  -v ${XAUTHORITY}:/root/.Xauthority \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  --shm-size=2g \
  --device /dev/dri \
  --device /dev/snd \
  --device /dev/input \
  --cap-add=SYS_PTRACE \
  --cap-add=NET_ADMIN \
  ${IMAGE}
