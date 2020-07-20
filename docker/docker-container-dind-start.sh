# start dind if not yet
container_all=$(docker ps -aq --filter "name=docker")
container_started=$(docker ps -q --filter "name=docker")
if [ -z "${container_all}" ]; then
  log "Container docker not yet run. Run now.."
  cd $BASEDIR
  docker run --privileged --name docker -d \
      -e DOCKER_TLS_CERTDIR=/certs \
      -v dind-certs-ca:/certs/ca \
      -v dind-certs-client:/certs/client \
      docker:dind
elif [ -z "${container_started}" ]; then
  log "Container docker stopped. Start now.."
  docker start docker
fi