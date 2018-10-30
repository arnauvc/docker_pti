#!/bin/bash
#Script that reassigns every node to the network
#display_usage() { 
#	echo -e "USAGE: One parameter is expected. Please specify the number of nodes. \nIf # of nodes == 0, nothing will happend" 
#	}

#if [ $# -eq 1 ]
#then
	docker exec -d node_2  bmx7 -c tunDev=Default /tun4Address=170.30.2.3/32 /tun6Address=fd8a:0490:1010:1101::1/64
	#bmx7 -c tunOut=v4Default /network=0.0.0.0/0 tunOut=v6Default /network=::/0


	docker exec -d node_3  bmx7 -c tunDev=Default /tun4Address=170.30.3.2/32 /tun6Address=fd8a:0490:1010:1110::1/64

	exit 0
#else
	#display_usage
	#exit 1
#fi
