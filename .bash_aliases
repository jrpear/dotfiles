alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias less='less -R'

alias pyhost='python3 -m http.server 8000 --bind 127.0.0.1 & > /tmp/pyhost.log
echo $! > /tmp/pyhost.pid'
# SWAP TO USING /var
alias pykillhost='xargs kill < /tmp/pyhost.pid; rm /tmp/pyhost.pid'
