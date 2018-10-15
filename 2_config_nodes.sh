#!/bin/bash
#Script de creacio dels contenidors per poder simular
for (( c = 1; c <= $1; c++));
do
	docker network disconnect xarxa_docker node_$c
	docker network connect xarxa_docker node_$c

done

