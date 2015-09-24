#!/bin/bash
# simple script to list out the ditails of setuid
# and setgid files on the system

echo "These are the setuid files I found"
echo "====================================="
find / -perm -4000 -type f -exec ls -l {} \;


echo 
echo "These are the setgid files I found"
echo "====================================="

find / -perm -2000 -type f -exec ls -l {} \;