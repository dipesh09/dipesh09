#!/bin/bash
# This script prints out my my welcome message
# The message looks like welcome to planet hostname, title name!
# Today is weekday.


myhostname=`hostname`
mytitle="Networking is Everything"
myname="Dipesh"
weekday=$(date +%A)
echo "Welcome to planet $myhostname, $mytitle $myname!"
echo "today is $weekday"

