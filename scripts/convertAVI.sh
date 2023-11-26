#!/bin/bash -x

if [ "$1" == "" ] && [ "$2" == "" ]; then
        echo "usage: `basename $0` {inputfile} {outputfile}"
        exit
fi

ffmpeg -i ${1} -b 500k ${2}
