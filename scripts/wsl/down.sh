#!/bin/bash

pushd "../../infra"

echo "Stopping containers and removing related images..." && pwd
docker compose down --rmi all --volumes --remove-orphans

popd