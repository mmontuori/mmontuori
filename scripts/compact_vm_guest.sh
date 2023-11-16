#!/bin/bash

if [ "$1" == "host" ]; then
	VBoxManage modifyhd --compact "C:\netreliant_VMs\linux_001.vdi"
	exit
fi

dd if=/dev/zero of=/var/tmp/zerofile bs=1M
rm /var/tmp/zerofile

