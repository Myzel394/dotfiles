#!/bin/zsh

current_time=$(echo $(t now))

sheet=$(echo $current_time | cut -d ' ' -f 5)
time=$(echo $current_time | cut -d ' ' -f 6)
note=$(echo $current_time | cut -d ' ' -f 7)

echo "󱑁 $time ($note)  $sheet"

