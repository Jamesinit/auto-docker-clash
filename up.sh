#!/bin/bash

dir_config="configs"
url_file=".secret"
if [ ! -d "$dir_config" ];then
    mkdir "$dir_config" 
    echo "create $dir_config"
fi
configs_absolute_path=$(cd ${dir_config}&&echo $PWD&&cd ..)
# echo ${configs_absolute_path}
# Using sed to replace the value after root_path=
workdir=$(echo ${PWD})
# echo ${workdir}
sed -i "s|^\(root_path = \).*|\1'$configs_absolute_path/'|" ParseSubscribe.py
sed -i "s|^\(dir_path=\).*|\1'$workdir'|" crontab_add_task.sh


if [ ! -f "$url_file" ];then
    echo "Please crate .secret file"
    exit
fi


convert_container="subconverter"
clash_container="clash"

if docker ps --format '{{.Names}}' | grep -q "^$convert_container\$"; then
    echo "Container $convert_container running"
else
    echo "Container $convert_container stop"
    # up convert container
    docker compose -f ./docker-compose-subconverter.yml up -d 
fi
sleep(1)

python3 ./ParseSubscribe.py 
if [ $? -eq 0 ]; then
    #up clash and clash web
    docker compose -f docker-compose.yml up -d
    if docker ps --format '{{.Names}}' | grep -q "^$clash_container\$"; then
        echo "Container $clash_container running"
        # add timing task to crontab
        source crontab_add_task.sh
    else
        echo "Container $clash_container stop"
    fi
else
    echo "ParseSubscribe failed"
fi

    if docker ps --format '{{.Names}}' | grep -q "^$clash_container\$"; then
        echo "Container $clash_container running"
        # add timing task to crontab
        source crontab_add_task.sh
    else
        echo "Container $clash_container stop"
    fi
else
    echo "ParseSubscribe failed"
fi
