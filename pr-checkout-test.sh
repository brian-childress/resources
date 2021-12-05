#! /bin/bash

# Pull Request(a.k.a. Peer-Review, PR) Checkout and Test
# This script is used to checkout and run basic tests (compile, etc.) before continuing with manual review
# Define the following variables:
GIT_REMOTE_URL=$(git config --get remote.origin.url);
LOCAL_REPO_DIRECTORY=$PWD;
TARGET_BRANCH=${2:-develop};

if [ -z "${1}" ]; 
    then echo "PR ID Number required"; exit 1; 
fi

if [ -z "$(git status --untracked-files=no --porcelain)" ]; then 
  # Working directory clean excluding untracked files
  echo "We clean, keep going";
else
  # Uncommitted changes in tracked files
  echo "Uncommited changes, please commit or stash before continuing";
  exit 1;
fi

NEW_BRANCH_NAME=PR_TEST_$1

cd $LOCAL_REPO_DIRECTORY

git branch -D $NEW_BRANCH_NAME

git fetch $GIT_REMOTE_URL pull/$1/head:$NEW_BRANCH_NAME

git checkout $NEW_BRANCH_NAME

ARRAY_FILES_CHANGED=$(git diff --name-only --diff-filter=AM origin/${TARGET_BRANCH}...HEAD)

echo
echo ==================================
echo Files changed:
echo ==================================
echo

( IFS=$'\n'; echo "${ARRAY_FILES_CHANGED[*]}" )

# Execute Linter, writing to a local log
echo
echo ==================================
echo "Running Linter"
echo ==================================
echo

yarn eslint --config .eslintrc.js $ARRAY_FILES_CHANGED > $(pwd)/eslint.log

echo
echo ==================================
echo Linter results: $(pwd)/eslint.log
echo ==================================
echo


# Rebuild/compile everything
echo
echo ==================================
echo "Does it compile?"
echo ==================================
echo

<command to test something>