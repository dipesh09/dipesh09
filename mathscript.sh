#!/bin/bash
# This script asks the user for 2 numbers, then does then
# 5 basic arithmetic opearations on those numbers


read -p "Enter a number " firstnum
read -p "Enter a second number " secondnum

total=$(($firstnum + $secondnum))
echo "$firstnum + $secondnum equals $total"

total=$(($firstnum - $secondnum))
echo "$firstnum - $secondnum equals $total"

total=$(($firstnum * $secondnum))
echo "$firstnum * $secondnum equals $total"

total=$(($firstnum / $secondnum))
echo "$firstnum / $secondnum equals $total"

remainder=$(($firstnum % $secondnum))
echo "$firstnum % $secondnum equals $remainder"
