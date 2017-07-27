FROM ubuntu:16.04

ENV DEBIAN_FRONTEND=noninteractive

# LaiNES
RUN apt-get update -y \
    && apt-get install -y software-properties-common \
    && apt-get install -y \
        git \
        clang \
        scons \
        libsdl2-dev \
        libsdl2-image-dev \
        libsdl2-ttf-dev

RUN mkdir -p /opt/git
WORKDIR /opt/git
RUN git clone --recursive https://github.com/AndreaOrru/LaiNES \
    && cd LaiNES \
    && scons
