#!/bin/bash

arch=`dpkg --print-architecture`

echo "architecture: ${arch}"

debian_version=`cat /etc/os-release | grep "^VERSION=" | awk -F\( '{ print $2}' | awk -F\) '{ print $1 }'`

echo "debian version: ${debian_version}"

url="https://packages.debian.org/${debian_version}/${arch}/etherwake/download"

echo "URL: ${url}"

