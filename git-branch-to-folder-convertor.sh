#!/bin/bash
# Author: Brian Childress, brian@brianchildress.co, 2019

# The GIT branch to folder convertor allows you to manage course content using git branches for logical separation
# Once each branch is ready for distribution, use this script to locate all branches and generate
# a folder structure that matches the branch name

# Example branch name: feature1__start, feature1__finish, feature2__start, feature2__finish
# Will create the following folders:
# | feature1
# | -- finish
# | -- start
# | feature2
# | -- finish
# | -- start

# Getting Started:
# 1. cd to directory of repository
# 2. Create git branches to match your intended folder stucture, commit all changes to each branch
# 3. Execute script against GIT repository
# 4. Execute script as needed, each execution will remove previous versions

# Parameters:
BASE_DIR=${BASE_DIR/temp-folder:-$PWD/temp-folder} #"<absolute path to location to store result>" creating a temp-folder to avoid future disaster
BEGINNING_DIRECTORY_NAME=${BEGINNING_DIRECTORY_NAME:-start} # Name of directory in GIT branch following seperator
BEGINNING_DIRECTORY_NAME_MKDIR=${BEGINNING_DIRECTORY_NAME_MKDIR:-start} # Name of directory to make
BRANCH_SEPERATOR=${BRANCH_SEPERATOR:-__} # Branch --> folder delimiter
ENDING_DIRECTORY_NAME=${ENDING_DIRECTORY_NAME:-finish} # Name of directory in GIT branch following seperator
ENDING_DIRECTORY_NAME_MKDIR=${ENDING_DIRECTORY_NAME_MKDIR:-finish} # Name of directory to make
FILES_TO_EXCLUDE="--exclude node_modules --exclude .git --exclude $BASE_DIR --exclude .gitignore --exclude mkdir.sh"
WORDTOREMOVE="refs/heads/" # Leading string in branch name

# Using Named Bash Parameters optionally, default values are assigned above
# Above parameters allow for overriding
# Accept default values OR override, e.g. --BASE_DIR <path to base directory>
# Explaination of named bash parameters available here: https://brianchildress.co/named-parameters-in-bash/

while [ $# -gt 0 ]; do

   if [[ $1 == *"--"* ]]; then
        v="${1/--/}"
        declare $v="$2"
   fi

  shift
done

# Begin script

## Clean up base directory, before recreating
rm -rf $BASE_DIR
branches=()

eval "$(git for-each-ref --shell --format='branches+=(%(refname))' refs/heads/)"

for branch in "${branches[@]}"; do

    BRANCHNAME=${branch//$WORDTOREMOVE/}
    git checkout $BRANCHNAME

    MODIFIED_BRANCHNAME=$(echo $BRANCHNAME | tr $BRANCH_SEPERATOR "\n")
    BRANCH_BASEDIR=''

    for i in $MODIFIED_BRANCHNAME; do

      if [ "$i" == "$BEGINNING_DIRECTORY_NAME" ]; then
        mkdir -p $BASE_DIR/$BRANCH_BASEDIR/$BEGINNING_DIRECTORY_NAME_MKDIR
        rsync -av --progress . $BASE_DIR/$BRANCH_BASEDIR/$BEGINNING_DIRECTORY_NAME_MKDIR $FILES_TO_EXCLUDE
      elif [ "$i" == "$ENDING_DIRECTORY_NAME" ]; then
        mkdir -p $BASE_DIR/$BRANCH_BASEDIR/$ENDING_DIRECTORY_NAME_MKDIR
        rsync -av --progress . $BASE_DIR/$BRANCH_BASEDIR/$ENDING_DIRECTORY_NAME_MKDIR $FILES_TO_EXCLUDE
      else
        BRANCH_BASEDIR=$i
      fi

    done

done
