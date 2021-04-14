# PROMPT

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

# ALIASES

function gh() { # git home
    cd $(git rev-parse --show-toplevel)
}

alias g=git

alias uchmod='chmod -R a=r,u+w,a+X'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

test -f ~/.zshrc.local && source ~/.zshrc.local
