#!/usr/bin/env bash

echo "Welcom to the world of Neovim"

# https://github.com/neovim/neovim/blob/master/BUILD.md
git clone -b v0.10.4 https://github.com/neovim/neovim.git $HOME/personal/neovim

# Install Neovim build dependencies:
brew install ninja cmake gettext curl

cd $HOME/personal/neovim
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
