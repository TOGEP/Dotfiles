#!/bin/bash
set -euxo pipefail

# TODO vim-plugはOSによってインストールスクリプトが異なる
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

nvim -E -s <<-EOF
:source $HOME/.config/nvim/init.vim
:PlugInstall
:PlugClean
:qa
EOF
