#!/usr/bin/zsh 
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k &>/dev/null & wait
[ $? -eq 0 ] && echo "Cloned teh repo." || echo "Repo clone failed."

echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc & wait 

exec zsh & wait

p10k configure
