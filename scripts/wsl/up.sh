#!/bin/bash

pushd "../../infra"

echo "Starting containers..." && pwd
docker compose up --build

popd