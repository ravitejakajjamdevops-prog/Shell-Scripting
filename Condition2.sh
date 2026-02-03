#!/bin/bash
id=$(id -u)
if [ $id -ne 0 ]
    echo "Pease run this with root user"
fi

dnf install nginx -y