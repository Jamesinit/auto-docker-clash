#!/bin/bash
# This script wille reget clash config then restart clash and clash web docker
# The work_space don't need to change by yousel,it will automatically be changed  by up.sh script
work_space='/home/vvw/auto-docker-clash/'

cd ${work_space} || exit
# run convert server
docker compose -f ./docker-compose-subconverter.yml  up -d
sleep 1
#Get new config
python3 ParseSubscribe.py >./log/parse.log
# down convert server
docker compose -f ./docker-compose-subconverter.yml down
#Restart clash docker
docker compose -f docker-compose.yml restart >./log/clash.log
