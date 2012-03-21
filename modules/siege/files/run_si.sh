#!/bin/bash

CONF=/usr/local/bin/run_si.conf
source $CONF

while true ; do
    curr=$( ps -ef |grep siege |grep -v grep |wc -l )
    if [ $num -gt $curr ]; then
        nohup siege -c 300 -d 1 http://localhost:8080/html/sleep5.php &
    else
        break
    fi
    sleep 2
done

