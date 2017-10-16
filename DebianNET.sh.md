# Debian(Ubuntu)网络安装/重装一键脚本

2017年3月25日

## 背景:
适用于由GRUB引导的CentOS,Ubuntu,Debian系统.
使用官方发行版去掉模板预装的软件.
同时也可以解决内核版本与软件不兼容的问题。
只要有root权限,还您一个纯净的系统。

## 注意:
全自动安装默认root密码:``` x88x88x88x88 ```,安装完成后请立即更改密码.
请使用``` passwd root ```命令更改密码.
特别注意:OpenVZ构架不适用.

## 更新:
[2017.08.06]
增加支持重装为Ubuntu系统

### 支持列表:
```
版本号  版本代号  VNC模式 自动模式
12.04   precise   yes     yes
14.04   trusty    yes     yes
15.10   wily      yes     yes
16.04   xenial    yes     yes
16.10   yakkety   yes     yes
17.04   zesty     yes     yes
```

安装Ubuntu时,必须使用版本代号.
如有必要,请使用``` --mirror ```自行更换软件源.
使用方法示例:

以自动模式安装 Ubuntu 16.04 64 位为例:
```bash DebianNET.sh -d xenial -v 64 -a```

### [2017.07.05]
修复在独服上安装的一些由硬盘引起的问题.
修复在CentOS6上判断网卡出错的问题.

### [2017.06.25]
适配了由较老GRUB版本引导的CentOS6等系统.
去除-cn参数,此参数作用不大.
添加-apt/--mirror参数,用于指定源(需完整的镜像源地址).
用法示例:
```
--mirror 'http://ftp.riken.jp/Linux/debian/debian/'
--mirror 'http://mirrors.ustc.edu.cn/debian/'
```

### [2017.06.24]
由公网探测IP地址,改为本机探测IP地址.适配更加广泛.

### [2017.06.23]
修复Debian9不能使用root登陆的问题.
移除对于route命令的依赖,使用ip命令并计算子网掩码.
修复使用ls命令时的一个错误警告.
增加-cn参数,使国内机器下载所需资源更加迅速.

### [2017.06.20]
增加对Debian9的支持,支持全自动化安装.
未做大量测试,有问题请反馈.

### [2017.06.09]
添加支持从CentOS7运行全自动化安装Debian.
理论上支持由grub2引导的系统(CentOS6由grub引导,故不支持.).
优化判断逻辑,删除 -t 参数.
添加-a参数(全自动化安装)和-m参数(从VNC模式安装)

### [2017.06.05]
修复全自动安装Debian8会出现卡住和不能使用root密码登陆的问题.

### [2017.06.04]
增加全自动方式安装,实现在无救援模式,无VNC的情况下安装Debian.
已在AWS Lightsail(Ubuntu),DigitalOcean,UltraVPS.eu通过测试.
默认root密码:Vicer,安装完成后请立即更改密码.
使用``` passwd root ```命令更改密码.

### [2017.03.28]
增加了一个之参数选项；
此参数用于手动指定机器的虚拟化类型。
一般情况下不需要指定此参数。

### [2017.03.25]
修复了一些已知问题。

------------------------------------------------

## 需要:
```
1. Debian/Ubuntu/CentOS 系统(由GRUB引导);
2. wget 用来下载文件，获取公网IP;
3. ip 获取网关，掩码等;
4. sed awk grep 处理文本流;
5. VNC 安装系统(此项为可选).
```

------------------------------------------------

## 确保安装了所需软件:
### Debian/Ubuntu:
```apt-get install -y gawk sed grep```
### RedHat/CentOS:
```yum install -y gawk sed grep```

## 如果出现了错误,请运行:
### Debian/Ubuntu:
```apt-get update```
### RedHat/CentOS:
```yum update```

------------------------------------------------

## 一键下载及使用:
```
wget down.99.tf/DebianNET.sh -O DebianNET.sh && chmod +x DebianNET.sh

Usage:
        bash DebianNET.sh       -d/--debian [7/wheezy|8/jessie|9/stretch]
                                -v/--ver [32/i386|64/amd64]
                                -sshport/--sshport [22~65535]
                                -swap/--swap [1G]
```

## 安装示例:
### 全自动安装:
```
bash DebianNET.sh -d wheezy -v i386 -a
bash DebianNET.sh --debian 8 --ver 64 --auto --password xxxxxxxxxx --sshport 22222 --swap 1G --mirror 'http://mirrors.ustc.edu.cn/debian/'
```
### VNC手动安装:
```bash DebianNET.sh -d wheezy -v i386 -m```

------------------------------------------------

## 使用:
### 【默认】安装Debian 7 x32：
```
bash DebianNET.sh -d wheezy -v i386
-或者
bash DebianNET.sh -d 7 -v 32
```
### 安装Debian 7 x64：
```
bash DebianNET.sh -d wheezy -v amd64
-或者
bash DebianNET.sh -d 7 -v 64
```
### 安装Debian 8 x32：
```
bash DebianNET.sh -d jessie -v i386
-或者
bash DebianNET.sh -d 8 -v 32
```
### 安装Debian 8 x64：
```
bash DebianNET.sh -d jessie -v amd64
-或者
bash DebianNET.sh -d 8 -v 64
```
### 安装Debian 9 x32：
```
bash DebianNET.sh -d stretch -v i386
-或者
bash DebianNET.sh -d 9 -v 32
```
### 安装Debian 9 x64：
```
bash DebianNET.sh -d stretch -v amd64
-或者
bash DebianNET.sh -d 9 -v 64
```
### 安装Ubuntu 14.04 x32：
```bash DebianNET.sh -d trusty -v 32```
### 安装Ubuntu 14.04 x64：
```bash DebianNET.sh -d trusty -v 64```
### 安装Ubuntu 16.04 x32：
```bash DebianNET.sh -d xenial -v 32```
### 安装Ubuntu 16.04 x64：
```bash DebianNET.sh -d xenial -v 64```
### 安装Ubuntu 17.04 x32：
```bash DebianNET.sh -d zesty -v 32```
### 安装Ubuntu 17.04 x64：
```bash DebianNET.sh -d zesty -v 64```

------------------------------------------------

## 修改引导
```
#内核列表
dpkg -l|grep linux-image
#查看引导信息
grep menuentry /boot/grub/grub.cfg
#修改引导条id
nano /etc/default/grub
#初始化设置
#update-grub
#重启
reboot
```

