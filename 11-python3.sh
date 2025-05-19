#!/bin/bash
USERID=$(id -u)
if [ $USERID -ne 0 ]
then
echo "ERROR:: Please run the script with root access"
exit 1
else
echo "Running script with root access"
fi
dnf list installed python3
if [ $? -ne 0 ]
then
echo "Python3 is not installed"
echo "Installing python3"
dnf install python3 -y
if [ $? -eq 0 ]
then
echo "Python3 installed successfully"
else
echo "Python3 installation failed"
exit 1
fi
else
echo "Pyhthon3 is installed nothing to do"
fi
