#!/bin/bash

# 设置 Python 脚本路径
dir_path="/home/vv/clash"
script_name="ParseSubscribe.py"
# 设置 cron 作业的执行时间（在凌晨 6 点执行）
parse_cron_time="0 6 * * *"
reload_cron_time="2 6 * * *"

if command -v crontab &> /dev/null; then
    # 将 cron 作业添加到 crontab 文件中
    (crontab -l ; echo "$parse_cron_time /usr/bin/python3  $dir_path/$script_name") |crontab -
    (crontab -l ; echo "$reload_cron_time /usr/bin/zsh  cd $dir_path && docker compose -f docker-compose.yml restart ") |crontab -
else
    echo "crontab not found"
    echo "Please install cron use apt insatll cron"
    echo "Then Please manual run crontab_add_task.sh"
fi


