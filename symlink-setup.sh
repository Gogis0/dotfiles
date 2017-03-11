#!/bin/bash

# install script to symlink all the dotfiles (and .vim/) to ~/
# it's idempotent, which means it is safe to run multiple times

# credits go to Paul Irish and his glorious dotfiles masterpiece - https://github.com/paulirish/dotfiles

#
# define some utils first
#

answer_is_yes() {
    [[ "$REPLY" =~ ^[Yy]$ ]] \
        && return 0 \
        || return 1
}

ask() {
    print_question "$1"
    read
}

ask_for_confirmation() {
    print_question "$1 (y/n)"
    read -n 1
    printf "\n"
}

ask_for_sudo() {
    # Ask for the administrator password upfornt

    # Update existing 'sudo' timestamp until this script has finished
    while true; do
        sudo -n true
        sleep 60
        kill -0 "$$" - || exit
    done &> /dev/null &
}

cmd_exists() {
    [ -x "$(command -v "$1")" ] \
        && printf 0 \
        || printf 1
}

execute() {
    $1 &> /dev/null
    print_result $? "${2:-$1}"
}

get_answer() {
    printf "$REPLY"
}

is_git_repository() {
    [ "$(git rev-parse &> /dev/null; printf $?)" -eq 0 ] \
        && return 0 \
        || return 1
}

mkd() {
    if [ -n "$1" ]; then
        if [ -e "$1" ]; then
            if [ ! -d "$1" ]; then
                print_error "$1 - a file with the same name already exists!"
            else
                print_success "$1"
            fi
        else
            execute "mkdir -p $1" "$1"
        fi
    fi
}

print_error() {
    # Error output should be in red
    printf "\e[0;31m [✖] $1 $2\e[0m\n"
}

print_info() {
    # All the info in purple
    printf "\n\e[0;35m $1\e[0m\n\n"
}

print_question() {
    # Questions in yellow
    printf "\e[0;33m  [?] $1\e[0m"
}

print_result() {
    [ $1 -eq 0 ] \
        && print_success "$2" \
        || print_error "$2"

    [ "$3" == "true" ] && [ $1 -ne 0 ] \
        && exit
}

print_success() {
    # Green is the color of success ofc
    printf "\e[0;32m  [✔] $1\e[0m\n"
}

#
# actual symlink stuff
#

declare -a FILES_TO_SYMLINK=$(find . -type f -name ".*" -not -name .git | sed -e 's|//|/|' | sed -e 's|./.|.|')
FILES_TO_SYMLINK="$FILES_TO_SYMLINK .vim" # add /.vim

main() {

    local file=""
    local sourceFile=""
    local targetFile=""

    for file in ${FILES_TO_SYMLINK[@]}; do

        sourceFile="$(pwd)/$file"
        targetFile="$HOME/$(printf "%s" "$file" | sed "s/.*\/\(.*\)/\1/g")"

        if [ -e "$targetFile" ]; then
            if [ "$(readlink "$targetFile")" != "$sourceFile" ]; then
                
                ask_for_confirmation "'$targetFile' already exists, do you want to overwrite it?"
                if answer_is_yes; then
                    rm -rf "$targetFile"
                    execute "ln -fs $sourceFile $targetFile"
                else
                    print_error "$sourceFile → $targetFile"
                fi
            else
                print_success "$sourceFile → $targetFile"
            fi
        else
            execute "ln -fs $sourceFile $targetFile" "$targetFile → $sourceFile"
        fi
    done
}

main
