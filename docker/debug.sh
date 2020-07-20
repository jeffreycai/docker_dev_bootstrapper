#!/bin/bash

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BASEDIR=${BASEDIR}/..

. $BASEDIR/docker/config.sh
. $BASEDIR/docker/functions.sh

# build container if not yet
. $BASEDIR/docker/docker-image-build.sh

# start dind
. $BASEDIR/docker/docker-container-dind-start.sh

# start interactive seesion
CMD="/bin/bash"
DOCKER_RUN_OPT="$DOCKER_RUN_OPT -it"

container_all=$(docker ps -aq --filter "name=${APP_NAME}")
container_started=$(docker ps -q --filter "name=${APP_NAME}")
if [ -z "${container_all}" ]; then
  log "Container ${APP_NAME} not yet run. Build now.."
  cd $BASEDIR
  docker run ${DOCKER_RUN_OPT} ${DOCKER_RM_OPT} --name ${APP_NAME} ${VOLUME_MOUNT} ${PORT_MAPPING} ${APP_NAME} ${CMD}
elif [ -z "${container_started}" ]; then
  log "Container ${APP_NAME} stopped. Start now.."
  docker start ${APP_NAME}
  # check again to see if container is up 
  container_started=$(docker ps | grep ${APP_NAME})
  # if not, run -it /bin/bash directly
  if [ -z "${container_started}" ]; then
    docker run ${DOCKER_RUN_OPT} ${DOCKER_RM_OPT} --name ${APP_NAME} ${VOLUME_MOUNT} ${PORT_MAPPING} ${APP_NAME} ${CMD}
  fi
else
  log "Container ${APP_NAME} running, Attach"
  docker exec -it ${APP_NAME} /bin/bash
fi


