#!/bin/bash
USERID=$(id -u)
if [ $USERID -ne 0 ]
then
echo "ERROR:: Please run with root access"
exit 1
else
echo "Running script with root access"
fi

VALIDATE(){
    if [ $1 -eq 0 ]
    then
    echo "Installing $2 is success"
    else
    echo "Installing $2 is failure"
    exit 1
    fi

}

dnf list installed mysql
if [ $? -ne 0 ]
then
echo "MYSQL not installed, Installing it"
dnf install mysql -y
VALIDATE $? "MYSQL"
else
echo "MYSQL is installed nothing to do"
fi
dnf list installed python3
if [ $? -ne 0 ]
then
echo "Python3 not installed, Installing it"
dnf install python3 -y
VALIDATE $? "PYTHON3"
else
echo "Python3 installed nothing to do"
fi
dnf list installed nginx
if [ $? -ne 0 ]
then
echo "nginx not installed, Installing it"
dnf install nginx -y
VALIDATE $? "NGINX"
else
echo "nginx installed, nothing to do"
fi
echo "Check status of nginx"
systemctl status nginx
if [ $? -ne 0 ]
then
echo "NGINX is not running, starting it"
systemctl start nginx
else
echo "NGINX is running"
fi