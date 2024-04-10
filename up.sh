#!/bin/bash

docker compose -f ./docker-compose-subconverter.yml up -d &&
python3 ./ParseSubscribe.py &&
docker compose -f docker-compose.yml up -d