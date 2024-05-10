#!/bin/bash

#arguments:
label=$1
num_reps=$2
query=$3
db_file=$4
output=$5


#start time
start_time=$(date +%s)
#run loop
i=0
while [ $i -lt "$num_reps" ]; do
     #duckdb
      .open "$db_file" "$query" >& /dev/null
      i=$((i+1))
done

#end time
end_time=$(date +%s)

#elapsed_time
elapsed=$((end_time - start_time))

#divide elapsed time by num_reps
time_per_reps=$(echo "scale=5; $elapsed/$num_reps"| bc)

#write to csv file
echo "$label", "$time_per_reps" >> "$output"
