#!/bin/bash
#Script de creacio dels contenidors per poder simular

docker rm -f $(docker ps -aq)
docker rmi rabbyte/docker_pti:latest

for (( c = 1; c <= $1; c++));
do	
	docker run -t -d --privileged --name node_$c   rabbyte/docker_pti:latest  

done


