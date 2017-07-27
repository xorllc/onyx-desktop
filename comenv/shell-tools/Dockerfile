FROM i3
#FROM ubuntu:16.04

RUN apt-get update -y \
    && apt-get install -y git vim wget curl

COPY fzf /root/.fzf
COPY grb/dotfiles/.vimrc /root/.vimrc
COPY grb/dotfiles/.vim /root/.vim
COPY plug.vim /root/.vim/autoload/plug.vim

RUN /root/.fzf/install
