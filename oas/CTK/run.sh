#!/bin/bash

cd "$(dirname "$0")"

rm -rf ./RESULTS && mkdir -p ./RESULTS/assets
[ $# -gt 0 ] && export TEST_BASE_URL=$1

docker network inspect tmf >/dev/null 2>&1 || docker network create tmf

export DOCKER_UID=$(id -u) DOCKER_GID=$(id -g)

ctk_container=$(docker compose run -d ctk)

cleanup() {
    docker cp "$ctk_container:/usr/src/app/assets/images/tmf-logo.svg" ./RESULTS/assets/
    docker rm -f "$ctk_container"
}
trap cleanup EXIT

docker logs -f "$ctk_container"
