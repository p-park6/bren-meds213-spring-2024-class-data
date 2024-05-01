#!/bin/bash     #always needed at the beginning of a bash script

for file in *.csv; do
    echo "$file has $(wc -l < $file) lines" #aka 'this file has x amount of rows'
done

# to run the bash script run in terminal: bash `filename.sh`