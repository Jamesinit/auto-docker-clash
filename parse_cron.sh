#!/bin/bash
# This script wille reget clash config then restart clash and clash web docker
# The work_space don't need to change by yousel,it will automatically be changed  by up.sh script
work_space='/home/vvw/auto-docker-clash/configs/'

cd ${work_space}
#Get new config
python3 ParseSubscribe.py >./log/parse.log
sleep 1
#Restart clash docker
docker compose -f docker-compose.yml restart >../log/clash.log
ls
