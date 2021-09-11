# =============================== PROMPT ===============================

function git_prompt_info() {
	if [ "$(git rev-parse --is-inside-work-tree 2>&1)" = "true" ]
	then
		BRANCH=$(git rev-parse --abbrev-ref --symbolic-full-name HEAD 2> /dev/null)
		echo "git:(%F{red}$BRANCH%f) "
	fi
}

setopt PROMPT_SUBST
PS1='%(?:%{%}➜ :%F{red}%{%}➜ %f) %F{cyan}%c%f $(git_prompt_info)'

HISTSIZE=1000

setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
unsetopt BEEP

set -o vi

# 200 ms
export KEYTIMEOUT=20

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
	includes+=($(find /usr/share/fzf -name 'key-bindings.zsh'))
	includes+=($(find /usr/share/fzf -name 'completion.zsh'))
fi

if [ -d $HOME ]; then
	includes+=($(find $HOME -maxdepth 1 -name '.zshrc.local'))
fi

for i in ${includes[*]}; do
	source $i
done
