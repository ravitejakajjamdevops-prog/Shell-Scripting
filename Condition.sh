#!/bin/bash
Number1=$1
if [ $Number1 -lt 30 ];then
    echo "Given number is less than 30 "
elif [$Number1 -eq 30 ];then
    echo "Given number is euqls to 30"    
else
    echo "Given number is grater than 30" 
fi    