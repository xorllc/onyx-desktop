FROM phusion/baseimage:0.9.16
MAINTAINER Brian Hamilton <brian@abc.123>

#########################################
##        ENVIRONMENTAL CONFIG         ##
#########################################
# Set correct environment variables
ENV HOME="/root" LC_ALL="C.UTF-8" LANG="en_US.UTF-8" LANGUAGE="en_US.UTF-8" TERM="xterm" USER_ID=99 GROUP_ID=100 APP_NAME=i3

# Default resolution, change if you like
ENV WIDTH=1920
ENV HEIGHT=1080


# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

#########################################
##    REPOSITORIES AND DEPENDENCIES    ##
#########################################

RUN add-apt-repository ppa:nilarimogard/webupd8
RUN apt-get update -y && apt-get upgrade -y

#########################################
##         RUN INSTALL SCRIPT          ##
#########################################
COPY ./files/ /tmp/
RUN /tmp/install/install.sh && rm -r /tmp/install

#########################################
##          GUI APP INSTALL            ##
#########################################
ENV DEBIAN_FRONTEND noninteractive
# Install steps for X app
RUN \
  apt-get update && \
  apt-get upgrade -y && \
  apt-get -yy install \ 
  xfce4 \
  xfce4-terminal \
  browser-plugin-freshplayer-pepperflash \
  firefox \
  xfce4-artwork \
  xfce4-mixer \
  xfce4-radio-plugin \
  xfce4-volumed mplayer \
  gstreamer0.10-pulseaudio \
  gnome-mplayer \
  vlc \
  vlc-plugin-pulse \
  pulseaudio-equalizer \
  audacious \
  audacious-plugins \
  gnome-icon-theme-full && \
  rm -rf /var/cache/apk/*

# Make sure there is no cpu waisting screensaver
RUN apt-get -yy purge xscreensaver
RUN sed -i -e 's/\/usr\/bin\/openbox-session/dbus-launch \/usr\/bin\/xfce4-session/' /etc/service/openbox/run
RUN rm -rf /etc/service/xclipboard/run

WORKDIR /nobody
