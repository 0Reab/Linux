#!/usr/bin/bash

# this script is meant to be run first for setting up your kali

# setup custom tools

toolbag="/custom_tools/"

cp "${toolbag}del.sh" /usr/local/bin/del
cp "${toolbag}mkscript.sh" /usr/local/bin/mkscript

# start installer for other tools

sh ./tools.sh

# set php reverse shell as global var

mkdir -p "~/scripts"
cp "${toolbag}rev.php" "${HOME}/scripts/rev.php"


# setup .zshrc config file for terminal startup

function addline() {
        local line="$1"

        echo "$line" >> "${HOME}/.bashrc"
}

# backup .bashrc file
cp "${HOME}/.bashrc" "${HOME}/.bashrc_backup"

addline "# setup script lines"
addline "alias mp='mousepad'"
addline "alias roast='shellcheck'" # should install shell check before this runs
addline "#neofetch | lolcat -F 0.03 -S 180 # Green" # install lolcat and neofetch
addline "neofetch | lolcat -F 0.03 -S 60 # Purple"
addline "export PHP='${HOME}/scripts/rev.php"
