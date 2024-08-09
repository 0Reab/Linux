#!/usr/bin/bash
# run as sudo
apt install neovim &>/dev/null & wait

[ $? -eq ] && echo "Neovim installed." || echo "Install failed."

nvim hello 
