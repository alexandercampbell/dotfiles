
export ZSH=$HOME/.oh-my-zsh

# Borrowed from http://unix.stackexchange.com/questions/9605/how-can-i-detect-if-the-shell-is-controlled-from-ssh
# Set SESSION_TYPE to remote/ssh if we're controlling the computer through
# remote SSH.
if (($+SSH_CLIENT)) || (($+SSH_TTY)); then
	SESSION_TYPE=remote/ssh
else
	case $(ps -o comm= -p $PPID) in
		sshd|*/sshd) SESSION_TYPE=remote/ssh;;
	esac
fi

# Set a different theme if we are ssh'd into a remote.
if (($+SESSION_TYPE)); then
	if [ "$SESSION_TYPE" = "remote/ssh" ]; then
		ZSH_THEME="gentoo"
	fi
else
	ZSH_THEME="arrow"
fi

COMPLETION_WAITING_DOTS="true"

# This makes repository status check for large repositories much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

HIST_STAMPS="yyyy-mm-dd"

# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# Temporarily disable a subset of the bash safe mode for oh-my-zsh loading.
set +uo nopipefail

source $ZSH/oh-my-zsh.sh

# Subset of the bash safe mode.
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
# Makes "git grep `git ls-files | grep .go`" work in repos with spaces in the
# filenames.
set -uo pipefail
IFS=$'\n\t'

export LS_COLORS=""
export EDITOR=nvim
export VISUAL=nvim
export MANPAGER="nvim -c 'set ft=man' -"

# zsh vim keys instead of emacs
bindkey -v

export TERM=xterm-256color
export GREP_OPTIONS='--color=auto'
export SAVEHIST=2000

# each terminal has its own command-line history
unsetopt share_history

# configure a workspace for Golang development
export GOPATH=~/workspace
export GOMAXPROCS=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || sysctl -n hw.ncpu)
export PATH="$PATH:$GOPATH/bin"

# add ~/bin to path
export PATH="$PATH:$HOME/bin"

# add cargo (rust) bin directory to path
# allows simple cargo installs with
#
#	cargo install --git "https://some_url"
#
export PATH="$PATH:$HOME/.cargo/bin"

alias ls="ls --color=tty --group-directories-first"
alias l="ls"
alias ll="ls -lh"
alias la="ls -la"
alias sl="ls"

# Treat symbolic links to directories as jumps.
# This may not fit with traditional Linux model of a filesystem, but it makes
# more sense for my usages of symbolic links.
alias cd="cd -P"

# Alias `vi` to either nvim or vim, depending on which is installed. Prefer
# nvim.
#
# Can't use the -s switch to `which` in certain implementations
# Better to pipe to /dev/null anyway.
if which nvim > /dev/null; then
	alias vi=nvim
else
	alias vi=vim
fi
alias vi=nvim
alias more=less
alias info="info --vi-keys"
alias irssi='TERM=screen-256color irssi'
alias open="xdg-open"
alias gocover="go test -coverprofile=c.out && go tool cover -html=c.out"
alias tree='tree -C'
alias htop='htop -d 5' # More frequent updates
alias gpre="hub pull-request"
alias reload='echo "source ~/.zshrc"; source ~/.zshrc'
alias pip='pip2'

# rtest helps you see the beginning of the Rust compilation errors more easily.
# The errors I want to fix first are at the top of the list, but sometimes I
# have to scroll through ten pages of other errors to get to them. I needed a
# way to see the first five or six errors easily.
alias rtest='clear; cargo test --color=always 2>&1 | head -32'

# random_hash generates a random-ish list of uuid characters.
alias random_hash="python2 -c 'from uuid import uuid4; print \"\".join(str(uuid4()).split(\"-\")[0:2])'"

# adapted from Travis S.'s shell alias
# Determine the process that is using a given port.
function portwho() {
	if [[ $# -ne 1 ]]; then
		echo "usage: portwho <port number>"
	else
		lsof -n -i:"$1" | grep "LISTEN"
	fi
}

unalias 9

alias cleandocker="docker rm -f \`docker ps -a -q\`; docker rmi -f \`docker images -q -f dangling=true\`"

# Include local init script if it exists. This is for when the local computer
# needs custom configuration that I don't want in my standard dotfiles.
if [ -f "$HOME/.zshrc_local" ]; then
	source "$HOME/.zshrc_local"
fi

