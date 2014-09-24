
export GOPATH=~/workspace
export GOROOT=/usr/local/go
export EDITOR=vim

export PS1='[\w] \$ '
export CLICOLOR=true
export GREP_OPTIONS='--color=auto'

export PATH=$PATH:$GOPATH/bin
export GOMAXPROCS=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || sysctl -n hw.ncpu)

alias gocover="go test -coverprofile=c.out && go tool cover -html=c.out"
alias l="ls"
alias ll="ls -lh"
alias la="ls -la"
alias sl="ls"
alias open="xdg-open"
alias more=less

export PS1='[\w]\$ '

export TERM=xterm-256color

# Include local bash init script if it exists. This is for when the local
# computer needs custom configuration that I don't want in my standard
# dotfiles.
if [ -f "$HOME/.bash_profile_local" ]; then
	source "$HOME/.bash_profile_local"
fi

