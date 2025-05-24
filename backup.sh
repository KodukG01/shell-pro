#!/bin/bash

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:14}

LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $? | cut -d "." -f1)
LOG_FILE=$LOGS_FOLDER/$SCRIPT_NAME.log
USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"

check_root(){
if [ $USERID -ne 0 ]
then
    echo "$R ERROR::Please run with root access $N"
    exit 1
else
    echo "Running with root access"
fi
}

VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo "$G $2..... successful $N"
    else
        echo "$R $2..... Failed $N"
        exit 1
    fi    
}

check_root

mkdir -p $LOGS_FOLDER

USAGE(){
     echo -e "$R USAGE:: $N sh backup.sh <source-dir> <destination-dir> <days(optional)>"
    exit 1
}

if [ $# -lt 2 ]
then
    USAGE
fi

if [ ! -d $SOURCE_DIR ]
then
    echo -e "$R  $SOURCE_DIR doesnt exist please check"
    exit 1
fi

if [ ! -d $DEST_DIR ]
then
    echo -e "$R $DEST_DIR doesnt exist please check"
fi




