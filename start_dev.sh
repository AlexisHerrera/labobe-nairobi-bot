#!/bin/sh
docker-compose --env-file ./.env up -d
docker-compose exec bot /bin/bash