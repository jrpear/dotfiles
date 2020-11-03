# PROMPT

function git_prompt_info() {
    if [ "$(git rev-parse --is-inside-work-tree 2>&1)" = "true" ]
    then
        BRANCH=$(git branch --show-current)
        echo "git:(%F{red}$BRANCH%f) "
    fi
}

setopt PROMPT_SUBST
PS1='%(?:%{%}➜ :%F{red}%{%}➜ %f) %F{cyan}%c%f $(git_prompt_info)'

HISTSIZE=1000

setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS

set -o vi

# 200 ms
KEYTIMEOUT=20

export PATH=$PATH:~/.local/bin

# ALIASES

function gh() { # git home
    cd $(git rev-parse --show-toplevel)
}

if command -v nvim &> /dev/null
then
    alias vim='nvim'
    export EDITOR=nvim
else
    export EDITOR=vim
fi

alias uchmod='chmod -R a=r,u+w,a+X'

alias ...='../..'
alias ....='../../..'
alias .....='../../../..'

test -f ~/.zshrc.local && source ~/.zshrc.local
