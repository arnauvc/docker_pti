#!/bin/bash
#Script de creacio dels contenidors per poder simular
display_usage() { 
	echo -e "USAGE: One parameter is expected. Please specify the number of nodes. \nIf # of nodes == 0, every images and container will be removed. Use to clean only" 
	}

if [ $# -eq 1 ]
then
	for (( c = 1; c <= $1; c++));
	do
		docker create -t --privileged --name node_$c --network route_network --ip 170.30.1.$c rabbyte/docker_pti:testing
	done
	exit 0
else 
	display_usage
	exit 1

fi

