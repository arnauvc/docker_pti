#!/bin/bash

docker rm -f $(docker ps -aq) > /dev/null 2>&1
docker rmi rabbyte/docker_pti:latest > /dev/null 2>&1

network_name="client_network"
 for i in ` docker network inspect -f '{{range .Containers}}{{.Name}} {{end}}' $network_name `; do docker network disconnect -f $network_name $i; done;
network_name="server_network"
 for i in ` docker network inspect -f '{{range .Containers}}{{.Name}} {{end}}' $network_name `; do docker network disconnect -f $network_name $i; done;
network_name="router_network"
 for i in ` docker network inspect -f '{{range .Containers}}{{.Name}} {{end}}' $network_name `; do docker network disconnect -f $network_name $i; done;

docker network rm client_network
docker network rm server_network
docker network rm router_network


if [ $# -ne 1 ]
then
#docker network create xarxa_docker --ipv6 --subnet fd8a:0490:1010::/48 --gateway fd8a:0490:1010::1
docker network create router_network --subnet 170.30.1.0/24 --ipv6 --subnet fd8a:0490:1010:1100::/64 
docker network create client_network --subnet 170.30.2.0/24 --ipv6 --subnet fd8a:0490:1010:1101::/64 
docker network create server_network --subnet 170.30.3.0/24 --ipv6 --subnet fd8a:0490:1010:1110::/64 
fi

exit 0
