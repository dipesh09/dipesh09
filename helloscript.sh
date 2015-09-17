#!/bin/bash

# This script prints out hello world in an ugly way
# This was written by Dipesh Patel

echo -n "helb wold" |sed -e "s/b/o/g" -e "s/l/ll/" -e "s/ol/orl/" |tr "h" "H"|tr "w" "W"

