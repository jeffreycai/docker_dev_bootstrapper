# end container if not yet
container_started=$(docker ps | grep ${APP_NAME})
if [ ! -z "${container_started}" ]; then
  log "Stop container ${APP_NAME}"
  docker stop ${APP_NAME}
else
  log "Container not started. Skip"
fi