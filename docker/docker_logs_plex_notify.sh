#!/bin/bash

source docker/docker_plex_notify.conf
source docker/docker_common_plex_notify.sh

if [ "$1" != "" ]; then
    docker_tag=$1
else
    docker_tag="latest"
fi

flags="-f --details --tail 500"

running_container=`get_running_container`

if [ "$running_container" == "" ]; then
	echo "container ${container_name} is not running!"
	exit 1
fi

command="docker logs $flags $running_container"

$command
