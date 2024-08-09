#!/usr/bin/bash
url="https://github.com/NvChad/NvChad.git"
git clone "$url" ~/.config/nvim --depth 1

echo "Run nvim and install/update with command :Lazy"
