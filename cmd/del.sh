#!/usr/bin/bash
#sudo cp script.sh /usr/local/bin/customname
input="$1"

bin="$HOME/deleted"
mkdir -p "$bin"

if [[ $(mv "$1" "$bin") ]]; then
  echo "Err $1"
fi
