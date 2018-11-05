#!/bin/bash
#Script de creacio dels contenidors per poder simular

	docker create -t  --privileged --name node_3 --network server_network --ip 170.30.3.2 -p 8083:80 rabbyte/docker_pti:testing
	docker create -t --privileged --name node_4 --network server_network --ip 170.30.3.3 -p 8084:80  nginx

	docker create -t --privileged --name node_5 --network router_network --ip 170.30.1.5  -p 8085:80  rabbyte/docker_pti:testing


	exit 0


