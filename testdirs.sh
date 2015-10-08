#!/bin/bash

# This script demonstrates parsing the command line
# created 2015-10-08 by Dipesh

# we accept -h|--help, -a|--auto, -d|--debug level
# we require directory1, directory2

# --auto should set a variable
# --debug should save a level in a variable
#      level must be given and is expected to be a number between 1 and 3 inclusive
# --help should print out a syntax diagram

# both directories must exist
# if the user doesn't give 2 directories, ask for them using read

# if the command given was invalid,
#       print out an error and exit with a status 2
# otherwise display the arguments given by the user

########################
#
# Variables
#
########################

# save my program name for later use in the script
progname=$(basename "$0")

# set default values for the auto and debug variables
auto="OFF"  # Default setting for auto is OFF
debug=0  # Default setting for debug is 0, no debug

########################
#
# Functions
#
########################


function printoutusage {
            echo "Usage: $progname [-a|--auto] [-h|--help] [-d|--debug level] directory1 directory2"
}

function errormessage {
    echo "ERROR! - $1" >&2
}

########################
#
# Command Line Processing
#
########################


# process the command line, one argument at a time
while [ $# -gt 0 ]; do # Loop for as long as we still have stuff on the command line
    case "$1" in # Examine the first argument on the command line
    -h|--help )
        printoutusage
        exit
        ;;
    -a|--auto )
        auto="ON" # set auto mode
        ;;
    -d|--debug )
        if [ -n "$2" ]; then # we have a debug level specified
            if "$2" -ge 1 && "$2" -le 3 ]; then
                debug="$2"
            else
                errormessage "Debug level must be between 1 and 3 inclusive"
                exit 2
            fi
        fi
        shift
        ;;
    * )
        if [ ! -v dir1 ]; then # if we don't have a directory 1 yet, this must be it
            dir1="$1"
        elif [ ! -v dir2 ]; then # we had a dir1, but no dir2, this must be it
            dir2="$1"
        else # we already had both directories,
             # don't know what this steaming pile of argument is supposed to be
            errormessage "$(printoutusage)"
            exit 2
        fi
        ;;
    esac # end of examine the first argument on the command line
    shift    # move the command line left one field so that the next arg is in $1
done # end of command line processing loop

if [ ! -d "$dir1" ]; then
# handle not being given the first directory on the command line
    read -p "Directory 1: " dir1  # Ask for the first directory
    if [ ! -d "$dir1" ]; then     # Make sure we got one and that it exists
        errormessage "I'm sorry, Dave. I cannot do that without a directory 1"
        printoutusage
        exit 2 # Give up with an exit status of 2 if we can't get this yoyo
               #     to give us a valid directory
    fi
    read -p "Directory 2: " dir2  # Ask for the second directory
    if [ ! -d "$dir2" ]; then     # Make sure we got one and that it exists
        errormessage "I'm sorry, Dave. I cannot do that without a directory 2"
        printoutusage
        exit 2 # Give up with an exit status of 2 if we can't get this yoyo
               #     to give us a valid directory
    fi
fi

if [ ! -d "$dir2" ]; then
# handle not being given the second directory on the command line
    read -p "Directory 2: " dir2
    if [ ! -d "$dir2" ]; then
        errormessage "I'm sorry, Dave. I cannot do that without a directory 2"
        printoutusage
        exit 2
    fi
fi

########################
#
# Main
#
########################


# Print out a summary of what the user has asked to work with
echo "You asked for me to work on '$dir1' and '$dir2'"
echo "Auto mode is $auto"
echo "Debug level is $debug"