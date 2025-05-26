#!/bin/bash

DISK_USAGE=$(df -hT | grep -v Filesystem)
DISK_THRESHOLD=1 #In project it will be 75%

while read -r line
do
    USAGE=$(echo $line | awk '{print $6F}' | cut -d "%" -f1)
    PARTITION=$(echo $line | awk '{print $7F}')
    echo "$PARTITION: $USAGE"
    if [ $USAGE -ge $DISK_THRESHOLD ]
    then
        MSG="High Disk Usage on $PARTITION: $USAGE"
    fi


done <<< $DISK_USAGE

echo $MSG   
