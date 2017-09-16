#!/bin/bash

IMAGE=i3-bjne

docker run -d \
  -p 4000:4000 \
  --name desk3 \
  -e PASSWORD=password \
  -e USER=user \
  --cap-add=SYS_PTRACE \
  --cap-add=NET_ADMIN \
  ${IMAGE}
