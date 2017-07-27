#!/bin/bash

IMAGE=i3

docker run -d \
  -p 4000:4000 \
  --name desk2 \
  -e PASSWORD=password \
  -e USER=user \
  --cap-add=SYS_PTRACE \
  --cap-add=NET_ADMIN \
  ${IMAGE}
