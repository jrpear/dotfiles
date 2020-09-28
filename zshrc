function git_prompt_info() {
    if [ -d .git ]
    then
        BRANCH=$(git branch --show-current /dev/null)
        echo "git:(%F{red}$BRANCH%f) "
    fi
}

setopt PROMPT_SUBST
PS1='%(?:%{%}➜ :%F{red}%{%}➜ %f) %F{cyan}%c%f $(git_prompt_info)'

set -o vi

if command -v nvim &> /dev/null
then
    alias vim='nvim'
fi

function gh() { # git home
    cd $(git rev-parse --show-toplevel)
}

alias ...='../..'
alias ....='../../..'
alias .....='../../../..'

test -f ~/.zshrc.local && source ~/.zshrc.local
