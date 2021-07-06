# Resources

This repository is for commonly used resources, scripts, and reference material.

## GIT Branch to Folder Script

[./git-branch-to-folder.sh](git-branch-to-folder.sh), This script is handy when creating tutorial content that has a beginning and ending version. This script allows you to manage each version of a section of a tutorial in it's own GIT branch. Once each branch is complete and all changes committed, this script will quickly turn each GIT branch into it's own folder, containing all files currently in that branch.

Example:  
Example branch name: feature1__start, feature1__finish, feature2__start, feature2__finish  
Will create the following folders:  
| feature1  
| -- finish  
| -- start  
| feature2  
| -- finish  
| -- start  

## Pull Request Checkout and Test Script

[./pr-checkout-test.sh](pr-checkout-test.sh), This script is helpful when testing a Pull Request(PR) locally. By passing the PR number this script will change directories, stash any current changes (be sure to un-stash these later!), checkout the PR changes using the base branch and execute a "test" command that will check for things like functioning tests, proper compilation, etc.
