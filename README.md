# docker_pti

FIB-UPC College project. 
Since the new version of BMX6, BMX7, has rolled out it's time to test whether the update was worth.
For such purpose we've come up with a way to test different topologies of routers in a fast and easy way. 
Based on Docker we've build a custom image of OpenWRT with BMX7 installed and a set of scripts to spawn containers.

This guide only serves the purpose to explain how to deal with the containers but tells nothing about bmx7 per se.

[DockerHub Repo](https://hub.docker.com/r/rabbyte/docker_pti/) You can download the images into docker using `docker pull rabbyte/docker_pti`.
Though there's no need because the script will do it by itself.

There're 4 major files:
* 0_config_host
* 1_create_nodes
* 2_config_nodes
* Dockerfile

0. **0_config_host**
  Creates the underlaying network to allow the containers to communicate with each other and enables IPv6 addresses.
  
1. **1_create_nodes**
  Needs the number of nodes you want to create as a parameter of the script. Before creating any node, it stops and deletes all containers running and deletes all images in the host. The pulls a fresh image from the online repo and builds as many containers as you specify

2. **2_config_nodes**
  Assigns every node to the aforementioned underlay network.
