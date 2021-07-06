#! /bin/bash


# Pull Request(a.k.a. Peer-Review, PR) Checkout and Test
# This script is used to checkout and run basic tests (compile, etc.) before continuing with manual review
# Define the following variables:
GIT_REMOTE_URL='' # git@github.com:.....
LOCAL_REPO_DIRECTORY='' # /Users/ckent/code
COMMAND_TO_EXECUTE='' # npm run test

if [ -z "${1}" ]; 
    then echo "PR ID Number required"; exit 1; 
fi

NEW_BRANCH_NAME=PR_TEST_$1

cd $LOCAL_REPO_DIRECTORY

git stash

git branch -D $NEW_BRANCH_NAME

git fetch $GIT_REMOTE_URL pull/$1/head:$NEW_BRANCH_NAME

git checkout $NEW_BRANCH_NAME

$COMMAND_TO_EXECUTE
