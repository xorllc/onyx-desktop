FROM debian:stretch
MAINTAINER Brian Hamilton <brian@abc.123>

#########################################
##        ENVIRONMENTAL CONFIG         ##
#########################################
# Set correct environment variables
ENV HOME="/root" LC_ALL="C.UTF-8" LANG="en_US.UTF-8" LANGUAGE="en_US.UTF-8" TERM="xterm" USER_ID=99 GROUP_ID=100 APP_NAME=i3

COPY sources.list /etc/apt/sources.list

RUN \
      apt-get update && apt-get -y upgrade && \
      apt-get install -y build-essential dpkg-dev && \
      apt-get install -y pulseaudio && \
      apt-get build-dep -y pulseaudio && \
      apt-get source -y pulseaudio

COPY xrdp/ /root/xrdp/
RUN \
      cd pulseaudio-10.0 && \
      ./configure && \
      cd /root/xrdp/sesman/chansrv/pulse && \
      make PULSE_DIR="/root/pulseaudio-10.0"

#########################################
##          GUI APP INSTALL            ##
#########################################
#ENV DEBIAN_FRONTEND noninteractive
## Install steps for X app
#RUN \
#  add-apt-repository ppa:nilarimogard/webupd8 && \
#  apt-get update && \
#  apt-get upgrade -y && \
#  apt-get -yy install \ 
#  xfce4 \
#  xfce4-terminal \
#  rm -rf /var/cache/apk/* && \
#  apt-get -yy purge xscreensaver && \
#  sed -i -e 's/\/usr\/bin\/openbox-session/dbus-launch \/usr\/bin\/xfce4-session/' /etc/service/openbox/run && \
#  rm -rf /etc/service/xclipboard/run
#
#WORKDIR /nobody
#
## Use baseimage-docker's init system
#CMD ["/sbin/my_init"]
