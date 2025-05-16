#!/bin/bash
userid=$(id -u)
if [ $userid -ne 0 ]
then
echo "Error:: Run script with root access"
exit 1 #other than '0' any thing can be given
else
echo "You are running with root access"
fi
dnf list installed mysql
if [ $? -ne 0 ]
then 
echo "Mysql is not installed and going to install it"
dnf install mysql -y
if [ $? -eq 0 ]
then
echo "Installation of MYSQL is ......Success"
else
echo "Installation of MYSQL is ......Failure"
exit 1
fi
else
echo "MySql is already installed nothing to do"
exit 1
fi