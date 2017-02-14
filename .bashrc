#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

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

# cd and ls in one command!
function cl() { cd "$@" && la; }

# Repeat a command N times.  You can do something like
#  repeat 3 echo 'hi'
function repeat()
{
    local i max
    max=$1; shift;
    for ((i=1; i <= max ; i++)); do
        eval "$@";
    done
}

# Extract based upon file ext
function ex() {
     if [ -f "$1" ] ; then
         case "$1" in
             *.tar.bz2)   tar xvjf "$1"        ;;
             *.tar.gz)    tar xvzf "$1"     ;;
             *.bz2)       bunzip2 "$1"       ;;
             *.rar)       unrar x "$1"     ;;
             *.gz)        gunzip "$1"     ;;
             *.tar)       tar xvf "$1"        ;;
             *.tbz2)      tar xvjf "$1"      ;;
             *.tgz)       tar xvzf "$1"       ;;
             *.jar)       jar xf "$1"       ;;
             *.zip)       unzip "$1"     ;;
             *.Z)         uncompress "$1"  ;;
             *.7z)        7z x "$1"    ;;
             *)           echo "'$1' cannot be extracted via >extract<" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

# remove duplicate path entries and preserve PATH order
export PATH
PATH=$(echo "$PATH" | awk -F: '
{ start=0; for (i = 1; i <= NF; i++) if (!($i in arr) && $i) {if (start!=0) printf ":";start=1; printf "%s", $i;arr[$i]}; }
END { printf "\n"; } ')


PS1='[\u@\h \W]\$ '
