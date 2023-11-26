#!/bin/bash

for fs in "" 1 2 3 4 5 6 7 8 9 10; do
	echo unmounting box$fs...
	sudo umount /box/box$fs
done
