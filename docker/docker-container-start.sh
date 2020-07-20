# start dind
. $BASEDIR/docker/docker-container-dind-start.sh

# start container if not yet
container_all=$(docker ps -aq --filter "name=${APP_NAME}")
container_started=$(docker ps -q --filter "name=${APP_NAME}")
if [ -z "${container_all}" ]; then
  log "Container ${APP_NAME} not yet run. Build now.."
  cd $BASEDIR
  docker run ${DOCKER_RUN_OPT} ${DOCKER_RM_OPT} --name ${APP_NAME} ${VOLUME_MOUNT} ${PORT_MAPPING} ${APP_NAME} ${CMD}
elif [ -z "${container_started}" ]; then
  log "Container ${APP_NAME} stopped. Start now.."
  docker start ${APP_NAME}
fi
