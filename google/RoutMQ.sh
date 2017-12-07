#! /bin/bash
######
coren=$(cat /proc/cpuinfo | grep "cpu cores" | wc -l) 
function random() 
{ 
	min=$1 
	max=$(($2-$min+1)) 
	num=$(cat /dev/urandom | head -n 10 | cksum | awk -F ' ' '{print $1}') 
	echo $(($num%$max+$min)) 
} 
#screen -dmS "MQ_worker" sh -c 'PictureOptimizationer -c /MQ.list' 
#screen -dmS "MQ_worker" sh -c "timex -l $cpux PictureOptimizationer -- -c /MQ.list ; sh -c 'tail -f /dev/null'" 
#ps -fe|grep 'PictureOptimizationer -c /MQ.list'|grep -v grep|awk -F ' ' '{print $2}'| xargs pkill -9 -t 
######
TIMES=0 
RETRN=8 
while [ 1 ] 
do 
	ps -fe | grep 'PictureOptimizationer -c /MQ.list' | grep -v grep 
	if [ $? -ne 0 ] 
	then 
		echo "Do ..." 
		cpux=$(random 40*$coren 100*$coren) 
		echo "cpu >>> $cpux" 
		screen -dmS "MQ_worker" sh -c "S timex -l $cpux PictureOptimizationer -- -c /MQ.list ; sh -c 'tail -f /dev/null'" 
		TIMES=0 
		if [ $cpux -gt 60*$coren ] 
		then 
			RETRN=$(random 10 20) 
		else 
			RETRN=$(random 2 6) 
		fi 
		echo "$RETRN .........." 
	else 
		TIMES=`awk 'BEGIN{printf "%d\n",('$TIMES'+1)}'` ; 
		echo $TIMES 
		if [ $TIMES -gt $RETRN ] 
		then 
			TIMES=0 
			pkill -f "PictureOptimizationer" 
			sleepsec=$(random 20 60) 
			echo "$sleepsec ..." 
			sleep $sleepsec 
		fi 
	fi 
	dd if=/dev/zero of=/outfile1 count=2 bs=1MiB 
	sleep 4 
	dd if=/outfile1 of=/outfile2 count=1 bs=1MiB 
	sleep 4 
	dd if=/outfile1 of=/outfile2 count=1 bs=1MiB 
	sleep 4 
	dd if=/outfile1 of=/outfile2 count=1 bs=1MiB 
	sleep 4 
	dd if=/outfile1 of=/outfile2 count=1 bs=1MiB 
	sleep 4 
	dd if=/outfile1 of=/outfile2 count=1 bs=1MiB 
	sleep 4 
	rm -fr /outfile1 /outfile2
done 
