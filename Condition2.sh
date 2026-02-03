#!/bin/bash
id=$(id -u)
if [ $id -ne 0 ];then
    echo "Pease run this with root user"
    exit 1
fi

dnf install nginx -y

if [ $? -ne 0 ] ; then
    echo " Installing nginx ...Failure"
else
    echo "Installing nginx....success"
fi
