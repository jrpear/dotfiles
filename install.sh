#!/bin/bash

SCRIPT_DIR=$(realpath $(dirname "${BASH_SOURCE[0]}"))

# Environment variables
# Must copy these rather than symlink because systemd-environment-d-generator silently skips symlinks

mkdir -p ${HOME}/.config/environment.d
cp ${SCRIPT_DIR}/config/environment.d/ff-wayland.conf \
  ${HOME}/.config/environment.d/ff-wayland.conf 2>/dev/null
cp ${SCRIPT_DIR}/config/environment.d/enable-ibus.conf \
  ${HOME}/.config/environment.d/enable-ibus.conf 2>/dev/null

repo_to_home=(
    "bashrc" ".bashrc"
    "bash_profile" ".bash_profile"
)

while [ "${#repo_to_home[@]}" -gt 0 ]; do
    repo_path="$SCRIPT_DIR/${repo_to_home[0]}"
    home_path="$HOME/${repo_to_home[1]}"

    if [ ! -e "$home_path" ] || [ -L "$home_path" ]; then
	ln --symbolic --force "$repo_path" "$home_path"
    else
	echo "skipping $home_path; exists and is not symlink"
    fi

    # pop off first two elements
    unset repo_to_home[0]
    unset repo_to_home[1]
    repo_to_home=("${repo_to_home[@]}")
done

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

# GDB

ln -s ${SCRIPT_DIR}/gdbinit ${HOME}/.gdbinit 2>/dev/null

# Screen

ln -s ${SCRIPT_DIR}/screenrc ${HOME}/.screenrc 2>/dev/null

# Git

ln -s ${SCRIPT_DIR}/gitconfig ${HOME}/.gitconfig 2>/dev/null
ln -s ${SCRIPT_DIR}/gitignore ${HOME}/.gitignore 2>/dev/null

# IPython

mkdir -p ${HOME}/.ipython/profile_default/startup
ln -s ${SCRIPT_DIR}/ipython/profile_default/ipython_config.py \
  ${HOME}/.ipython/profile_default/ipython_config.py 2>/dev/null
ln -s ${SCRIPT_DIR}/ipython/profile_default/startup/rc.py \
  ${HOME}/.ipython/profile_default/startup/rc.py 2>/dev/null

# VSCode

mkdir -p ${HOME}/.config/Code/User
ln -s ${SCRIPT_DIR}/config/Code/User/settings.json \
  ${HOME}/.config/Code/User/settings.json 2>/dev/null

# Windows VM management script

mkdir -p ${HOME}/.local/bin
ln -s ${SCRIPT_DIR}/local/bin/windows.sh ${HOME}/.local/bin/windows.sh 2>/dev/null
