#!/bin/sh

# Environment variables

ln -s ~/dotfiles/pam_environment ~/.pam_environment

# Zsh

ln -s ~/dotfiles/bashrc ~/.bashrc

# Core Vim

ln -s ~/dotfiles/vimrc ~/.vimrc
ln -s ~/dotfiles/vimrc.plugins ~/.vimrc.plugins
mkdir ~/.vim
ln -s ~/dotfiles/vim/after ~/.vim/after
ln -s ~/dotfiles/vim/plugin ~/.vim/plugin

# Neovim

mkdir -p ~/.config/nvim
ln -s ~/dotfiles/config/nvim/init.vim ~/.config/nvim/init.vim

# Tmux

ln -s ~/dotfiles/tmux.conf ~/.tmux.conf

# Git

ln -s ~/dotfiles/gitconfig ~/.gitconfig
ln -s ~/dotfiles/gitignore ~/.gitignore
mkdir -p ~/.git_template/hooks
ln -s ~/dotfiles/git_template/hooks/ctags ~/.git_template/hooks/ctags

# IPython

mkdir -p ~/.ipython/profile_default/startup
ln -s ~/dotfiles/ipython/profile_default/ipython_config.py \
  ~/.ipython/profile_default/ipython_config.py
ln -s ~/dotfiles/ipython/profile_default/startup/rc.py ~/.ipython/profile_default/startup/rc.py

# VSCode

mkdir -p ~/.config/Code/User
ln -s ~/dotfiles/config/Code/User/settings.json ~/.config/Code/User/settings.json
