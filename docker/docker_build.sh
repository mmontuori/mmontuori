#!/bin/bash

if [ "$1" == "" ]; then
	echo "usage: `basename $0` {template name}"
	exit 1
fi

docker build \
-t ${1} .

