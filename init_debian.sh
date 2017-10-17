#!/bin/bash
#
#wget -qO- down.99.tf/init_debian.sh|bash
#
#
#echo root:PASSWORD | sudo chpasswd root
#sudo sed -i 's/^.*PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config;
#sudo sed -i 's/^.*PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config;
#sudo sed -i 's/^.*Port .*/Port 55555/g' /etc/ssh/sshd_config;
#sudo reboot
echo "#######################################################时区设置"
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
date -R
echo "#######################################################让ipv4优先于ipv6"
#cat /etc/gai.conf
#echo "precedence ::ffff:0:0/96 100">>/etc/gai.conf
sed -i "s@#precedence ::ffff:0:0/96  100@precedence ::ffff:0:0/96  100@g" /etc/gai.conf
echo "#######################################################开机自启动"
sed -i 's/exit 0/ /' /etc/rc.local 
echo "sh -c '/init.sh &'" >> /etc/rc.local
echo exit 0 >> /etc/rc.local
echo "#!/bin/bash" > /init.sh
wget down.99.tf/init.sh -O /init.sh.txt
cat /init.sh.txt >> /init.sh
rm -fr /init.sh.txt
chmod -R 777 /init.sh
#cat /init.sh
echo "#######################################################修改文件打开限制"
#echo "#查看当前系统打开文件数限制"
#cat /proc/sys/fs/file-nr
#echo "#进程文件限制"
#ulimit -n
#echo ulimit -SHn 1020000 >> /etc/profile && echo ulimit -SHn 1020000 >> /etc/rc.local && echo "* soft nofile 1020000" >> /etc/security/limits.conf && echo "* hard nofile 1020000" >> /etc/security/limits.conf && source /etc/profile && ulimit -n 
#sed -i 's/exit 0/ /' /etc/rc.local 
#echo exit 0 >>/etc/rc.local
#cat /etc/rc.local
echo "#######################################################清理环境"
apt-get -y purge bind9-* xinetd samba-* nscd-* portmap sendmail-* sasl2-bin
apt-get -y purge lynx memtester unixodbc odbcinst-* ttf-*
apt-get -y purge php* apache2-* 
echo "#升级"
apt-get update -y
#apt-get upgrade -y
apt-get install -y apt-transport-https procps curl wget net-tools binutils cron screen lsof sysstat rsync dnsutils
echo "#服务管理"
apt-get -y install chkconfig && chkconfig -l
echo "#清理服务"
chkconfig acpid off
chkconfig auditd off
chkconfig bootlogs off
chkconfig cloud-config off
chkconfig cloud-final off
chkconfig cloud-init off
chkconfig cloud-init-local off
chkconfig blk-availability off
chkconfig ip6tables off
chkconfig lvm2-monitor off
chkconfig udev-post off
chkconfig postfix off && service postfix stop
chkconfig netfs off
chkconfig xinetd off
chkconfig restorecond off
chkconfig iscsid on
chkconfig iscsi on
chkconfig mdmonitor off
chkconfig cpuspeed off
echo "#查看"
chkconfig -l
echo "#######################################################卸载内置angent"
#alicloud
pkill aliyun-service && rm -fr /etc/init.d/agentwatch /usr/sbin/aliyun-service
echo "#######################################################全局变量"
echo $PATH 
source /etc/profile
echo "#######################################################系统内核优化"
chmod 777 /etc/sysctl.conf
cp /etc/sysctl.conf /etc/sysctl.conf.back
wget down.99.tf/sysctl.conf -O /tmp/sysctl.conf.txt
cat /tmp/sysctl.conf.txt >> /etc/sysctl.conf
rm -fr /tmp/sysctl.conf.txt
sysctl -p
echo "#######################################################修改ssh设置"
#sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
#sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
##sed -i 's/^.*PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config;
##sed -i 's/^.*PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config;
##sed -i 's/Port 22/Port 30000/' /etc/ssh/sshd_config
#echo root:PASSWORD | sudo chpasswd root
#sudo sed -i 's/^.*PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config;
#sudo sed -i 's/^.*PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config;
#sudo reboot
#/etc/init.d/ssh restart
#service ssh restart
echo "#######################################################磁盘优化"
df -khal
#for f in /sys/block/sd*/queue/scheduler; do echo "deadline" > $f; done
#more  /sys/block/sda/queue/scheduler
#for f in /sys/block/vd*/queue/scheduler; do echo "deadline" > $f; done
#more  /sys/block/vda/queue/scheduler
#echo "#######################################################安装bbrx"
#wget -qO- down.99.tf/bbrx.sh|bash
echo "#######################################################安装7z"
wget down.99.tf/7z -O /bin/7z && chmod 777 /bin/7z
echo "#######################################################安装流量统计"
apt-get install -y vnstat
#NETCARD=eth0
NETCARD=`ifconfig | awk '/encap|inet addr/' | grep -v '127.0.0.1' | grep -v 'Local Loopback' | head -1 | awk '{ print $1}'`
sed -i "s/^.*Interface .*/Interface \"$NETCARD\"/g" /etc/vnstat.conf
sed -i 's/^.*MaxBandwidth .*/MaxBandwidth 0/g' /etc/vnstat.conf
sed -i 's/^.*UnitMode .*/UnitMode 1/g' /etc/vnstat.conf
chkconfig vnstat on
vnstat -u -i $NETCARD
service vnstat stop
chown vnstat:vnstat /var/lib/vnstat/.$NETCARD
chown vnstat:vnstat /var/lib/vnstat/$NETCARD
service vnstat start
echo "#######################################################安装中文支持"
apt-get -y install locales ttf-wqy-zenhei ttf-wqy-microhei xfonts-intl-chinese xfonts-wqy
export LC_ALL="zh_CN.UTF-8"
export LANG="zh_CN.UTF-8"
locale
echo "#######################################################安装serverspeeder"
echo "127.0.0.1 dl.serverspeeder.com " >> /etc/hosts
echo "127.0.0.1 my.serverspeeder.com " >> /etc/hosts
echo "127.0.0.1 www.serverspeeder.com " >> /etc/hosts
echo "127.0.0.1 dl.lotserver.cn " >> /etc/hosts
echo "127.0.0.1 my.lotserver.cn " >> /etc/hosts
echo "127.0.0.1 www.lotserver.cn " >> /etc/hosts
apt-get update && apt-get install -y unzip wget
wget --no-check-certificate -O appex.sh https://raw.githubusercontent.com/88x/serverSpeeder_Install/master/appex.sh && chmod +x appex.sh && bash appex.sh install
rm -fr appex.sh
#卸载：
#wget --no-check-certificate -O appex.sh https://raw.githubusercontent.com/0oVicero0/serverSpeeder_Install/master/appex.sh && chmod +x appex.sh && bash appex.sh uninstall
#命令：
#/appex/bin/serverSpeeder.sh status
#/appex/bin/serverSpeeder.sh restart
#/appex/bin/serverSpeeder.sh stop
#echo "#######################################################"
#echo "-----===== DONE =====-----"
/init.sh
