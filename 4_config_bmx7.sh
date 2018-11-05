#bin/bash
#Script that reassigns every node to the network
#display_usage() { 
#	echo -e "USAGE: One parameter is expected. Please specify the number of nodes. \nIf # of nodes == 0, nothing will happend" 
#	}

#if [ $# -eq 1 ]
#then
	
	docker exec -d node_1 ip route del default
	docker exec -d node_1 ip route add default via 170.30.2.3

	docker exec -d node_2 ip route del default
	docker exec -d node_2 bmx7 -c tunDev=Default /tun4Address=170.30.1.2/32 /tun6Address=fd8a:0490:1010:1100::2/64
	docker exec -d node_2 bmx7 -c tunOut=v4Default /network=0.0.0.0/0 tunOut=v6Default /network=::/0
	docker exec -d node_2 bmx7 -c tunIn=def4Offer /n=170.30.2.0/24 /b=32000000
	
	docker exec -d node_3 ip route del default
	docker exec -d node_3  bmx7 -c tunDev=Default /tun4Address=170.30.1.3/32 /tun6Address=fd8a:0490:1010:1100::3/64
	docker exec -d node_3 bmx7 -c tunOut=v4Default /network=0.0.0.0/0 tunOut=v6Default /network=::/0
	docker exec -d node_3 bmx7 -c tunIn=def4Offer /n=170.30.3.0/24 /b=32000000

	docker exec -d node_4 ip route del default
	docker exec -d node_4 ip route add default via 170.30.3.2

	docker exec -d node_5 ip route del default
	docker exec -d node_5  bmx7 -c tunDev=Default /tun4Address=170.30.1.4/32 /tun6Address=fd8a:0490:1010:1100::5/64
	docker exec -d node_5 bmx7 -c tunOut=v4Default /network=0.0.0.0/0 tunOut=v6Default /network=::/0

	exit 0
#else
	#display_usage
	#exit 1
#fi
