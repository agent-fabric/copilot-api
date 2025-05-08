#!/bin/bash

cd $(dirname $0)

docker compose down
docker network ls | grep -e '\btmf\b' || docker network create tmf
docker compose up
