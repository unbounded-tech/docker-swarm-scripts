#!/usr/bin/env bash

# Create nodes
for i in 1 2 3 4 5 6; do
  docker-machine create -d virtualbox node-$i
done

NODE1_IP=$(docker-machine ip node-1)

# Initialize the swarm cluster, and set up manager on node-1
eval $(docker-machine env node-1)
docker swarm init --advertise-addr $NODE1_IP

# Generate tokens for joining the cluster
MANAGER_TOKEN=$(docker swarm join-token -q manager)
WORKER_TOKEN=$(docker swarm join-token -q worker)


# Join the next two nodes as managers
for i in 2 3; do
  eval $(docker-machine env node-$i)
  docker swarm join --token $MANAGER_TOKEN $NODE1_IP:2377
done

# Join the next three nodes as workers
for i in 4 5 6; do
  eval $(docker-machine env node-$i)
  docker swarm join --token $WORKER_TOKEN $NODE1_IP:2377
done


echo ">> The swarm cluster is up and running"

# Print our instructions
docker-machine env node-1
