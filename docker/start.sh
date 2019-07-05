#!/bin/bash

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BASEDIR=${BASEDIR}/..

. $BASEDIR/docker/config.sh
. $BASEDIR/docker/functions.sh

# image
header "Build base image if not yet"
. $BASEDIR/docker/docker-image-build.sh

# container
header "Start container"
. $BASEDIR/docker/docker-container-start.sh