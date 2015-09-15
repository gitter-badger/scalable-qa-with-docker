#!/usr/bin/env bash

set -e

DOCKER_REGISTRY_IP=$1

cat <<EOF >/etc/hosts
127.0.0.1	localhost
${DOCKER_REGISTRY_IP}  	docker-registry
EOF