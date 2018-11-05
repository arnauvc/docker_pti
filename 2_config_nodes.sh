#!/bin/bash
#Script that reassigns every node to the network
display_usage() { 
	echo -e "USAGE: One parameter is expected. Please specify the number of nodes. \nIf # of nodes == 0, nothing will happend" 
	}

if [ $# -eq 1 ]
then
	docker network connect router_network node_2

	docker network connect router_network node_3

	for (( c = 1; c <= $1; c++));
	do
		docker network disconnect client_network node_$c
		docker network connect client_network node_$c

	done
	for (( c = $1 + 1; c <= $1 + $1; c++));
	do
		docker network disconnect server_network node_$c
		docker network connect server_network node_$c

	done

	docker network disconnect router_network node_2
	docker network connect router_network node_2
	docker network disconnect router_network node_3
	docker network connect router_network node_3
	
	docker network disconnect router_network node_5
	docker network connect router_network node_5


	exit 0
else
	display_usage
	exit 1
fi
