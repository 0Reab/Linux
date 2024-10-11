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
  "xclip"
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

addline "# CUSTOM setup script lines"
addline "#neofetch | lolcat -F 0.03 -S 180 # Green" # cool terminal color variation
addline "neofetch | lolcat -F 0.03 -S 60 # Purple" # cool terminal etc...
addline "PHP='${DIR}/scripts/rev.php'" # path for classic php reverse shell
addline "PTY="python -c 'import pty; pty.spawn(\"/bin/bash\")'\npython3 -c 'import pty; pty.spawn(\"/bin/bash\")'"" # shell upgrade commands
addline "alias shell='printf $PTY; printf '\n'; nc -nvlp 4444'" # run netcat listener port 4444 display shell upgrade commands for python
addline "alias copy='xclip -sel c <'" # copy contents of file to clipboard: <usage> copy file_name.txt
addline "alias mp='mousepad'" # open mousepad txt editor: <usage> mp
addline "alias roast='shellcheck'" # open shellcheck for bash script debugging <usgae> roast my_script.sh

source .zshrc &>/dev/null # use new config, errors are expected hence /dev/null redirect test it in new terminal window
# maby this last line is not needed if you write to .zshrc idk.
