#!/bin/bash

source docker/docker_plex_notify.conf
source docker/docker_common_plex_notify.sh

if [ "$1" == "" ]; then
	exprog="/bin/sh"
else
	exprog=$1
fi

docker run -ti $container_name ${exprog}
