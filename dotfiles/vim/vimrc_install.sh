#!/usr/bin/env bash
#thanks, gary!

set -eufx -o pipefail

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

cd "$SCRIPTPATH"
git submodule update --init

if [[ ! -f "$HOME/.vim_runtime" && ! -d "$HOME/.vim_runtime" && ! -L "$HOME/.vim_runtime" ]]; then
    ln -s "$SCRIPTPATH/amix_vimrc" "$HOME/.vim_runtime"
fi

if [[ ! -f "$SCRIPTPATH/amix_vimrc/my_configs.vim" && ! -d "$SCRIPTPATH/amix_vimrc/my_configs.vim" && ! -L "$SCRIPTPATH/amix_vimrc/my_configs.vim" ]]; then
    ln -s "$SCRIPTPATH/my_configs.vim" "$SCRIPTPATH/amix_vimrc/my_configs.vim"
fi

./amix_vimrc/install_awesome_vimrc.sh

if [ ! -d "amix_vimrc/my_plugins/vim-clang-format" ]; then
    git clone https://github.com/rhysd/vim-clang-format amix_vimrc/my_plugins/vim-clang-format
    git -C amix_vimrc/my_plugins/vim-clang-format checkout 6b791825ff478061ad1c57b21bb1ed5a5fd0eb29
fi

if [ ! -d "amix_vimrc/my_plugins/vim-numbertoggle" ]; then
    git clone https://github.com/jeffkreeftmeijer/vim-numbertoggle amix_vimrc/my_plugins/vim-numbertoggle
    git -C amix_vimrc/my_plugins/vim-numbertoggle checkout 3d188ed2113431cf8dac77be61b842acb64433d9
fi

if [ ! -d "amix_vimrc/my_plugins/vim-lsp" ]; then
    git clone https://github.com/prabirshrestha/vim-lsp amix_vimrc/my_plugins/vim-lsp
    git -C amix_vimrc/my_plugins/vim-lsp checkout 04428c920002ac7cfacbecacb070a8af57b455d0
fi

if [ ! -d "amix_vimrc/my_plugins/vim-lsp-settings" ]; then
    git clone https://github.com/mattn/vim-lsp-settings amix_vimrc/my_plugins/vim-lsp-settings
    git -C amix_vimrc/my_plugins/vim-lsp-settings checkout 6dfdac0e5676f403299f496c0e69515ee7576fe5
fi

if [ ! -d "amix_vimrc/my_plugins/asyncomplete.vim" ]; then
    git clone https://github.com/prabirshrestha/asyncomplete.vim amix_vimrc/my_plugins/asyncomplete.vim
    git -C amix_vimrc/my_plugins/asyncomplete.vim checkout 016590d2ca73cefe45712430e319a0ef004e2215
fi
