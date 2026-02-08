#!/bin/bash
AMI_Id=ami-0220d79f3f480ecf5
SG_ID=sg-03773a885c8092230
ZONE_ID=Z07830142KGV9AKQPOKXW
$DOMAIN_NAME=kajjam.online

for instance in $@
do
    Instance_ID=$( aws ec2 run-instances \
    --image-id $AMI_Id \
    --instance-type t3.micro \
    --security-group-ids $SG_ID \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance}]" \
    --query 'Instances[0].InstanceId' \
    --output text )
    echo "Instance Id is $Instance_ID"
    if [ $instance == "frontend" ];then
        IP=$( 
            aws ec2 describe-instances \
 	        --instance-ids $Instance_ID \
	        --query 'Reservations[].Instances[].PublicIpAddress' \
	        --output text 
        )
        RECORD_NAME=$DOMAIN_NAME
    else
        IP=$( 
            aws ec2 describe-instances \
 	        --instance-ids $Instance_ID \
	        --query 'Reservations[].Instances[].PrivateIpAddress' \
	        --output text

        )
        RECORD_NAME=$instance.$DOMAIN_NAME
    fi
    echo "IP address: $IP"

    aws route53 change-resource-record-sets \
    --hosted-zone-id $ZONE_ID \
    --change-batch '
        {
            "Comment": "Update record to reflect new IP address",
            "Changes": [
                {
                "Action": "UPSERT",
                "ResourceRecordSet": {
                    "Name": "'$RECORD_NAME'",
                    "Type": "A",
                    "TTL": 1,
                    "ResourceRecords": [
                    {
                        "Value": "'$IP'"
                    }
                        ]
                    }
                }
            ]
        }
        '
    echo "Record updated for $instance"
    done    