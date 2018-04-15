FROM nes-emulators-dev
#FROM ubuntu:16.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y \
    && apt-get install -y software-properties-common python-software-properties python3-software-properties sudo \
    && apt-get install -y \
        xterm \
        pulseaudio \
        curl \
        libgconf2-4 \
        iputils-ping \
        libnss3-1d \
        libxss1 \
        wget \
        xdg-utils \
        libpango1.0-0 \
        fonts-liberation \
        git \
        vim \
        i3 \
	docker.io \
	libxft-dev \
        rxvt-unicode \
        terminator \
        firefox \
        flashplugin-installer \
        man \
    && apt-get clean -y \
    && apt-get autoclean -y \
    && apt-get auto-remove -y 

COPY i3config /tmp/onyx/.config/i3/config
COPY inconsolata-g.ttf /tmp/onyx/custom_fonts/inconsolata-g.ttf
# nomachine_5.3.9_6_amd64.deb
COPY nomachine.deb /tmp/nomachine.deb

RUN ln -s /tmp/onyx /usr/share/fonts/fontfiles \
    && fc-cache -fv

# Install nomachine, change password and username to whatever you want here
# Goto https://www.nomachine.com/download/download&id=10 and change for the latest NOMACHINE_PACKAGE_NAME and MD5 shown in that link to get the latest version.
ENV NOMACHINE_MD5 050eadd9f037e31981c7e138bfcfbe80
RUN echo "${NOMACHINE_MD5} */tmp/nomachine.deb" | md5sum -c - \
    && dpkg -i /tmp/nomachine.deb

ADD nxserver.sh /

# Suckless terminal. libxft-dev was already installed above.
COPY st-patched /tmp/st-patched
RUN cd /tmp/st-patched && make install

# i3 related.
COPY i3config /home/user/.config/i3/config 

ENTRYPOINT ["/nxserver.sh"]
