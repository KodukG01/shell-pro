#!/bin/bash
USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOGS_FOLDER="/var/log/roboshop-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log" | tee -a $LOG_FILE

mkdir -p $LOGS_FOLDER
echo "Script started running at $(date)" | tee -a $LOG_FILE

if [ $USERID -ne 0 ]
then
echo -e "$R ERROR:: Please run with root access $N" | tee -a $LOG_FILE
exit 1
else
echo -e "Running with root access" | tee -a $LOG_FILE
fi

VALIDATE(){
    if [ $1 -eq 0 ]
    then
    echo -e "$2 is......$G Success $N" | tee -a $LOG_FILE
    else
    echo -e "$2 is.......$R Failure $N" | tee -a $LOG_FILE
    exit 1
    fi  
}
cp mongo.repo /etc/yum.repos.d/mongo.repo &>>$LOG_FILE
VALIDATE $? "Copying mongo.repo

dnf install mongodb-org -y &>>$LOG_FILE
VALIDATE $? "Installing mongodb"

systemctl enable mongod &>>$LOG_FILE
systemctl start mongod &>>$LOG_FILE
VALIDATE $? "Enable and Start mongodb"

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf &>>$LOG_FILE
VALIDATE $? "Editing MongoDB conf file for remote connections"

systemctl restart mongod &>>$LOG_FILE
VALIDATE $? "Restarting MongoDB"