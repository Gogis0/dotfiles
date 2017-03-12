# Abort if not Ubuntu
[[ "$(cat /etc/*-release 2> /dev/null)" =~ Ubuntu ]] || return 1

# Update APT
sudo apt-get -qq update
sudo apt-get -qq upgrade

# List of packages I want to install
packages=(
    git
    vim
    tree
    g++
    python3
    htop
)

# Check whether the packages are already installed
list=()
for package in "${packages[@]}"; do
    if [[ ! "$(dpkg -l "$package" 2>/dev/null | grep "^ii  $package")"  ]]; then
        list=("${list[@]}" "$package")
    fi
done

if (( ${#list[@]} > 0 )); then
    for package in "${list[@]}"; do
        sudo apt-get -qq -y install $package
        if [[ $? -eq 0 ]]; then
            printf "\e[0;32m  [✔] $package\e[0m\n"
        else
            printf "\e[0;31m  [✖] $package\e[0m\n"
        fi
    done
fi
