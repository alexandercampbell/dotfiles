
# Include local bashrc if it exists
if [ -f "$HOME/.bashrc_local" ]; then
	. "$HOME/.bashrc_local"
fi

export GOPATH=~/workspace
export GOROOT=/usr/local/go
export EDITOR=vim

export PS1='[\w] \$ '
export CLICOLOR=true
export GREP_OPTIONS='--color=auto'

export PATH=$PATH:$GOPATH/bin
export GOMAXPROCS=8

alias ls="ls --color=auto"
alias l="ls"
alias ll="ls -lh"
alias la="ls -la"
alias sl="ls"

export PS1='[\w]\$ '

#if [[ ! $TERM =~ screen ]]; then
#	exec tmux
#fi

