#!/usr/bin/bash
# run as sudo

apt install zsh &>/dev/null & wait 

[ $? -eq 0 ] && echo "Zsh installed" || echo "Zsh install failed."

echo "Changing $SHELL to zsh."

chsh -s $(which zsh) &>/dev/null

[ $? -eq 0 ] && echo "Shell changed to $SHELL" || echo "Failed to change $SHELL"
echo -e "\nIf the $SHELL is zsh, relog to use it.\n"

echo $(zsh --version)
