#!/bin/bash
set -euxo pipefail

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

nvim -E -s <<-EOF
:source $HOME/.config/nvim/init.vim
:PlugInstall
:PlugClean
:qa
EOF
