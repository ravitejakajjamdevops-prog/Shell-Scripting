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

dnf module disable nodejs -y
Validation $? "Disabling NodeJS"
dnf module enable nodejs:20 -y
Validation $? "Enabling NodeJS"
dnf install nodejs -y 
Validation $? "Installing NodeJs"
id roboshop
if [ $? -ne 0 ];then
    useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop
    Validation $? "Creating system user"
else

    echo "User roboshop already exists"
fi

mkdir /app 
Validation $? "Creating app directory"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip 
Validation $? "Downloading Catalogue code"
cd /app 
unzip /tmp/catalogue.zip
cd /app 
npm install 

cp /home/ec2-user/Shell-Scripting/Shell-roboshop/Catalogue.service /etc/systemd/system

systemctl daemon-reload

systemctl enable catalogue 
systemctl start catalogue

# cp mongo.repo /etc/yum.repos.d/

# dnf install mongodb-mongosh -y

# mongosh --host mongodb.kajjam.online </app/db/master-data.js



