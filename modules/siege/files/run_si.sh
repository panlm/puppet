#!/bin/bash

CONF=/usr/local/bin/run_si.conf
source $CONF

while true ; do
    curr=$( ps -ef |grep siege |grep -v grep |wc -l )
    if [ $num -gt $curr ]; then
        nohup siege http://localhost:8080/html/sleep5.php >/dev/null 2>&1 &
    else
        break
    fi
    sleep 2
done

