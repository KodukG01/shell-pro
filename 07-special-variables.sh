#!/bin/bash

echo "To get all variables passed into script: $@"
echo "Number of variable: $#"
echo "script name: $0"
echo "Current directory: $PWD"
echo "User running: $USER"
echo "Home directory: $HOME"
echo "PID of current script: $$"
echo "Last command in background: $!"
