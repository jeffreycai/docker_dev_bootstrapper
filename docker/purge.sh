#!/bin/bash

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BASEDIR=${BASEDIR}/..

. $BASEDIR/docker/config.sh
. $BASEDIR/docker/functions.sh

# stop container first
header "Stop container ${APP_NAME}"
. $BASEDIR/docker/docker-container-stop.sh

# rm container
header "Delete container ${APP_NAME}"
container_all=$(docker ps -a | grep ${APP_NAME})
container_started=$(docker ps | grep ${APP_NAME})
if [ ! -z "${container_all}" ]; then
  docker rm ${APP_NAME}
else
  log "Container does not exist. Skip"
fi

# rm image
header "Delete image ${APP_NAME}"
img_built=$(docker images | grep ${APP_NAME} | awk '{print $3}')
if [ ! -z "${img_built}" ]; then
  log "Delete image ${APP_NAME}"
  docker image rm ${img_built}
else
  log "Image does not exist. Skip"
fi
