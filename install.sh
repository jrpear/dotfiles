#!/bin/sh

# Bash

ln -s ${PWD}/bashrc ~/.bashrc 2>/dev/null
ln -s ${PWD}/bash_profile ~/.bash_profile 2>/dev/null

# Core Vim

ln -s ${PWD}/vimrc ~/.vimrc 2>/dev/null
ln -s ${PWD}/vimrc.plugins ~/.vimrc.plugins 2>/dev/null
if [ ! -d ~/.vim ]
then
  mkdir ~/.vim
  ln -s ${PWD}/vim/after ~/.vim/after
  ln -s ${PWD}/vim/plugin ~/.vim/plugin
fi

# Neovim

mkdir -p ~/.config/nvim
ln -s ${PWD}/config/nvim/init.vim ~/.config/nvim/init.vim 2>/dev/null

# Tmux

ln -s ${PWD}/tmux.conf ~/.tmux.conf 2>/dev/null

# Git

ln -s ${PWD}/gitconfig ~/.gitconfig 2>/dev/null
ln -s ${PWD}/gitignore ~/.gitignore 2>/dev/null
mkdir -p ~/.git_template/hooks
ln -s ${PWD}/git_template/hooks/ctags ~/.git_template/hooks/ctags 2>/dev/null

# IPython

mkdir -p ~/.ipython/profile_default/startup
ln -s ${PWD}/ipython/profile_default/ipython_config.py \
  ~/.ipython/profile_default/ipython_config.py 2>/dev/null
ln -s ${PWD}/ipython/profile_default/startup/rc.py \
  ~/.ipython/profile_default/startup/rc.py 2>/dev/null

# Sway

mkdir -p ~/.config/sway{,lock}
ln -s ${PWD}/config/sway/config ~/.config/sway/config 2>/dev/null
ln -s ${PWD}/config/swaylock/config ~/.config/swaylock/config 2>/dev/null

# VSCode

mkdir -p ~/.config/Code/User
ln -s ${PWD}/config/Code/User/settings.json \
  ~/.config/Code/User/settings.json 2>/dev/null
