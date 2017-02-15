# ls aliases
alias ls='ls --color=auto'
alias la='ls -lah'

# grep with colorz
alias grep='grep --color=auto'
alias unigrep='grep -P "[^\x00-\x7F]"'

# git aliases
alias g="git"
alias ga="git add"
alias gb="git branch"
alias gc="git commit"
alias gco="git checkout"
alias gcol="git checkout live"
alias gcom="git checkout master"
alias gcos="git checkout stable"
alias gd="git diff"
alias gl="git lg"
alias gm="git merge"
alias gp="git pull --ff"
alias gpol="git push origin live"
alias gpom="git push origin master"
alias gpos="git push origin stable"
alias gs="git status"

# navigation aliases
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../..'
