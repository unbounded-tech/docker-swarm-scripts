#!/usr/bin/env bash

# Create nodes
for i in 1 2; do
  docker-machine start node-$i
done

echo ">> The swarm cluster is up and running"

# Print our instructions
docker-machine env node-1