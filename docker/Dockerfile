FROM frolvlad/alpine-glibc:alpine-3.12
# we use frolvlad alpine as awscli2 does not work with original alpine
# Alpine GNU C library (glibc)

## Arguments
ARG ROOT="/opt/app"
ARG TERRAFORM_VERSION="0.12.28"
ARG ANSIBLE_VERSION="2.9.10"

## general system packages
RUN apk update
RUN apk add vim git bash bash-doc bash-completion curl zip busybox-extras curl gcc \
    findutils grep musl-dev libffi-dev openssl-dev openssh

## misellaneous config files
RUN ln -sf ${ROOT}/docker/files/config_files/gitconfig /root/.gitconfig
RUN ln -sf ${ROOT}/docker/files/config_files/gitignore_global /root/.gitignore_global
RUN ln -sf ${ROOT}/docker/files/config_files/vimrc /root/.vimrc
RUN ln -sf ${ROOT}/docker/files/config_files/bashrc /root/.bashrc

## python3
RUN apk add python3 py-pip python3-dev
RUN pip3 install ansible==${ANSIBLE_VERSION}

## python2
RUN apk add python2 python2-dev
COPY docker/files/get-pip.py /tmp
RUN python /tmp/get-pip.py

## ssh
RUN mkdir -p /root/.ssh
COPY docker/files/config_files/id_rsa /root/.ssh
COPY docker/files/config_files/id_rsa.pub /root/.ssh
RUN ansible-vault decrypt /root/.ssh/id_rsa --vault-password-file ${ROOT}/docker/files/password.txt
RUN chmod 0400 /root/.ssh/id_rsa
RUN ln -sf ${ROOT}/docker/files/config_files/authorized_keys /root/.ssh

## aws
COPY docker/files/awscli-exe-linux-x86_64.zip /tmp/awscli-exe-linux-x86_64.zip
WORKDIR /tmp
RUN unzip awscli-exe-linux-x86_64.zip
RUN ./aws/install

## terraform
COPY docker/files/terraform-swither-install.sh /tmp
RUN sh /tmp/terraform-swither-install.sh
RUN tfswitch ${TERRAFORM_VERSION}

## clean up
RUN rm -rf /tmp/*

## volumes
VOLUME [ "${ROOT}" ]

## workdir
WORKDIR /opt/app
