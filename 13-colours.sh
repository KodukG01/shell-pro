#!/bin/bash
USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[34m"
N="\e[0m"
LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE=$LOGS_FOLDER/$SCRIPT_NAME.log
mkdir -p $LOGS_FOLDER
echo "Script started executng at $(date)" &>>$LOG_FILE
if [ $USERID -ne 0 ]
then
echo -e "$R ERROR:: $N please run with root access" &>>$LOG_FILE
exit 1
else
echo "Running with with root access" &>>$LOG_FILE
fi
VALIDATE(){
    if [ $1 -eq 0 ]
    then
    echo -e "Installing $2 is ....$G Success $N" &>>$LOG_FILE
    else
    echo -e "Installing $2 is .... $R Failure $N" &>>$LOG_FILE
    fi
}
dnf list installed mysql -y
if [ $? -ne 0 ]
then
echo "MYSQL is not installed: Installing MYSQL" &>>$LOG_FILE
dnf install mysql -y
VALIDATE $? "MYSQL"
else
echo -e "$G MYSQL is already installed, Nothing to do $N" &>>$LOG_FILE
fi
 
