#!/usr/bin/env bash
set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
INFRA_DIR="$SCRIPT_DIR/../../infra"

echo "Restarting containers..."

pushd "$INFRA_DIR"

docker compose down
docker compose up -d

docker compose ps

popd