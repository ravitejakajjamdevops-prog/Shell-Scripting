#!/bin/bash
start_time=$(date +%s)

echo " Script executed at $start_time"
sleep 10
end_time=$(date +%s)
echo "Script end time at $end_time"
total_time=$(($end_time-$start_time))
echo " Script executed in  $total_time seconds" 