#!/bin/bash
# One tip: Putting this script in /usr/local/bin and removing .sh extension will make this easy to run globally

green='\033[1;92m'     # txt color
red='\033[1;91m'
name="$1"
bash_path="#!$(which bash)"    # shebang bash path


function usage() {
	printf "\n${green}Usage: $(basename "$0") <script_name>" && exit 1
}


function error() {
	printf "\n${red}Error occurred..." && exit 1
}


function main() {
	[ $# -ne 1 ] && usage    # check num of args

	[[ ! "$name" = *.sh ]] && name="${name}.sh"   # add .sh extension if needed

	[ -e "$name" ] && printf "\n${red}$name already exists" && error    # check if file with the same name exits

	# create file with perms and bash path
	
	touch "$name" && chmod +x "$name" && echo "$bash_path" >> "$name" && printf "${green}Created $name" || error

	mousepad "$name" &  # open file in subshell aka background
}


main "$@" # call main function with all args
