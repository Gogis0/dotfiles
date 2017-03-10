#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# symlink the good stuff to ~/
for file in ~/.{aliases,functions}; do
    [ -r "$file" ] && source "$file"
done
unset file

# remove duplicate path entries and preserve PATH order
export PATH
PATH=$(echo "$PATH" | awk -F: '
{ start=0; for (i = 1; i <= NF; i++) if (!($i in arr) && $i) {if (start!=0) printf ":";start=1; printf "%s", $i;arr[$i]}; }
END { printf "\n"; } ')


PS1='[\u@\h \W]\$ '
