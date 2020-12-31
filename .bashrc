# GIT Commands
alias ga='git add -u' # GIT add only files that were modified or deleted, not untracked
alias gb='git branch'
alias gc='git checkout'
alias gf='git fetch'
alias gp='git pull'
alias gs='git status'
alias gprunemerged='git checkout master && comm -12 <(git branch | sed "s/ *//g") <(git remote prune origin | sed "s/^.*origin\///g") | xargs -L1 -J % git branch -D %' # Remove all branches from local after deleted from remote

# Docker Commands
alias dc='docker-compose'
alias dp='docker ps'
alias dpa='docker ps -a'

# Random
alias code='open -a /Applications/Visual\ Studio\ Code.app/'
alias la='ls -la'
alias ll='ls -ll'
alias ip='ifconfig en0 | grep inet'  # Get current ip address
alias gh='history | grep' # gh <portion of command string>
alias lsf='ls | grep  -i' # Fuzzy search of current directory lsf <string>
alias rand='openssl rand -hex 32 | pbcopy' # Randomly generatea hex string and copy to clipboard
alias mkdir='_mkdir() { mkdir -p "$1" && cd "$1" ;}; _mkdir' # Make new directory (nested) and change to that directory
alias bashrc='code ~/.bashrc'

# CD'ing directories
alias cd..='cd ../'                         # Go back 1 directory level (for fast typers)
alias ..='cd ../'                           # Go back 1 directory level
alias ...='cd ../../'                       # Go back 2 directory levels
alias .3='cd ../../../'                     # Go back 3 directory levels
alias .4='cd ../../../../'                  # Go back 4 directory levels
alias .5='cd ../../../../../'               # Go back 5 directory levels
alias .6='cd ../../../../../../'            # Go back 6 directory levels
alias f='open -a Finder ./'                 # f:            Opens current directory in MacOS Finder
alias ~="cd ~"                              # ~:            Go Home
alias c='clear'
alias date="date '+%A %W %Y %X'" 