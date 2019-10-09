
# zplug setup
source "$HOME/dotfiles/vendor/antigen.zsh"
antigen use oh-my-zsh
antigen bundle 'git'
antigen bundle 'vi-mode'
antigen bundle 'zsh-users/zsh-autosuggestions'
antigen bundle 'zsh-users/zsh-syntax-highlighting'
antigen theme eastwood
antigen apply

# Repository status check for large repositories is much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

export LS_COLORS=""
export EDITOR=nvim
export VISUAL=nvim
export MANPAGER="nvim -c 'set ft=man' -"

export SAVEHIST=2000
export HISTFILE=~/.zsh_history

# each terminal has its own command-line history
unsetopt share_history

export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.cargo/bin"

export GOPATH="$HOME/workspace"

alias ls='ls --color=tty --group-directories-first'
alias l='ls'
alias ll='ls -lh'
alias la='ls -la'
alias sl='ls'
alias dc='cd'

# Treat symbolic links to directories as jumps.
# This may not fit with traditional Linux model of a filesystem, but it makes
# more sense for my usages of symbolic links.
alias cd='cd -P'

# Can't use the -s switch to `which` in certain implementations, so pipe to
# /dev/null instead.
if which nvim > /dev/null; then
	alias vi=nvim
fi

alias tree='tree -C'
alias htop='htop -d 5' # More frequent updates
alias gs='gst'

alias '..'='cd ..'
alias '...'='cd ../..'
alias '....'='cd ../../..'

# Why does zsh reserve "time" as a keyword?
# I want to use the command.
alias time='/usr/bin/time'

alias nrepl='clj -A:cider-clj'

if which xset > /dev/null; then
	# Increase the key repeat rate
	# I don't like to wait
	xset r rate 250 60
fi

if [ -n "$PS1" ]; then
	sh "$HOME/dotfiles/vendor/base16-zenburn.sh"
fi

# Include local init script if it exists. This is for when the local computer
# needs custom configuration that I don't want in my standard dotfiles.
if [ -f "$HOME/.zshrc_local" ]; then
	source "$HOME/.zshrc_local"
fi

