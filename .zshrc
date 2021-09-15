
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

# make each instance of zsh have its own command-line history
unsetopt share_history

export PATH="$HOME/bin:$PATH"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.cargo/bin"

alias ls='ls --color=auto --group-directories-first'
alias l='ls'
alias ll='ls -lh'
alias la='ls -la'
alias sl='ls'
alias dc='cd'

# Treat symbolic links to directories as jumps.
# This may not fit with traditional Linux model of a filesystem, but it makes
# more sense for my usages of symbolic links.
alias cd='cd -P'

alias gs='gst'

alias '..'='cd ..'
alias '...'='cd ../..'
alias '....'='cd ../../..'

# Why does zsh reserve "time" as a keyword?
# I want to use the command.
alias time='/usr/bin/time'

alias nrepl="$HOME/dotfiles/scripts/nrepl.sh"
alias uberdeps="$HOME/dotfiles/scripts/uberdeps.sh"
alias prettify-json='bb -i "(-> (str/join \\n *input*) json/parse-string (json/generate-string {:pretty true}) println)"'

if which xset > /dev/null; then
	# Increase the key repeat rate
	# I don't like to wait
	xset r rate 250 60

	# attempt to disable mouse acceleration
	xset m 0 0
fi

sh "$HOME/dotfiles/vendor/snow_dark.sh"

# Include local init script if it exists. This is for when the local computer
# needs custom configuration that I don't want in my standard dotfiles.
if [ -f "$HOME/.zshrc_local" ]; then
	source "$HOME/.zshrc_local"
fi
