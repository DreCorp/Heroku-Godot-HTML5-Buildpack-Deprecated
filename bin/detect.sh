#!/bin/bash

# Usage:
# bin/detect BUILD_DIR

# As per Heroku Buildpack Api 2022
# This script takes BUILD_DIR as a single argument 
# and must return an exit code of 0 
# if the app present at BUILD_DIR can be serviced by this buildpack. 
# If the exit code is 0, the script must print a human-readable framework name to stdout

# Check if project.godot exists in the repo
if [ -f $1/project.godot ]
then
    echo "Godot"
    exit 0
# Exit with error code
else
    exit 1
fi
