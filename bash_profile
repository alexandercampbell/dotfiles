
# Include local bashrc if it exists
if [ -f "$HOME/.bashrc_local" ]; then
	source "$HOME/.bashrc_local"
fi

export GOPATH=~/workspace
export GOROOT=/usr/local/go
export EDITOR=vim

export PS1='[\w] \$ '
export CLICOLOR=true
export GREP_OPTIONS='--color=auto'

export PATH=$PATH:$GOPATH/bin
export GOMAXPROCS=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || sysctl -n hw.ncpu)

alias l="ls"
alias ll="ls -lh"
alias la="ls -la"
alias sl="ls"

alias gocover="go test -coverprofile=c.out && go tool cover -html=c.out"

export PS1='[\w]\$ '

#if [[ ! $TERM =~ screen ]]; then
#	exec tmux
#fi

