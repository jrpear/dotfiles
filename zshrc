export ZSH=$(realpath ~/.oh-my-zsh)

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

function gh() { # git home
    cd $(git rev-parse --show-toplevel)
}

alias ...='../..'
alias ....='../../..'
alias .....='../../../..'
