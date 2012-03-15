#!/bin/bash

max=4

while true ; do

num=$( ps -ef |grep siege |grep -v -e grep -e run_siege |wc -l )
if [ $num -le $max ]; then
    siege -c 300 -d 1 http://localhost:8080/html/sleep5.php &
fi
sleep 10

done




