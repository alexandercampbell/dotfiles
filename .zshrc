
# zplug setup
source "$HOME/dotfiles/vendor/antigen.zsh"
antigen use oh-my-zsh
antigen bundle 'git'
antigen bundle 'vi-mode'
antigen bundle 'zsh-users/zsh-autosuggestions'
antigen bundle 'zsh-users/zsh-syntax-highlighting'
antigen theme eastwood
antigen apply

# Taken from the arrow zsh theme
# See https://geoff.greer.fm/lscolors/
export LSCOLORS="exfxcxdxbxbxbxbxbxbxbx"
export LS_COLORS="di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=31;40:cd=31;40:su=31;40:sg=31;40:tw=31;40:ow=31;40:"

# Repository status check for large repositories is much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Can't use the -s switch to `which` in certain implementations, so pipe to
# /dev/null instead.
if which nvim > /dev/null; then
	alias vi=nvim
	export MANPAGER="nvim -c 'set ft=man' -"
	export EDITOR=nvim
	export VISUAL=nvim
fi

export SAVEHIST=2000
export HISTFILE=~/.zsh_history

# each terminal has its own command-line history
unsetopt share_history

export PATH="$HOME/bin:$PATH"
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

alias tree='tree -C'
alias htop='htop -d 5' # More frequent updates
alias gs='gst'

alias '..'='cd ..'
alias '...'='cd ../..'
alias '....'='cd ../../..'

# Why does zsh reserve "time" as a keyword?
# I want to use the command.
alias time='/usr/bin/time'

alias nrepl="$HOME/dotfiles/scripts/nrepl.sh"
alias uberdeps="$HOME/dotfiles/scripts/uberdeps.sh"

if which xset > /dev/null; then
	# Increase the key repeat rate
	# I don't like to wait
	xset r rate 250 60

	# attempt to disable mouse acceleration
	xset m 0 0
fi

sh "$HOME/dotfiles/vendor/base16-gruvbox-dark-medium.sh"

# Include local init script if it exists. This is for when the local computer
# needs custom configuration that I don't want in my standard dotfiles.
if [ -f "$HOME/.zshrc_local" ]; then
	source "$HOME/.zshrc_local"
fi

