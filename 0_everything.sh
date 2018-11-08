#!/bin/bash
# //////////////////////////////////////////////////////////////  CREACIO DE XARXES  ///////////////////////////////////////////////////////////////////////////////////////////// 
docker rm -f $(docker ps -aq) > /dev/null 2>&1
#docker rmi $(docker images -aq) > /dev/null 2>&1

network_name="client_network"
 for i in ` docker network inspect -f '{{range .Containers}}{{.Name}} {{end}}' $network_name > /dev/null 2>&1 `; do docker network disconnect -f $network_name $i; done;
network_name="server_network"
 for i in ` docker network inspect -f '{{range .Containers}}{{.Name}} {{end}}' $network_name > /dev/null 2>&1 `; do docker network disconnect -f $network_name $i; done;
network_name="router_network"
 for i in ` docker network inspect -f '{{range .Containers}}{{.Name}} {{end}}' $network_name > /dev/null 2>&1 `; do docker network disconnect -f $network_name $i; done;

docker network rm client_network > /dev/null 2>&1
docker network rm server_network > /dev/null 2>&1
docker network rm router_network > /dev/null 2>&1
echo fase_Creacio_nodes
# //////////////////////////////////////////////////////////////  CREACIO DE NODES  ///////////////////////////////////////////////////////////////////////////////////////////// 

#if [ $# -ne 1 ]
#then

docker network create router_network --subnet 8.0.0.0/24 --ipv6 --subnet fd8a:0490:1010:1100::/64 
docker network create client_network --subnet 10.0.2.0/24 --ipv6 --subnet fd8a:0490:1010:1101::/64 
docker network create server_network --subnet 10.0.3.0/24 --ipv6 --subnet fd8a:0490:1010:1110::/64 

docker create -t  --privileged --name client --network client_network --ip 10.0.2.2  alpine:latest
docker create -t --privileged --name server  --network server_network --ip 10.0.3.2  nginx

#CREACIO DE ROUTERS
for (( c = 2; c < $1 + 2; c++));
do
	docker create -t --privileged --name router_$c --network router_network --ip 8.0.0.$c  rabbyte/docker_pti:bmx6
done

#fi

echo fase_inicialitzacio 
# ////////////////////////////////////////////////////////////// INICIALITZACIO DE LES MAQUINES ///////////////////////////////////////////////////////////////////////////////////////////// 

docker start client
docker start server

for (( c = 2; c < $1 + 2; c++));
do
	docker start router_$c
done
echo fase_connexio
# //////////////////////////////////////////////////////////////  CONNEXIO A LES XARXES  ///////////////////////////////////////////////////////////////////////////////////////////// 

docker network disconnect client_network client
docker network connect client_network client

docker network disconnect server_network server
docker network connect server_network server


for (( c = 2; c < $1 + 2; c++));
do
	docker network disconnect router_network router_$c
	docker network connect router_network router_$c
done

docker network connect client_network router_2
docker network connect server_network router_3


echo fase_commandes
# //////////////////////////////////////////////////////////////  COMMANDES BMX7   ///////////////////////////////////////////////////////////////////////////////////////////// 

docker exec -d client ip route del default
docker exec -d client ip route add default via 10.0.2.3

docker exec -d server ip route del default
docker exec -d server ip route add default via 10.0.3.3

docker exec -d router_2 ip route del default
docker exec -d router_2 bmx7 -c tunDev=Default /tun4Address=8.0.0.2/32 /tun6Address=fd8a:0490:1010:1100::2/64
docker exec -d router_2 bmx7 -c tunOut=v4Default /network=0.0.0.0/0 tunOut=v6Default /network=::/0
docker exec -d router_2 bmx7 -c tunIn=def4Offer /n=10.0.2.0/24 /b=32000000

docker exec -d router_3 ip route del default
docker exec -d router_3 bmx7 -c tunDev=Default /tun4Address=8.0.0.3/32 /tun6Address=fd8a:0490:1010:1100::3/64
docker exec -d router_3 bmx7 -c tunOut=v4Default /network=0.0.0.0/0 tunOut=v6Default /network=::/0
docker exec -d router_3 bmx7 -c tunIn=def4Offer /n=10.0.3.0/24 /b=32000000

for (( c = 4; c < $1 + 2; c++));
do
	docker exec -d router_$c ip route del default
	docker exec -d router_$c bmx7 -c tunDev=Default /tun4Address=8.0.0.$c/32 /tun6Address=fd8a:0490:1010:1100::$c/64
	docker exec -d router_$c bmx7 -c tunOut=v4Default /network=0.0.0.0/0 tunOut=v6Default /network=::/0
done

exit 0
