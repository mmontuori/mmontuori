#!/bin/bash

if [ "$1" == "" ]; then
	echo "usage `basename $0` {filename}"
	exit
fi

googlecode_upload.py -p mrom -u "michael.montuori@gmail.com" -w "mV9vp5AY5sK3" -s $1 $1
