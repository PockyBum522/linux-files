#!/bin/sh

echo ""

# Figure out if this is termux or debian
if [ -d "/data/data/com.termux" ] 
then
    distro_flag=termux
else
    distro_flag=debian
fi

echo "Distro detected as: $distro_flag"

echo ""

# Template for the beginning. If/then/elif/else means we can make sure distro_flag value is valid
if [[ "$distro_flag" == "termux" ]]; then

elif [[ "$distro_flag" == "debian" ]]

else
    echo "Unhandled distro_flag: $distro_flag"
    exit 1
fi

# Template for after we've had the first check to make sure distro_flag value is valid
if [[ "$distro_flag" == "termux" ]]; then



elif [[ "$distro_flag" == "debian" ]]



fi

# update/upgrade

# Termux only stuff:
#       installing pacman as default manager
#       termux-api

# pkg install/apt install:
# zsh 7zip tmux vim htop openssh

# zsh

# vimrc

# tmux.conf

# sshd_conf

# tailscale