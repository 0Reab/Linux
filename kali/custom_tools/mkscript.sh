#!/bin/bash
# One tip: Putting this script in /usr/local/bin and removing .sh extension will make this easy to run globally
# For python call - mkscript script_name py
green='\033[1;92m'                              # txt color
red='\033[1;91m'
name="$1"                                                       # script name
bash_path="#!$(which bash)"             # shebang path bash
python_path="#!$(which python3)"        # shebang path python3
is_py_script=false                              # defualting to bash

function usage() {
        printf "\n${green}Usage: $(basename "$0") <script_name>" && exit 1
}


function error() {
        printf "\n${red}Error occurred..." && exit 1
}


function add_ext() {
        local ext="$1"
        [[ ! "$name" = *."$ext" ]] && name="${name}.$ext"   # add extension if needed
}


function create_script() {
        local path="$1"
        touch "$name" && chmod +x "$name" && echo "$path" >> "$name" && printf "${green}Created $name" || error
}


function main() {

        [[ $# -ge 1 && $# -le 2 ]] || usage    # check num of args

        [ "$2" == "py" ] && is_py_script=true


        [ $is_py_script == true ] && add_ext 'py' || add_ext 'sh'


        [ -e "$name" ] && printf "\n${red}$name already exists" && error    # check if file with the same name exits

        # create file with perms and interpeter path


        [ "$is_py_script" == true ] && create_script "$python_path" || create_script "$bash_path"

        vim "$name"     # open file script in vim
}


main "$@" # call main function with all args
