#!/bin/bash
set -a
source .env || exit 1
set +a

docker-compose down -v
docker-compose up -d

# IMP: insert primary_data
docker cp primary_data.sql $(docker-compose ps -q postgres):/primary_data.sql
sleep 5
docker-compose exec postgres psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f ./primary_data.sql
