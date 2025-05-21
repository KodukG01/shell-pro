#!/bin/bash
USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOGS_FOLDER="/var/log/roboshop-log"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"
$SCRIPT_DIR=$PWD
START_TIME=$(date)
mkdir -p $LOGS_FOLDER

echo "Script execution starts at $START_TIME" | tee -a $LOG_FILE

if [ $UserID -ne 0 ]
then
echo -e "$R ERROR:: Please run script with root access $N"
exit 1
else
echo -e "Running with root access"
fi

VALIDATE() {
    if [ $1 -eq 0 ]
    then
    echo -e "$2.....$G Success $N" | tee -a $LOG_FILE
    else
    echo -e "$2.....$R Failure $N" | tee -a $LOG_FILE
    exit 1
    fi
}

dnf module disable redis -y &>>$LOG_FILE
VALIDATE $? "Disable redis"

dnf module enable redis:7 -y &>>$LOG_FILE
VALIDATE $? "Enable redis"

dnf install redis -y &>>$LOG_FILE
VALIDATE $? "Installing redis"

sed -i -e 's/127.0.0.1/0.0.0.0/g' -e '/protected-mode/ c protected-mode no' /etc/redis/redis.conf 
VALIDATE $? "Allowing access for remote connection" 

systemctl enable redis 
VALIDATE $? "Enabling redis" &>>$LOG_FILE

systemctl start redis 
VALIDATE $? "Starting redis" &>>$LOG_FILE

END_TIME=$(date +%s)
TOTAL_TIME=$(( $END_TIME - $START_TIME )) | tee -a $LOG_FILE

echo -e "Script executed successfully, $Y time taken: $TOTAL_TIME"

