#!/bin/bash

# Check if a window running tests already exists
tmux list-windows -F '#{window_index} #{window_name}' | grep -q "Tests"
if [ $? -eq 0 ]; then
    # If a window named "Tests" exists, switch to it
    tmux select-window -t "Tests"
else
    # If not, split the current window vertically and run your tests command
    tmux split-window -v 50 
tmux split-window -v "./gradlew build; sleep 10" 
fi
