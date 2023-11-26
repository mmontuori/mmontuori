#!/bin/bash

source docker/docker_plex_notify.conf
source docker/docker_common_plex_notify.sh

running_container=`get_running_container`

if [ "$runnnig_container" != "" ]; then
	echo "container ${container_name} is running. Stop it first!"
	exit 1
fi

if [ "$1" != "" ]; then
	docker_tag="${1}"
else
	docker_tag="latest"
fi
    
docker run --rm --name plex_notify -d ${container_name}:${docker_tag}
