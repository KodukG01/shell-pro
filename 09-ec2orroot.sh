#!/bin/bash
userid=$(id -u)
if [ $userid -ne o ]
then
echo "Error:: Run script with root access"
else
echo "You are running with root access"
fi
dnf install mysql -y

