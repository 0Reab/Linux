#!/usr/bin/bash
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
