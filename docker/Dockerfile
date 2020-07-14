FROM frolvlad/alpine-glibc:alpine-3.12
# we use frolvlad alpine as awscli2 does not work with original alpine
# Alpine GNU C library (glibc)

## Arguments
ARG ROOT="/opt/app"
ARG TERRAFORM_VERSION="0.12.28"

## general system packages
RUN apk update
RUN apk add vim git bash curl zip busybox-extras

## misellaneous config files
RUN ln -sf ${ROOT}/docker/files/config_files/gitconfig /root/.gitconfig
RUN ln -sf ${ROOT}/docker/files/config_files/gitignore_global /root/.gitignore_global
RUN ln -sf ${ROOT}/docker/files/config_files/vimrc /root/.vimrc
RUN ln -sf ${ROOT}/docker/files/config_files/bashrc /root/.bashrc

## python3
RUN apk add python3 py-pip

## python2
RUN apk add python2
COPY docker/files/get-pip.py /tmp
RUN python /tmp/get-pip.py

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
