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
