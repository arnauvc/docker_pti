# docker_pti

FIB-UPC College project. 
Since the new version of BMX6, BMX7, has rolled out it's time to test whether the update was worth.
For such purpose we've come up with a way to test different topologies of routers in a fast and easy manner. 
Based on Docker we've build a custom image of OpenWRT with BMX7 installed and a set of scripts to benchmark the protocol.

[DockerHub Repo](https://hub.docker.com/r/rabbyte/docker_pti/) You can download the images into docker using `docker pull rabbyte/docker_pti`.

We are using gns3 2.1.11 to deal with network topologies and configurations. GSN3 offers the ability to import docker containers into the working area. Docker needs to be installed in the host machine for that to happend.

Moreover there's a set of scripts to create containers in bulk and assign them to different networks. This option is currently not used since GNS3 does this for us.

