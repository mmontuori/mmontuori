#!/bin/bash

if [ "$1" == "" ]; then
	echo "usage: `basename $0` {volume1} [volume2]"
	exit 1
fi

container_img="ubuntu"
volume1="${1}"
volume2="${2}"
volume1_mnt="/volume1"
volume2_mnt="/volume2"
container_name="docker_mnt"


if [ "$volume1" != "" ]; then
	v_opts="-v ${volume1}:${volume1_mnt}"
fi

if [ "$volume2" != "" ]; then
	v_opts="$v_opts -v ${volume2}:${volume2_mnt}"
fi

docker_cmd="docker run --name ${container_name} -ti ${v_opts} ${container_img} /bin/bash"

echo "instantiating command: ${docker_cmd}"

${docker_cmd}

docker container rm ${container_name} > /dev/null 2>&1
