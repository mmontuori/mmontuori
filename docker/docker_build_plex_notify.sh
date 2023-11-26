#!/bin/bash

source docker/docker_plex_notify.conf
source docker/docker_common_plex_notify.sh

if ! test -f $container_file; then
	echo "Error! Run this where ${container_file} is present!"
	exit 1
fi

if [ "$1" != "" ]; then
	docker_tag="${1}"
else
	docker_tag="latest"
fi

echo "building  ${container_name} with tag:${docker_tag}"

docker build --file $container_file -t ${container_name}:${docker_tag} .
