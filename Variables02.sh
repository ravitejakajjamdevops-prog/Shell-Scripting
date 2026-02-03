#!/bin/bash
start_time=$(date +%s)
end_time=$(date +%s)
echo " Script executed at $start_time"
sleep 15
echo "Script end time at $end_time"
total_time=$(($start_time - $end_time))
echo " Script total time is $total_time"