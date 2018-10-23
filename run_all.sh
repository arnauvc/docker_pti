#!/bin/bash
./0_config_host.sh $1
if [ $# -ne 1 ]
then

./1_create_nodes.sh 0
./1_1_create_client_side.sh 2
./1_1_create_server_side.sh 2
./2_config_nodes.sh 2
./3_run_nodes.sh 4
fi
