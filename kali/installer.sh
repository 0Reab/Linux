#!/usr/bin/bash

# this script is meant to be run first for setting up your kali
# Run as sudo otherwise it will throw ERR

declare -a tools=(
  "curl"
  "tldr"
  "locate"
  "shellcheck"
  "lolcat"
  "neofetch"
)

for tool in ${tools[@]}; do 
  yes | apt install "$tool" &>/dev/null
  [ $? -eq 0 ] && echo "$tool - OK" || echo "$tool - ERR"
done
echo "base tools installed ..."
sleep 3
# setup custom tools
echo "setting up ..."
DIR='/home/reab'
toolbag="${PWD}/custom_tools/"

cp "${toolbag}del.sh" /usr/local/bin/del
cp "${toolbag}mkscript.sh" /usr/local/bin/mkscript

chmod +x /usr/local/bin/mkscript
chmod +x /usr/local/bin/del

# set php reverse shell as global var

mkdir -p "${DIR}/scripts"
cp "${toolbag}rev.php" "${DIR}/scripts/rev.php"


# setup .zshrc config file for terminal startup

function addline() {
        local line="$1"

        echo "$line" >> "${DIR}/.zshrc"
}

# backup .bashrc file
cp "${DIR}/.bashrc" "${DIR}/.zshrc_backup"

addline "# setup script lines"
addline "alias mp='mousepad'"
addline "alias roast='shellcheck'" # should install shell check before this runs
addline "#neofetch | lolcat -F 0.03 -S 180 # Green" # install lolcat and neofetch
addline "neofetch | lolcat -F 0.03 -S 60 # Purple"
addline "PHP='${DIR}/scripts/rev.php'"
addline "PTY="python -c 'import pty; pty.spawn('/bin/bash')'""
addline "alias shell='echo $PTY; nc -nvlp 4444'"


source .zshrc &>/dev/null # use new config, errors are expected hence /dev/null redirect test it in new terminal window
