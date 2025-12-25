#!/bin/bash

echo "- Pulling images..."
docker compose pull

echo "- Restarting containers..."
docker compose up -d

echo "- Pruning old images..."
docker image prune -f