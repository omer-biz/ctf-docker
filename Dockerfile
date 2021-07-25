# sudo docker build -t ctf_docker
# sudo docker run -d --rm -v $PWD:/root/shared --cap-add=SYS_PTRACE \
#     --security-opt seccomp=unconfined -i ctf_docker

FROM ubuntu:20.04
ENV LC_CTYPE C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive
ENV EDITOR=vim

# Setting the root user
RUN usermod -d /root -m -s /bin/bash root
RUN mkdir -p /root/shared
WORKDIR /root

# Installing Packages
RUN apt-get update && \
    apt-get install -y tmux build-essential strace ltrace curl wget curl \
    gcc netcat gcc-multilib net-tools vim gdb gdb-multiarch python3 \
    python3-pip git make vim && \
    pip install pwntools ropper

# Configuring Packages
RUN wget -O /root/.tmux.conf -q \
    https://raw.githubusercontent.com/omer-biz/dotfiles/master/tmux/.tmux.conf

RUN wget -O /root/.gdbinit -q \
    https://raw.githubusercontent.com/omer-biz/dotfiles/master/gdb/.gdbinit

RUN wget -O /root/.gdbinit-gef.py -q http://gef.blah.cat/py
RUN sed -i '/\/home\/omer/c\source \/root\/.gdbinit-gef.py' .gdbinit

RUN ln -s /usr/bin/python3 /usr/bin/python
