#!/bin/bash

dir_path=$(dirname "$0")

cd ${dir_path} || exit
# run convert server
docker compose -f ./docker-compose-subconverter.yml  up -d >/dev/null 2>&1
sleep 1
#Get new config
python3 ParseSubscribe.py >./log/parse.log 
# down convert server
docker compose -f ./docker-compose-subconverter.yml down >/dev/null 2>&1
#Restart clash docker
docker compose -f docker-compose.yml restart >./log/clash.log >/dev/null 2>&1
