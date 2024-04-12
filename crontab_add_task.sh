#!/bin/bash

# 设置 Python 脚本路径
dir_path='/home/vvw/auto-docker-clash'
script_name="parse_cron.sh"
# 设置 cron 作业的执行时间（在凌晨 6 点执行）
parse_cron_time="0 6 * * *"

cron_job="${parse_cron_time} ${dir_path}/${script_name}"

if command -v crontab &>/dev/null; then
	# 将 cron 作业添加到 crontab 文件中
	echo "${cron_job}" | crontab -
else
	echo "crontab not found"
	echo "Please install cron use apt insatll cron"
	echo "Then Please manual run crontab_add_task.sh"
fi
