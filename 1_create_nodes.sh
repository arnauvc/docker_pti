#!/bin/bash
#Script de creacio dels contenidors per poder simular
display_usage() { 
	echo -e "USAGE: One parameter is expected. Please specify the number of nodes. \nIf # of nodes == 0, every images and container will be removed. Use to clean only" 
	}

if [ $# -eq 1 ]
then
	docker rm -f $(docker ps -aq) > /dev/null 2>&1
	docker rmi rabbyte/docker_pti:latest > /dev/null 2>&1

	for (( c = 1; c <= $1; c++));
	do
		docker run -t -d --privileged --name node_$c --network xarxa_docker --ip 170.30.$c.2   rabbyte/docker_pti:latest
	done
	exit 0
else 
	display_usage
	exit 1

fi

