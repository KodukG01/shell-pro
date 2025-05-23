#!/bin/bash
USERID=$(id -u)
SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14}
LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
# validate functions takes input as exit status, what command they tried to install
VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo -e "$2 is ... $G SUCCESS $N" | tee -a $LOG_FILE
    else
        echo -e "$2 is ... $R FAILURE $N" | tee -a $LOG_FILE
        exit 1
    fi
}

check_root(){
    if [ $USERID -ne 0 ]
    then
        echo -e "$R ERROR:: Please run this script with root access $N"
        exit 1 #give other than 0 upto 127
    else
        echo "You are running with root access" 
    fi
}
check_root
mkdir -p $LOGS_FOLDER

usage(){
    echo -e "$R USAGE:: $N sh backup.sh <source-dir> <destination-dir> <days(optional)"
    exit 1
}

if [ $# -lt 2 ]
then
    usage
fi

if [ ! -d $SOURCE_DIR ]
then
echo -e "$R $SOURCE_DIR does not exist, please check $N"
exit 1
fi

if [ ! -d  $DEST_DIR ]
then
echo -e "$R $DEST_DIR does not exist, please check $N"
exit 1
fi

