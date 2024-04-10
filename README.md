# auto-docker-clash

I usually use Docker Clash on my local Linux machine.

But many Docker Clash without an auto-update subscription function and web control interface.

Can't even parse subscription by themself. (ˉ▽ˉ；)...

Your need on other web upload your subscription and get the real file, that's very dangerous behavior.

So, I decided to write a script with other open-source tools to complete the function that can parse the URL and auto-update by timing.


# How to use it

1. Copy your subscription URL 

2. Create a '.secret', then paste it into. e.g: `https://efshop.cc/api/v1/client/subscribe?token=kjhjkfhaljfaujfjahsdlfjhaljdf`
(By the way, the `efshop.cc` is my used, it's a very cheap vpn service.
If you want to use it like me,you can use my invite url:https://www.easyfastcloud.com/#/register?code=m3YpqOCB You will get a discount)

3. Default clash.yaml uses mixed-port 7890,9090 as the control port,passward is 12341234. if you want to change it you need to change `docker-compose.yml` and `ParseSubscribe.py` 
(If you don't care above skip the step.)

4. RUN `./up.sh`

5. Open '192.168.11.1(Use your Ip):7880' on the web to check the web_clash status.
   1. Ip: your ip.
   2. prot:9090
   3. passward:12341234

6. `up.sh`will auto add timing tash by crontab_add_tash.sh.
   if  failed or cron command not found please install cron then manual run the script


# Trouble Shoot
- Pull image error.(Please update docker damen config`/etc/docker/damen.json)
```json
{
    "registry-mirrors" : [
    "https://dockerproxy.com",
    "https://docker.mirrors.ustc.edu.cn",
    "https://docker.nju.edu.cn",
    "https://registry.docker-cn.com",
    "http://hub-mirror.c.163.com",
    "https://cr.console.aliyun.com",
    "https://mirror.ccs.tencentyun.com"
  ]
}
```
**Don't forget restart docker.**
`sudo systemctl restart docker`

# Others

You can find the endcode URL function in the py script,so you don't need to upload your subscription URL to an unknown website.
You can just run a conversion container and convert the URL to get real Config file work locally to keep your subscription safe.
**If you have any questions please comment with politeness**