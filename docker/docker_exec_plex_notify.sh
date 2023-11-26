#!/bin/bash

source docker/docker_plex_notify.conf
source docker/docker_common_plex_notify.sh

running_container=`get_running_container`

if [ "$running_container" == "" ]; then
	echo "container ${container_name} is not running!"
	exit 1
fi

if [ "$1" = "" ]; then
	exprog="/bin/sh"
else
	exprog=${0}
fi

docker exec -ti $running_container $exprog
