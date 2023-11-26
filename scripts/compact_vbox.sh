#!/bin/bash

vbox_dir="/cygdrive/c/Program Files/Oracle/VirtualBox"

disk=$1

if ! test -f "$disk"; then
	echo "ERROR: $disk not found!"
	exit 1
fi

cd "$vbox_dir"

./VBoxManage.exe modifymedium --compact "$disk"

