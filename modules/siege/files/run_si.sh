#!/bin/bash

CONF=/usr/local/bin/run_si.conf
source $CONF

while true ; do
    curr=$( ps -ef |grep siege |grep -v grep |wc -l )
    if [ $num -gt $curr ]; then
        nohup siege http://localhost:8080/html/sleep5.php >/dev/null 2>&1 &
    elif [ $num -lt $curr ]; then
        a=$((curr-num))
        ps -ef |grep -v grep |grep siege |tail -n $a |awk '{print $2}' |xargs kill
        break
    else
        break
    fi
    sleep 2
done

