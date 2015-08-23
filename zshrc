
export ZSH=$HOME/.oh-my-zsh

# Borrowed from http://unix.stackexchange.com/questions/9605/how-can-i-detect-if-the-shell-is-controlled-from-ssh
# Set SESSION_TYPE to remote/ssh if we're controlling the computer through
# remote SSH.
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
	SESSION_TYPE=remote/ssh
else
	case $(ps -o comm= -p $PPID) in
		sshd|*/sshd) SESSION_TYPE=remote/ssh;;
	esac
fi

# Set a different theme if we are ssh'd into a remote.
if [ "$SESSION_TYPE" = "remote/ssh" ]; then
	ZSH_THEME="gentoo"
else
	ZSH_THEME="eastwood"
fi

COMPLETION_WAITING_DOTS="true"

# This makes repository status check for large repositories much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

HIST_STAMPS="yyyy-mm-dd"

# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git docker)

source $ZSH/oh-my-zsh.sh

####################
# User configuration

export EDITOR=nvim
export VISUAL=nvim

# zsh vim keys instead of emacs
bindkey -v

export TERM=xterm-256color
export SAVEHIST=50000

unsetopt share_history

export GREP_OPTIONS='--color=auto'
export GOPATH=~/workspace
export PATH=$PATH:$GOPATH/bin:$HOME/bin

export GOMAXPROCS=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || sysctl -n hw.ncpu)

alias ls="ls --color=tty --group-directories-first"

alias l="ls"
alias ll="ls -lh"
alias la="ls -la"
alias sl="ls"

alias vi=nvim
alias open="xdg-open"
alias more=less
alias info="info --vi-keys"
alias irssi='TERM=screen-256color irssi'
alias open="xdg-open"
alias gocover="go test -coverprofile=c.out && go tool cover -html=c.out"
alias tree='tree -C'
alias gpre="hub pull-request"
alias reload='echo "source ~/.zshrc"; source ~/.zshrc'

unalias 9

alias cleandocker="docker rm -f \`docker ps -a -q\`; docker rmi -f \`docker images -q -f dangling=true\`"

# Include local init script if it exists. This is for when the local computer
# needs custom configuration that I don't want in my standard dotfiles.
if [ -f "$HOME/.zshrc_local" ]; then
	source "$HOME/.zshrc_local"
fi

