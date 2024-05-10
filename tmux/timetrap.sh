#!/bin/zsh

current_time=$(echo $(t now))

if [[ $current_time == "No running entries" ]]; then
    echo "󱑁 Not tracking"
    exit 0
fi

sheet=$(echo $current_time | cut -d ' ' -f 5)
time=$(echo $current_time | cut -d ' ' -f 6 | cut -d ':' -f -2)
note=$(echo $current_time | cut -d ' ' -f 7)

if [[ "$note" == "" ]]; then
    echo "󱑁 $time"
else
    echo "󱑁 $time ($note)"
fi

