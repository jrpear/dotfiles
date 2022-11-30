#!/bin/bash

SCRIPT_DIR=$(realpath $(dirname "${BASH_SOURCE[0]}"))

# Environment variables

mkdir -p ${HOME}/.config/environment.d
ln -s ${SCRIPT_DIR}/config/environment.d/ff-wayland.conf \
  ${HOME}/.config/environment.d/ff-wayland.conf 2>/dev/null

# Bash

ln -s ${SCRIPT_DIR}/bashrc ${HOME}/.bashrc 2>/dev/null
ln -s ${SCRIPT_DIR}/bash_profile ${HOME}/.bash_profile 2>/dev/null

# Readline

ln -s ${SCRIPT_DIR}/inputrc ${HOME}/.inputrc 2>/dev/null

# Core Vim

ln -s ${SCRIPT_DIR}/vimrc ${HOME}/.vimrc 2>/dev/null
ln -s ${SCRIPT_DIR}/vimrc.plugins ${HOME}/.vimrc.plugins 2>/dev/null
ln -s ${SCRIPT_DIR}/vim ${HOME}/.vim --no-target-directory 2>/dev/null

# Neovim

mkdir -p ${HOME}/.config/nvim
mkdir -p ${HOME}/.local/share/nvim
ln -s ${SCRIPT_DIR}/vimrc ${HOME}/.config/nvim/init.vim 2>/dev/null
ln -s ${SCRIPT_DIR}/vimrc.plugins ${HOME}/.config/nvim/plugins.vim 2>/dev/null
ln -s ${SCRIPT_DIR}/vim ${HOME}/.local/share/nvim/site --no-target-directory 2>/dev/null

git submodule update --init --recursive

# Tmux

ln -s ${SCRIPT_DIR}/tmux.conf ${HOME}/.tmux.conf 2>/dev/null

# Git

ln -s ${SCRIPT_DIR}/gitconfig ${HOME}/.gitconfig 2>/dev/null
ln -s ${SCRIPT_DIR}/gitignore ${HOME}/.gitignore 2>/dev/null
mkdir -p ${HOME}/.git_template/hooks
ln -s ${SCRIPT_DIR}/git_template/hooks/ctags ${HOME}/.git_template/hooks/ctags 2>/dev/null

# IPython

mkdir -p ${HOME}/.ipython/profile_default/startup
ln -s ${SCRIPT_DIR}/ipython/profile_default/ipython_config.py \
  ${HOME}/.ipython/profile_default/ipython_config.py 2>/dev/null
ln -s ${SCRIPT_DIR}/ipython/profile_default/startup/rc.py \
  ${HOME}/.ipython/profile_default/startup/rc.py 2>/dev/null

# Sway

mkdir -p ${HOME}/.config/sway{,lock}
ln -s ${SCRIPT_DIR}/config/sway/config ${HOME}/.config/sway/config 2>/dev/null
ln -s ${SCRIPT_DIR}/config/swaylock/config ${HOME}/.config/swaylock/config 2>/dev/null

# VSCode

mkdir -p ${HOME}/.config/Code/User
ln -s ${SCRIPT_DIR}/config/Code/User/settings.json \
  ${HOME}/.config/Code/User/settings.json 2>/dev/null

# Windows VM management script

mkdir -p ${HOME}/.local/bin
ln -s ${SCRIPT_DIR}/local/bin/windows.sh ${HOME}/.local/bin/windows.sh 2>/dev/null
