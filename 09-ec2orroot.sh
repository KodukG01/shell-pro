#!/bin/bash
userid=$(id -u)
if [ $userid -ne o ]
then
echo "Error:: Run script with root access"
exit 1 #other than '0' any thing can be given
else
echo "You are running with root access"
fi
dnf install mysql -y

