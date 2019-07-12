# build docker image if not yet
img_built=$(docker images | grep ${APP_NAME})
if [ -z "${img_built}" ] || [ ! -z "${ENFORCE_IMAGE_BUILD}" ]; then
  log "Image ${APP_NAME} not yet built or enforced to be built. Build now.."
  cd $BASEDIR
  docker build . -t ${APP_NAME} -f $BASEDIR/docker/Dockerfile
else
  log "Image ${APP_NAME} already exists. No need to build"
fi
