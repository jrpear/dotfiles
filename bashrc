# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

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

function user() {
	if [ ${USER} = "root" ]
	then
		echo "${COLOR_RED}${USER}${COLOR_ORIG}"
	else
		echo "${COLOR_ORIG}${USER}"
	fi
}

GIT_PROMPT_INFO="${COLOR_ORIG}\$(git_leader)${COLOR_RED}\$(git_branch)${COLOR_ORIG}\$(git_follower)"

PS1="$(user)@${COLOR_CYAN}\h${COLOR_ORIG} ${COLOR_MAGENTA}[\W]${COLOR_ORIG} ${GIT_PROMPT_INFO}${COLOR_ORIG}"

HISTSIZE=1000
HISTCONTROL=ignoreboth:erasedups
shopt -s histappend
shopt -s checkwinsize
shopt -s globstar
set -o vi
export EDITOR=vi

# ============================== ALIASES ===============================

function gh() { # git home
	cd $(git rev-parse --show-toplevel)
}

function swap() {
	tmpfile=$(mktemp $(dirname "$1")/XXXXXX)
	mv "$1" "$tmpfile" && mv "$2" "$1" &&  mv "$tmpfile" "$2"
}

function rebwin() {
	local bootnum=$(efibootmgr | grep 'Windows Boot Manager' | sed -e 's/Boot\([0-9]\)*.*/\1/')
	sudo efibootmgr -n $bootnum
	reboot
}

function vinfo() {
	vim -c "Info $1" -c "silent only"
}

alias g=git
alias o=xdg-open

alias glogout='loginctl kill-user $USER'
alias loghack='sudo systemctl emergency'

alias uchmod='chmod -R a=r,u+w,a+X'

alias ssh-hosts="grep -P \"^Host ([^*]+)$\" $HOME/.ssh/config | sed 's/Host //'"

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

