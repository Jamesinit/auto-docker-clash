#!/bin/bash

# 设置 Python 脚本路径
script_path="/home/vv/clash/ParseSubscribe.py"

# 设置 cron 作业的执行时间（在凌晨 6 点执行）
cron_time="0 6 * * *"

# 将 cron 作业添加到 crontab 文件中
(crontab -l ; echo "$cron_time /usr/bin/python3  $script_path") |crontab -
