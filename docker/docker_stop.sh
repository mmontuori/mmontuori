#!/bin/bash

if [ "$1" == "" ]; then
        echo "usage: `basename $0` {container name}"
        exit 1
fi

container_name="${1}"

function get_running_container {
	container=`docker container ls --no-trunc | grep "${container_name}"`
	echo `echo $container | awk '{ print $1 }'`
	return
}

running_container=`get_running_container`

docker stop ${running_container}

docker system prune -f
