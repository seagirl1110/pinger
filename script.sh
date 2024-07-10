#!/bin/bash
address='google.com'
max_ping_time=100
failures=0
max_failures=3

while true
do
	ping_time=$(ping -c 1 $address | grep 'icmp_seq' | awk -F'=' {'print $4'} | awk -F'.' {'print $1'})	
	
	if [ -n $ping_time ] && [ $ping_time -gt $max_ping_time ]; then
		echo "Пинг $address превышает $max_ping_time мс: пинг составил $ping_time мс"
	fi

	if [ -z $ping_time ]; then
		(( failures++ ))
	else 
		echo "Пинг $address успешен: $ping_time мс"
		failures=0
	fi

	if [ $failures -gt $max_failures ]; then
		echo 'Превышено максимальное количество неудачных попыток'
		failures=0
	fi

	sleep 1
done
