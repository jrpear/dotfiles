export ZSH=$(realpath ~/.oh-my-zsh)

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

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
