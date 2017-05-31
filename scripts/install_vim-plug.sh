#!/usr/bin/env bash

# Install for Neovim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Symlink that file so that it will also work for regular Vim (and GVim).
mkdir -p ~/.vim/autoload/
ln -s ~/.local/share/nvim/site/autoload/plug.vim ~/.vim/autoload/plug.vim
