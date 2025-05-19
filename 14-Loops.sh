#!/bin/bash
USERID=$(id -u)
R="\e[31m"
G="\e[32m"
N="\e[0m"
LOGS_FOLDER="/var/logs/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"
Packages=("mysql" "python3" "nginx" "httpd")

mkdir -p $LOGS_FOLDER
 echo "Script started executing at $(date)" | tee -a $LOG_FILE

 if [ $USERID -ne 0 ]
 then
 echo -e "ERROR:: $R Please execute in root mode $N" | tee -a $LOG_FILE
 exit 1
 else
 echo "Running with root access" | tee -a $LOG_FILE
 fi
VALIDATE(){
    if [ $1 -eq 0 ]
    then
    echo -e "Installing $2 is successful" | tee -a $LOG_FILE
    else
    echo -e "Installing $2 is failure" | tee -a $LOG_FILE
    exit 1
    fi
 }
for Packages in $@
do
dnf installed list $Packages &>>$LOG_FILE
if [ $? -ne 0 ]
then
echo "Install packages"
dnf install $packages -y &>>$LOG_FILE | tee -a $LOG_FILE
VALIDATE $? "$Packages"
else
echo "Nothing to do all packages are installed successfully" | tee -a $LOG_FILE
fi 
done




