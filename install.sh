#!/bin/bash

set -e

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
    "vimrc" ".vimrc"
    "vimrc.plugins" ".vimrc.plugins"
    "vim" ".vim"
    "vimrc" ".config/nvim/init.vim"
    "vimrc.plugins" ".config/nvim/plugins.vim"
    "vim" ".local/share/nvim/site"
    "gdbinit" ".gdbinit"
    "screenrc" ".screenrc"
    "gitconfig" ".gitconfig"
    "gitignore" ".gitignore"
    "ipython/profile_default/ipython_config.py" ".ipython/profile_default/ipython_config.py"
    "ipython/profile_default/startup/rc.py" ".ipython/profile_default/startup/rc.py"
    "config/Code/User/settings.json" ".config/Code/User/settings.json"
    "local/bin/windows.sh" ".local/bin/windows.sh"
)

while [ "${#repo_to_home[@]}" -gt 0 ]; do
    repo_path="$SCRIPT_DIR/${repo_to_home[0]}"
    home_path="$HOME/${repo_to_home[1]}"

    if [ ! -e "$home_path" ] || [ -L "$home_path" ]; then
	ln --symbolic --force --no-target-directory "$repo_path" "$home_path"
	echo "installed $home_path"
    else
	echo "skipping $home_path; exists and is not symlink"
    fi

    # pop off first two elements
    unset repo_to_home[0]
    unset repo_to_home[1]
    repo_to_home=("${repo_to_home[@]}")
done

git submodule update --init --recursive
