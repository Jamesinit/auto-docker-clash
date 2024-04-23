# auto-docker-clash

> [!TIP]
>
> I usually use Docker Clash on my local Linux machine, but in many cases, Docker Clash does not automatically update subscriptions and even cannot parse subscriptions by itself. Normally, we need to upload our subscription to other websites and get the real file (subscription conversion). This is very risky behavior, so I decided to write a tool that can complete the above operations with one click using other open source tools, which is `auto-docker-clash`. It can:

- Parse URL and automatically update on a schedule
- One-click start with Docker
- Information security (You can find the `encode URL` function in the py script, so there is no need to upload the subscription URL to unknown sites. You only need to run a conversion container and convert the URL to get the real configuration file locally, thus ensuring the security of the subscription)

# How to use

> [!CAUTION]
>
> This project requires a docker and docker-compose environment [E.X. Ubuntu installation of Docker, Docker-compose](#installing-dockerdocker-compose-on-ubuntu)

1. Get the repo `git clone https://github.com/Jamesinit/auto-docker-clash.git --depth=1 && cd auto-docker-clash`
2. Install dependencies `pip install -r requirements.txt`
3. After copying your subscription URL, create a `.secret` file in the root directory of the project, then paste your subscription link into it: e.g.: https://efshop.cc/api/v1/client/subscribe?token=kjhjkfhaljfaujfjahsdlfjhaljdf

> [!NOTE]
>
> p.s. By the way, efshop.cc, which I have used, is a very affordable and useful VPN service supporting OpenAI, streaming media unlocking, etc. If you also want to use it like me, you can use my invitation link: https://www.easyfastcloud.com/#/register?code=m3YpqOCB
> You will get a discount.

4. `auto-docker-clash` by default uses mixed ports `7890, 9090` as the control port, with the password `12341234`. If you want to change it, you need to modify `docker-compose.yml` and `ParseSubscribe.py` (If you don't care about the above, please skip this step)
5. RUN `./start.sh`
6. Open `ip:7880` in a browser e.g.: `192.168.11.1:7880`, to access the web interface and check the web_clash status

   - **ip**: your ip.

   - **port**: 9090

   - **password**: 12341234

7. `start.sh` will automatically add a scheduled `task` through `crontab_add_task.sh`.
   p.s. If it fails or the `cron` command is not found, please install `cron`, e.g.: `sudo apt install cron` then manually run the script

# roubleshooting

## Pull image error.

> Please update docker daemon config `/etc/docker/daemon.json`

```sh
{
  "registry-mirrors": [
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

> [!CAUTION]
>
> **Don't forget to restart docker** `sudo systemctl restart docker`

## Installing Docker, Docker-compose on Ubuntu

Ubuntu https://docs.docker.com/engine/install/ubuntu

1. Run the following command to uninstall all conflicting packages:

```sh
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
```

2. Set up Docker's apt repository.

```sh
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release and echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```

3. Install the latest version

```sh
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

4. Add group (Optional)

```sh
sudo groupadd docker
sudo usermod -aG docker $USER
```

5. Set to start on boot

```sh
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
```

6. Install docker-compose

> [!CAUTION]
> Generally, docker compose should already be installed through the above steps. You can check with `docker compose version`. If not, then manually install it.

[Docker Compose v2.26.1](https://github.com/docker/compose/releases/tag/v2.26.1)

```sh
cp docker-compose /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose --version
```
