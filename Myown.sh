#!/bin/bash
Number=$1
Rem=$((Number % 2))

if [ $Rem -eq 0 ];then

    echo "Given number $Number is even number"

else

    echo "Given number $Number is odd number"

fi    