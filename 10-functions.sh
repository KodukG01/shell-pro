#!/bin/bash
userid=$(id -u)
if [ $userid -ne 0 ]
then
echo "Error:: Run script with root access"
exit 1 #other than '0' any thing can be given
else
echo "You are running with root access"
fi
VALIDATE() {
    if [ $1 -eq 0 ]
then
echo "Installation of $2 is ......Success"
else
echo "Installation of $2 is ......Failure"
exit 1
fi 
}
dnf list installed mysql

if [ $? -ne 0 ]
then 
echo "Mysql is not installed and going to install it"
dnf install mysql -y
VALIDATE $? "MYSQL"
else
echo "MySql is already installed nothing to do"

fi
dnf list installed python3
if [ $? -ne 0 ]
then 
echo "Python3 is not installed and going to install it"
dnf install Python3 -y
VALIDATE $? "Python3"
else
echo "Python3 is already installed nothing to do"

fi

if [ $? -ne 0 ]
then 
echo "Nginx is not installed and going to install it"
dnf install mysql -y
VALIDATE $? "NGINX"
else
echo "Nginx is already installed nothing to do"

fi

