#!/bin/bash

function get_running_container {
	container=`docker container ls --no-trunc | grep "${container_name}"`
	echo `echo $container | awk '{ print $1 }'`
	return
}
