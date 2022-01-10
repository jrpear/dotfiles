# =============================== PROMPT ===============================

# https://en.wikipedia.org/wiki/ANSI_escape_code#3-bit_and_4-bit

COLOR_RED="\[$(tput setaf 1)\]"
COLOR_MAGENTA="\[$(tput setaf 5)\]"
COLOR_CYAN="\[$(tput setaf 6)\]"
COLOR_ORIG="\[$(tput op)\]"

function git_leader {
	if [ "$(git rev-parse --is-inside-work-tree 2>&1)" = "true" ]
	then
		echo "git:("
	fi
}

function git_branch() {
	git rev-parse --abbrev-ref --symbolic-full-name HEAD 2> /dev/null
}

function git_follower () {
	if [ "$(git rev-parse --is-inside-work-tree 2>&1)" = "true" ]
	then
		echo ") "
	fi
}

GIT_PROMPT_INFO="${COLOR_ORIG}\$(git_leader)${COLOR_RED}\$(git_branch)${COLOR_ORIG}\$(git_follower)"

PS1="${COLOR_ORIG}\u@${COLOR_CYAN}\h ${COLOR_MAGENTA}[\W] ${GIT_PROMPT_INFO}${COLOR_ORIG}"

HISTSIZE=1000
HISTCONTROL=ignoreboth:erasedups
shopt -s histappend
set -o vi

# ============================== ALIASES ===============================

function gh() { # git home
	cd $(git rev-parse --show-toplevel)
}

function swap() {
	tmpfile=$(mktemp $(dirname "$1")/XXXXXX)
	mv "$1" "$tmpfile" && mv "$2" "$1" &&  mv "$tmpfile" "$2"
}

function rebwin() {
	local bootnum=$(sudo efibootmgr | grep 'Windows Boot Manager' | sed -e 's/Boot\([0-9]\)*.*/\1/')
	sudo efibootmgr -n $bootnum
	sudo reboot
}

alias g=git
alias o=xdg-open

alias glogout='loginctl kill-user $USER'
alias loghack='sudo systemctl emergency'

alias uchmod='chmod -R a=r,u+w,a+X'

alias systemctlu='systemctl --user'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# ============================= INCLUDES ===============================

typeset -a includes

if [ -d /opt/asdf-vm ]; then
	includes+=($(find /opt/asdf-vm -name 'asdf.sh'))
fi

if [ -d /usr/share/fzf ]; then
	includes+=($(find /usr/share/fzf -name 'key-bindings.bash'))
	includes+=($(find /usr/share/fzf -name 'completion.bash'))
fi

if [ -d $HOME ]; then
	includes+=($(find $HOME -maxdepth 1 -name '.bashrc.local'))
fi

for i in ${includes[*]}; do
	source $i
done