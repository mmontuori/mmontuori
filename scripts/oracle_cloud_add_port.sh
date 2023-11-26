#!/bin/bash

if [ "$1" == "" ]; then
    echo "usage: oracle_cloud_add_port.sh {port} {tcp|udp}"
    exit
fi

port="$1"
protocol="$2"

iptables -I INPUT 6 -m state --state NEW -p ${protocol} --dport ${port} -j ACCEPT

netfilter-persistent save
