#!/bin/bash

# Generate k3s server token
echo "Generating k3s server token..."
SERVER_TOKEN=$(docker run --rm rancher/k3s:latest sh -c "cat /var/lib/rancher/k3s/server/node-token")
echo "Server token: $SERVER_TOKEN"

# Replace the placeholder in the docker-compose.yml.template with the generated token
echo "Replacing token placeholder in docker-compose.yml.template..."
sed "s|\${K3S_TOKEN}|$SERVER_TOKEN|" docker-compose.yml.template > docker-compose.yml

# Start the cluster
echo "Starting the cluster..."
docker compose up -d
