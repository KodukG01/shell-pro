#!/bin/bash
USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOGS_FOLDER="/var/log/roboshop-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

mkdir -p $LOGS_FOLDER
echo "Script started executing at: $(date)" | tee -a $LOG_FILE

if [ $USERID -ne 0 ]
then
echo -e "$R ERROR:: Please run the script with root access $N" | tee -a $LOG_FILE
exit 1
else
echo -e "Running script with root access" | tee -a $LOG_FILE
fi

VALIDATE() {
    if [ $1 -eq 0 ]
    then
    echo -e "$2 is ......$G SUCCESS $N" | tee -a $LOG_FILE
    else
    echo -e "$2 is ...... $ Failed $N" | tee -a $LOG_FILE
    exit 1
    fi
}
cp mongodb.repo /etc/yum.repos.d/mongo.repo
VALIDATE $? "Copying mongodb repo"

dnf install mongodb-org -y &>>$LOG_FILE
VALIDATE $? "Installing mongodb"

systemctl enable mongod &>>$LOG_FILE
VALIDATE $? "Enabling mongodb"

systemctl start mongod &>>$LOG_FILE
VALIDATE $? "Starting mongodb"

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf &>>$LOG_FILE
VALIDATE $? "Editing mongod.conf for remote connection"

systemctl restart mongod &>>$LOG_FILE
VALIDATE $? "Restarting mongodb" 


