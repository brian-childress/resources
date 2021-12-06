#! /bin/bash
# May be useful: https://stackoverflow.com/questions/10325599/delete-all-branches-that-are-more-than-x-days-weeks-old
# Removing part of leading string: https://stackoverflow.com/a/13788200
# https://hackerific.net/2016/08/26/cleaning-git-branches/
# https://git-scm.com/docs/pretty-formats

SCRIPT_DIR="./Scripts"

rm ${SCRIPT_DIR}/*.csv
echo "AUTHOR,LAST_COMMIT,BRANCH" >> ${SCRIPT_DIR}/merged-branches-older-than-month.csv
echo "AUTHOR,LAST_COMMIT,BRANCH" >> ${SCRIPT_DIR}/not-merged-branches-younger-than-month.csv
echo "AUTHOR,LAST_COMMIT,BRANCH" >> ${SCRIPT_DIR}/not-merged-branches-older-than-month.csv

# All branches that have NOT been merged into develop
for k in $(git branch -a --no-merged develop | sed /\*/d | sed 's/^remotes\///' | grep -v 'master$' | grep -v 'qa$' | grep -v 'develop$' | grep -v 'demo$'); do 
# All branches that have not received a commit for a month, AKA stale branches
    USER=$(git log -1 --pretty=format:"%cn" -s $k)
    DATE=$(git log -1 --date=short --pretty=format:"%cd" -s $k)
    BRANCH=${k##*/}
  if [ -n "$(git log -1 --after='1 month ago' -s $k --)" ]; then
    echo $USER,$DATE,$BRANCH >> ${SCRIPT_DIR}/not-merged-branches-younger-than-month.csv
  else
    echo $USER,$DATE,$BRANCH >> ${SCRIPT_DIR}/not-merged-branches-older-than-month.csv
  fi
done

for k in $(git branch -a --merged develop | sed /\*/d | sed 's/^remotes\///' | grep -v 'master$' | grep -v 'qa$' | grep -v 'develop$' | grep -v 'demo$'); do 
# All branches that have not received a commit for a month
    USER=$(git log -1 --pretty=format:"%cn" -s $k)
    DATE=$(git log -1 --date=short --pretty=format:"%cd" -s $k)
    BRANCH=${k##*/}
  if [ -n "$(git log -1 --after='1 month ago' -s $k --)" ]; then
    echo $USER,$DATE,$BRANCH >> ${SCRIPT_DIR}/merged-branches-older-than-month.csv
  fi
done
