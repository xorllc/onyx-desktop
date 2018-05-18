#!/bin/bash

IMAGE=nx-ssh

docker rm -f nx-ssh
docker run -d \
  -p 4001:4000 \
  -p 2222:22 \
  --name nx-ssh \
  -e PASSWORD=zaksab37 \
  -e USER=user \
  -v /var/run/docker.sock:/var/run/docker.sock \
  --cap-add=SYS_PTRACE \
  --cap-add=NET_ADMIN \
  ${IMAGE}
