#! /bin/bash
# Switch to "base" branch. This is the branch that will be evaluated for all branches that have been "merged" into it

TARGET_BRANCH=${1:-develop};

git checkout $TARGET_BRANCH

git pull

git branch -r --merged | grep -i -v -E "main$|develop$|ci$|qa$|prod$" | sed 's/origin\///' | xargs -n 1 git push origin --delete
