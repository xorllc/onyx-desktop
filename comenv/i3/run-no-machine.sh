#!/bin/bash

IMAGE=nes-emu-dev-i3

docker run -d \
  -p 4000:4000 \
  --name desk3 \
  -e PASSWORD=zaksab37 \
  -e USER=user \
  -v /var/run/docker.sock:/var/run/docker.sock \
  --cap-add=SYS_PTRACE \
  --cap-add=NET_ADMIN \
  ${IMAGE}
