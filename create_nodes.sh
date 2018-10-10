#!/bin/sh
#Script de creacio dels contenidors per poder simular

docker rm -f $(docker ps -aq)

docker rmi $(docker images -q)

docker run -t -d --privileged rabbyte/docker_pti:latest  /bin/init_bmx7.sh

