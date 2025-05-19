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
echo "Script started executng at $(date)" | tee -a $LOG_FILE
if [ $USERID -ne 0 ]
then
echo -e "$R ERROR:: $N please run with root access"  | tee -a $LOG_FILE
if [ $USERID -ne 0 ]
exit 1
else
echo "Running with with root access"  | tee -a $LOG_FILE
if [ $USERID -ne 0 ]
fi
VALIDATE(){
    if [ $1 -eq 0 ]
    then
    echo -e "Installing $2 is ....$G Success $N"  | tee -a $LOG_FILE
if [ $USERID -ne 0 ]
    else
    echo -e "Installing $2 is .... $R Failure $N"  | tee -a $LOG_FILE
if [ $USERID -ne 0 ]
    fi
}
dnf list installed mysql -y
if [ $? -ne 0 ]
then
echo "MYSQL is not installed: Installing MYSQL"  | tee -a $LOG_FILE
if [ $USERID -ne 0 ]
dnf install mysql -y
VALIDATE $? "MYSQL"
else
echo -e "$G MYSQL is already installed, Nothing to do $N"  | tee -a $LOG_FILE
if [ $USERID -ne 0 ]
fi
 
