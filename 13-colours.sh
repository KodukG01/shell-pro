#!/bin/bash
USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[34m"
N="\e[0m"
if [ $USERID -ne 0 ]
then
echo -e "$R ERROR:: $N please run with root access"
exit 1
else
echo "Running with with root access"
fi
VALIDATE(){
    if [ $1 -eq 0 ]
    then
    echo -e "Installing $2 is ....$G Success $N"
    else
    echo -e "Installing $2 is .... $R Failure $N"
    fi
}
dnf list installed mysql -y
if [ $? -ne 0 ]
then
echo "MYSQL is not installed: Installing MYSQL"
dnf install mysql -y
VALIDATE $? "MYSQL"
else
echo -e "$G MYSQL is already installed, Nothing to do $N"
fi
 
