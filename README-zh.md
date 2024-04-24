# auto-docker-clash

> [!TIP]
>
> 我通常在本地 Linux 机器上使用 Docker Clash，但许多情况下 Docker Clash 并没有自动更新订阅功能和网络控制界面甚至不能自己解析订阅
> 通常情况下我们需要在其他网站上传您的订阅并获取真实文件(订阅转换)
> 这是非常危险的行为，因此，我决定搭配其他开源工具编写一个可以一键化完成上述操作的工具也就是 `auto-docker-clash`，它可以：

- 完成解析 URL 并定时自动更新的功能
- Docker 一键启动
- 信息安全(您可以在 py 脚本中找到 `endcode URL` 功能，因此无需将订阅 URL 上传到未知网站。你只需运行一个转换容器并转换
  URL，即可在本地获得真正的配置文件，从而保证订阅的安全)

# 如何使用

> [!CAUTION]
>
> 本项目需要有 docker 和 docker-compose 环境 [E.X. Ubuntu 安装 Docker、Docker-compose](#ubuntu-安装-dockerdocker-compose)

1. get repo `git clone https://github.com/Jamesinit/auto-docker-clash.git --depth=1 && cd auto-docker-clash`
2. 安装依赖 `pip install -r requirements.txt`
3. 复制您的订阅 URL后在项目根目录下创建一个 `.secret`
   文件，然后将您的订阅链接粘贴进去：e.g.: https://efshop.cc/api/v1/client/subscribe?token=kjhjkfhaljfaujfjahsdlfjhaljdf

> [!NOTE]
>
> p.s. 顺便说一下，efshop.cc 是我用过的，这是一个非常实惠好用的 vpn 服务支持
>
OpenAI、流媒体解锁等如果你也想和我一样使用它，可以使用我的邀请网址： https://www.easyfastcloud.com/#/register?code=m3YpqOCB
> 你将获得折扣）

4. `auto-docker-clash` 默认 `clash.yaml` 使用混合端口 `7890、9090` 作为控制端口，密码为 `12341234`
   。如果要更改，需要更改 `docker-compose.yml`和 `ParseSubscribe.py` （如果您不在意上述内容，请跳过该步骤）
5. RUN `./start.sh`
6. 在浏览器打开 `ip:7880` e.g.: `192.168.11.1:7880`，访问 web 界面，查看 web_clash 状态
    - **ip**: your ip.
    - **prot**: 9090
    - **passward**: 12341234
7. `start.sh`将通过 `crontab_add_tash.sh` 自动添加定时 `tash`。
   p.s. 如果失败或找不到 `cron` 命令，请安装 `cron`，e.g.: `sudo apt install cron` 然后手动运行脚本

# 故障排除

## Pull image error.

> Please update docker damen config `/etc/docker/damen.json`

```json
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

>[!CAUTION]
> **别忘了重启 docker** `sudo systemctl restart docker`

## Ubuntu 安装 Docker、Docker-compose

Ubuntu https://docs.docker.com/engine/install/ubuntu

1. Run the following command to uninstall all conflicting packages:

```shell
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
```

2. Set up Docker's apt repository.

```shell
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```

3. install the latest version

```shell
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

4. 添加组 （可选）

```shell
sudo groupadd docker
sudo usermod -aG docker $USER
```

5. 设置开机启动

```shell
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
```

6. 安装 docker-compose

> [!CAUTION]
> 一般通过上述步骤 docker compose 已经安装好了 可以通过 `docker compose version` 如果没有再手动安装

[Docker Compose v2.26.1](https://github.com/docker/compose/releases/tag/v2.26.1)

```shell
cp docker-compose /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose --version
```
