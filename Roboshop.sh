#!/bin/bash
AMI_Id=ami-0220d79f3f480ecf5
SG_ID=sg-03773a885c8092230

for instance in $@
do
    Instance_ID=$( aws ec2 run-instances \
    --image-id $AMI_Id \
    --instance-type t3.micro \
    --security-group-ids $SG_ID \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance}]" \
    --query 'Reservations[0].Instances[0].InstanceID' \
    --output text )
    echo "Instance Id is $Instance_ID"
    if [ $instance == "frontend" ];then
        IP=$( 
            aws ec2 describe-instances \
 	        --instance-ids $Instance_ID \
	        --query 'Reservations[].Instances[].PublicIpAddress' \
	        --output text 
        )
    else
        IP=$( 
            aws ec2 describe-instances \
 	        --instance-ids $Instance_ID \
	        --query 'Reservations[].Instances[].PrivateIpAddress' \
	        --output text

        )

    fi
    echo "IP address: $IP"
done    