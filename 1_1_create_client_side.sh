#!/bin/bash
#Script de creacio dels contenidors per poder simular

	docker create -t  --privileged --name node_1 --network client_network --ip 170.30.2.2 -p 8081:80  alpine:latest 
	docker create -t  --privileged --name node_2 --network client_network --ip 170.30.2.3 -p 8082:80  rabbyte/docker_pti:testing

	exit 0


