#!/bin/bash
LOGS_FOLDER=/var/log/shell-Roboshop
LOGS_FILE=/var/log/shell-Roboshop/$0.log
mkdir -p /var/log/shell-Roboshop
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

cp mongo.repo /etc/yum.repos.d/
Validation $? "Copying Mongo.repo file"
dnf install mongodb-org -y 
Validation $? "Installing DB server"
systemctl enable mongod 
systemctl start mongod 
Validation $? "Restarted and enabled Services"
sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
systemctl restart mongod
Validation $? "Restarted services"