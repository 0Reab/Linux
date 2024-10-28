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
echo "python -c 'import pty; pty.spawn(\"/bin/bash\")'\n" >> ${DIR}/.pty

# setup .zshrc config file for terminal startup

function addline() {
        local line="$1"

        echo "$line" >> "${DIR}/.zshrc"
}

# backup .bashrc file
cp "${DIR}/.bashrc" "${DIR}/.zshrc_backup"

addline "# CUSTOM setup script lines"

addline "alias copy='xclip -sel c <'" # Copy contents of file to clipboard
addline "# neofetch | lolcat -F 0.03 -S 180 # Green" # Cool terminal color variation
addline "neofetch | lolcat -F 0.03 -S 60 # Purple" # Another color variation
addline "PHP=${DIR}/scripts/rev.php" # Path for PHP reverse shell
addline "PTY=\"python -c 'import pty; pty.spawn('/bin/bash')'\"" # Shell upgrade commands
addline "PTY3=\"python3 -c 'import pty; pty.spawn('/bin/bash')'\"" # Shell upgrade commands
addline "alias shell='printf \$PTY; printf \$PTY3; copy \$HOME/.pty; nc -nvlp 4444'" # Netcat listener alias
addline "alias mp='mousepad'" # Open mousepad text editor
addline "alias roast='shellcheck'" # Open shellcheck for debugging
addline "ROCKYOU='/usr/share/wordlists/rockyou.txt'" # Global variable for rockyou wordlist
addline "DIRBUST='/usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt'" # Global variable for dir-medium-2.3 wordlist

source .zshrc &>/dev/null # use new config, errors are expected hence /dev/null redirect test it in new terminal window
# maby this last line is not needed if you write to .zshrc idk.
