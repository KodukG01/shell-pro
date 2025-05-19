#!/bin/bash
UserID=$(id -u)
if [ $UserID -ne 0 ]
then
echo "ERROR:: Please run this script using root access"
exit 1 #Gives anything otherthan 0 upto 127
else
echo "You are running with root credentials"
fi
dnf list installed mysql

# Check weather mysql is installed or not

if [ $? -ne 0 ]
then
echo "MYSQL is not installed"
echo "Installing MYSQL"
dnf install mysql -y
if [ $? -eq 0]
then
echo "MYSQL installed successfully"
else
echo "Failed to install MYSQL"
fi
else
echo "MYSQL installed successfully nothing to do"
fi
