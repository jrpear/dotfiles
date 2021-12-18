# =============================== PROMPT ===============================

# https://en.wikipedia.org/wiki/ANSI_escape_code#3-bit_and_4-bit

CYAN="\[$(tput setaf 6)\]"
RED="\[$(tput setaf 1)\]"
EXIT_ATTR="\[$(tput sgr0)\]"

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

GIT_PROMPT_INFO="${EXIT_ATTR}\$(git_leader)${RED}\$(git_branch)${EXIT_ATTR}\$(git_follower)"

PS1="${EXIT_ATTR}\u@\h ${CYAN}[\W] ${GIT_PROMPT_INFO}${EXIT_ATTR}"

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

alias g=git
alias o=xdg-open

alias glogout='loginctl kill-user $USER'

alias uchmod='chmod -R a=r,u+w,a+X'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias systemctlu='systemctl --user'

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
