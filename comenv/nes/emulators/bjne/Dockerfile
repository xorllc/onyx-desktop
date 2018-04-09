FROM ubuntu:16.04

ENV DEBIAN_FRONTEND=noninteractive

# BJNE
RUN apt-get update -y \
    && apt-get install -y software-properties-common \
    && apt-get install -y \
        git \
        clang \
        scons \
        libsdl2-dev \
        libsdl2-image-dev \
        libsdl2-ttf-dev \
        libsdl1.2-dev \
        libboost-all-dev \
    && apt-get clean -y \
    && apt-get autoclean -y \
    && apt-get auto-remove -y 

RUN mkdir -p /opt/git
WORKDIR /opt/git
RUN git clone --recursive https://github.com/taotao54321/bjne.git \
    && cd bjne \
    && scons
