#!/bin/bash

echo "Restarting containers..." && pwd

./down.sh || echo "Failed to stop containers, proceeding with starting..." && true
./up.sh

