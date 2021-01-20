#!/bin/sh

# Environment variables

ln -s ~/dotfiles/pam_environment ~/.pam_environment

# Zsh

ln -s ~/dotfiles/zshrc ~/.zshrc

# Autostart

mkdir -p ~/.config/autostart
ln -s ~/config/fcitx5-autostart.desktop \
  ~/.config/autostart/fcitx5-autostart.desktop

# Core Vim

ln -s ~/dotfiles/vimrc ~/.vimrc
ln -s ~/dotfiles/vimrc.plugins ~/.vimrc.plugins
mkdir ~/.vim

if [ ! -e ~/dotfiles/vim/after ]
then
  ln -s ~/dotfiles/vim/after ~/.vim/after
fi

if [ ! -e ~/dotfiles/vim/plugin ]
then
  ln -s ~/dotfiles/vim/plugin ~/.vim/plugin
fi

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
