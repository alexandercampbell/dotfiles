
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="arrow"

# This makes repository status check for large repositories much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

HIST_STAMPS="yyyy-mm-dd"

# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

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
alias dc="cd"

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
alias tree='tree -C'
alias htop='htop -d 5' # More frequent updates
alias gpre="hub pull-request"
alias reload='echo "source ~/.zshrc"; source ~/.zshrc'
alias pip='pip2'

# random_hash generates a random-ish list of uuid characters.
alias random_hash="python2 -c 'from uuid import uuid4; print \"\".join(str(uuid4()).split(\"-\")[0:2])'"

# Include local init script if it exists. This is for when the local computer
# needs custom configuration that I don't want in my standard dotfiles.
if [ -f "$HOME/.zshrc_local" ]; then
	source "$HOME/.zshrc_local"
fi

