#!/bin/bash

dir_config="configs"
url_file=".secret"
#==========Check File
# if don't exist configs direcoty will be created for save clash cofig
if [ ! -d "$dir_config" ]; then
	mkdir "$dir_config"
	echo "create $dir_config"

fi
if [ ! -f "$url_file" ]; then
	echo "Please crate .secret file"
	exit
fi

#==========Replace absolute path for other script
configs_absolute_path=$(cd ${dir_config} && echo $PWD && cd ..)
# echo ${configs_absolute_path}
# Using sed to replace the value after root_path=
# workdir=$(echo ${PWD})
# echo ${workdir}
# sed -i "s|^\(dir_path=\).*|\1'$workdir'|" crontab_add_task.sh
# change the crontask script
sed -i "s|^\(work_space=\).*|\1'$configs_absolute_path/'|" parse_cron.sh

#==========Start Dokcer Containers
#docker container Names
convert_container="subconverter"
clash_container="clash"

# Check convert server status
if docker ps --format '{{.Names}}' | grep -q "^$convert_container\$"; then
	echo "Container $convert_container is running"
else
	echo "Container $convert_container is not running"
	echo "Will up the convert container..."
	# up convert container
	docker compose -f ./docker-compose-subconverter.yml up -d
fi

sleep 1

# Get clash config
python3 ./ParseSubscribe.py
# Detect whether the config file is successfully downloaded
if [ $? -eq 0 ]; then
	#Detect whether the clash container  is running
	if docker ps --format '{{.Names}}' | grep -q "^$clash_container\$"; then
		echo "Container $clash_container is running"
	else
		echo "Up clash container..."
		docker compose -f docker-compose.yml up -d
		source crontab_add_task.sh
	fi
fi
