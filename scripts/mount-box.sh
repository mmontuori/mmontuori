#!/bin/bash

for fs in "" 1 2 3 4 5 6 7 8 9 10; do
	echo mounting box$fs...
	sudo mount /box/box$fs
done
