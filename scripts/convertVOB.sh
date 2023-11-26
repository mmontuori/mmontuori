#!/bin/bash -x

if [ "$1" == "" ] && [ "$2" == "" ]; then
	echo "usage: `basename $0` {inputfile} {outputfile}"
	exit
fi

files="movie.m2v movie.ac3 movie-s.m2v"
for file in $files; do
	if test -f $file; then
		rm $file
	fi
done

#cat ${1} > /tmp/movie.vob 

tcextract -i ${1} -t vob -x mpeg2 > movie.m2v
tcextract -i ${1} -a 0 -x ac3 -t vob > movie.ac3

tcrequant -i movie.m2v -o movie-s.m2v -f 1.5

mplex -f 8 -o ${2}%d.mpg movie.m2v movie.ac3

#mplex -f 8 -O 66ms -o final.mpg shrinked.m2v movie.ac3

