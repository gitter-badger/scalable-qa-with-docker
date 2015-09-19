#!/usr/bin/env bash

set -e

DOCKER_REGISTRY_IP=$1

cat <<EOF >/etc/hosts
127.0.0.1	localhost
${DOCKER_REGISTRY_IP}  	docker-registry
172.17.8.101 core-01
172.17.8.102 core-02
172.17.8.103 core-03
EOF