#!/bin/bash
USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE=/$LOGS_FOLDER/$SCRIPT_NAME.log
SOURCE_DIR=/home/ec2-user/app-logs

mkdir -p $LOGS_FOLDER

echo "Script started executing at $(date)" | tee -a $LOG_FILE

if [ $USERID -ne 0 ]
then
    echo "$R ERROR:: Please run with root access $N" | tee -a $LOG_FILE
    exit 1
else
    echo "Running with root access"
fi

VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo "$G $2.....Success $N" | tee -a $LOG_FILE
    else
        echo "$R $2......Failed $N" | tee -a $LOG_FILE
        exit 1
    fi
}

FILES_TO_DELETE=$(find . -name "*.log" -mtime +14)

while IFS= read -r filepath
do
    echo "Deleting file path:$filepath" | tee -a $LOG_FILE
    rm -rf $filepath
done <<< $FILES_TO_DELETE

echo "script executed successfully"