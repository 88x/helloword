######
#fallocate -l 1G /swapfile
#mkswap /swapfile
#swapon /swapfile
if [ ! -d "/swapfile" ]; then
swapon /swapfile
fi
######
export TZ='Asia/Shanghai'
ulimit -SHn 1020000
export LC_ALL="zh_CN.UTF-8"
export LANG="zh_CN.UTF-8"
locale
######
wget down.99.tf/ss -O /bin/s2 && chmod -R 777 /bin/s2
sh -c 's2 -p 30001 -k mm1 -m rc4-md5 -R "ss.qq.ee/heart" -T 10000 -I "node" -X 1 &'
######
#wget down.99.tf/kcp_server_linux_x64 -O /bin/kcp && chmod -R 777 /bin/kcp
#sh -c 'kcp -t "127.0.0.1:30001" -l ":30002" --key "mm1" --crypt xor -mode fast2 --nocomp &'
######
#wget down.99.tf/aria2c -O /bin/down && chmod -R 777 /bin/down
#aria2c_session=/etc/aria2c.session.txt
#touch $aria2c_session
#sh -c 'down --enable-rpc --rpc-listen-all --rpc-listen-port=30011 --dir=/root/down.tmp --max-connection-per-server=10 --max-concurrent-downloads=100 --disable-ipv6=true --pause-metadata=true --dht-listen-port=30012 --on-download-complete="aria2c.hook.complete.sh" --save-session-interval=30 --save-session=$aria2c_session --input-file=$aria2c_session --continue=true --content-disposition-default-utf8=true --disk-cache=32M --peer-id-prefix="-UT341-" --user-agent="Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3102.0 Safari/537.36" --rpc-secret=www.bing.com &'
######
#pushd /pika && ./pika -c ./pika.conf && popd
#/ssdb/ssdb-server -d /ssdb/ssdb.conf
######
MYIP=$(wget ip.qq.ee/?i=1 -qO-)
NOW=$(date -d "0 hours" +"%Y%m%d %H:%M:%S")
wget "http://pushbullet.api.qq.ee/?title=[$NOW]$MYIP&body=." -O-
######
#/openresty/app/bin/nginx
######
#screen -dmS "vqq-admin" sh -c 'vqq.save2ms.dm.sh admin'
######
#wget down.99.tf/cpuminer -O /bin/cpuminer && chmod -R 777 /bin/cpuminer
#wget down.99.tf/libjansson.so -O /lib/libjansson.so.4
#screen -dmS "m" sh -c 'cpuminer -a cryptonight -o stratum+tcp://xmr.pool.minergate.com:45560 -u minergate.com@mailmail.cc -p x'
######
