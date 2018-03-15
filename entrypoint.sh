#!/bin/bash
ETH=$(eval "ifconfig | grep 'eth0'| wc -l")
if [ "$ETH"  ==  '1' ] ; then
	nohup /usr/local/bin/net_speeder eth0 "ip" >/dev/null 2>&1 &
fi
if [ "$ETH"  ==  '0' ] ; then
	nohup /usr/local/bin/net_speeder venet0 "ip" >/dev/null 2>&1 &
fi

/etc/init.d/ssh restart

/usr/local/bin/config.sh "$@"
