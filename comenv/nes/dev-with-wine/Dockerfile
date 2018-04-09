FROM ubuntu:16.04

ENV DEBIAN_FRONTEND=noninteractive

# BJNE
RUN mkdir -p /opt/git
WORKDIR /opt/git
RUN dpkg --add-architecture i386 \
    && apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y software-properties-common \
    && apt-get install -y higan wine \
    && apt-get clean -y \
    && apt-get autoclean -y \
    && apt-get auto-remove -y 
