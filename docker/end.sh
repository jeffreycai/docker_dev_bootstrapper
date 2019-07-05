#!/bin/bash

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BASEDIR=${BASEDIR}/..

. $BASEDIR/docker/config.sh
. $BASEDIR/docker/functions.sh

# stop container
header "Stop container ${APP_NAME}"
. $BASEDIR/docker/docker-container-stop.sh