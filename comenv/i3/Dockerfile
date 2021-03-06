FROM ubuntu:16.04
# FROM ubuntu:18.04 will work when using SSH or mounting devices/x11/audio, but nomachine will not work.
# Simply changing the FROM to ubuntu:18.04 will cause nomachine to stop working properly when opening terminals.

# https://github.com/docker/docker/blob/master/project/PACKAGERS.md#runtime-dependencies

RUN \
        export http_proxy=$proxy \
    &&  export https_proxy=$http_proxy \
    &&  apt-get update -y \
    &&  apt-get upgrade -y \
    &&  apt-get install -y \
        software-properties-common \
        python3-software-properties

RUN \
        export http_proxy=$proxy \
    &&  export https_proxy=$http_proxy \
    &&  add-apt-repository universe \
    &&  add-apt-repository multiverse \
    &&  dpkg --configure -a \
    &&  apt-get update -y \
    &&  apt-get upgrade -y \
    &&  apt-get install -y \
        openssh-client \
        openssh-server \
        cups \
        libgconf2-4 \
        iputils-ping \
        libxss1 \
        xdg-utils \
        libpango1.0-0 \
        fonts-liberation \
        flashplugin-installer \
        zsh \
        sudo \
        higan \
        fceux \
        curl \
        wget \
        xdg-utils \
        libpango1.0-0 \
        fonts-liberation \
        vim \
        tmux \
        supervisor \
        openbox \
        obconf \
        docker.io \
        libxft-dev \
        terminator \
        man \
        git \
        clang \
        scons \
        libsdl2-dev \
        libsdl2-image-dev \
        libsdl2-ttf-dev \
        libsdl1.2-dev \
        libboost-all-dev \
        alsa-base \
        alsa-utils \
        pulseaudio \
        dbus-x11 \
    && apt-get clean -y \
    && apt-get autoclean -y \
    && apt-get auto-remove -y 

ARG version
ARG proxy
ARG email
ARG username
ARG password

LABEL Name="$username" Version="$version" \
      Maintainer="$email"

ENV DEBIAN_FRONTEND=noninteractive

# SSH and NX.
EXPOSE 22
EXPOSE 4000

# Copy the files into the right places.
COPY cbin/ /cbin/

# Setup Developer Environment
RUN \
       addgroup dev \
    && echo '%dev ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
    && useradd -m -s /usr/local/bin/xonsh -g dev devusr \
    && echo "devusr:$password" | /usr/sbin/chpasswd \
    && apt-get install python3-pip -y
RUN \
       pip3 install \
        flask \
        connexion \
        xonsh \
    && chmod -R +x /cbin

WORKDIR /home/devusr
RUN \
       mkdir /data \
    && chmod 777 /data \
    && ln -s /data /home/devusr/work \
    && cd /home/devusr \
    && mkdir .ssh \
    && chown devusr.dev .ssh \
    && chmod 700 .ssh \
    && chown -R devusr.dev /home/devusr

COPY etc/motd /etc/motd
COPY etc/supervisor /etc/supervisor
COPY devusr /home/devusr/
COPY readmes /home/devusr/readmes
USER root
RUN \
       chown -R devusr /home/devusr \
    && chmod o+w /home/devusr \
    && ln -fsv $(which vim) $(which vi) \
    && sed -i s%SED_PROXY%$proxy% /home/devusr/.xonshrc \
    && sed -i s%SED_NAME%$username% /home/devusr/.gitconfig \
    && sed -i s%SED_EMAIL%$email% /home/devusr/.gitconfig \
    && sed -i s%SED_EMAIL%$email% /home/devusr/.xonshrc

# Force user back to root so s6 can run initd processes
ENTRYPOINT ["/init", "/cbin/exec-cmd"]

# Font related.
COPY inconsolata-g.ttf /tmp/onyx/custom_fonts/inconsolata-g.ttf
RUN ln -s /tmp/onyx /usr/share/fonts/fontfiles \
    && fc-cache -fv

# Install nomachine, change password and username to whatever you want here
# Goto https://www.nomachine.com/download/download&id=10 and change for the latest NOMACHINE_PACKAGE_NAME and MD5 shown in that link to get the latest version.
# nomachine_5.3.9_6_amd64.deb
COPY nomachine.deb /tmp/nomachine.deb
ENV NOMACHINE_MD5 050eadd9f037e31981c7e138bfcfbe80
RUN echo "${NOMACHINE_MD5} */tmp/nomachine.deb" | md5sum -c - \
    && dpkg -i /tmp/nomachine.deb

ADD nxserver.sh /opt/nxserver.sh

# Suckless terminal. libxft-dev was already installed above.
COPY st /tmp/suckless/st
RUN cd /tmp/suckless/st/st-patched && make install

# i3 related.
COPY i3config /home/user/.config/i3/config 

# NES emulator related.
COPY /emulators/nes/ /opt/emulators/nes/
RUN \
       cd /opt/emulators/nes/cpp/LaiNES \
    && scons \
    && cd /opt/emulators/nes/cpp/bjne \
    && scons

COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN mkdir -p /run/sshd
COPY nx_node.cfg /usr/NX/etc/node.cfg
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
ENTRYPOINT ["supervisord"]
