#!/bin/bash
LOGS_FOLDER=/var/log/shell-scripting
LOGS_FILE=/var/log/shell-scripting/$0.log
mkdir -p /var/log/shell-scripting
id=$(id -u)
if [ $id -ne 0 ];then
    echo "Pease run this with root user"
    exit 1
fi

Validation (){
    if [ $1 -ne 0 ] ; then
        echo "$2 ...Failure"
        exit 1
    else
        echo "$2....success"
    fi

}

for package in $@
do 
    dnf install $package -y &>> $LOGS_FILE
    Validation $? "Installing $package" 

done
