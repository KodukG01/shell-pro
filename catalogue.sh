#!/bin/bash
USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOGS_FOLDER="/var/log/roboshop-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"
SCRIPT_DIR=$PWD

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
dnf module disable nodejs -y
VALIDATE $? "Disabling nodejs" &>>$LOG_FILE

dnf module enable nodejs:20 -y
VALIDATE $? "Enable nodejs:20" &>>$LOG_FILE

dnf install nodejs -y
VALIDATE $? "Installing nodeJs"

useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop &>>$LOG_FILE
VALIDATE $? "Creating user roboshop"

mkdir -p /app
VALIDATE $? "Create app directory"

curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip &>>$LOG_FILE
VALIDATE $? "Downloading cataloge"

cd /app
unzip /tmp/catalogue.zip &>>$LOG_FILE
VALIDATE $? "Change directory and unzip"

npm install &>>$LOG_FILE
VALIDATE $? "Installing Depenencies"

cp $SCRIPT_DIR/catalogue.service /etc/systemd/system/catalogue.service &>>$LOG_FILE
VALIDATE $? "Copying catalog.service"

systemctl daemon-reload
systemctl enable catalogue &>>$LOG_FILE
systemctl start catalogue &>>$LOG_FILE
VALIDATE $? "Start catalogue"

cp $SCRIPT_DIR/mongodb.rep /etc/yum.repos.d/mongodb.repo
dnf install mongodb-mongosh -y &>>$LOG_FILE
VALIDATE $? "Installing mongodb"

mongosh --host mongodb.devsecops.fun </app/db/master-data.js &>>$LOG_FILE