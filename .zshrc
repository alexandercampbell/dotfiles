
# zplug setup
source ~/.zplug/init.zsh
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug 'zsh-users/zsh-autosuggestions'
#zplug 'zsh-users/zsh-syntax-highlighting', defer:2
zplug "b4b4r07/zsh-vimode-visual", defer:3 # defer for zsh-syntax-highlighting
zplug 'themes/eastwood', from:oh-my-zsh
#zplug 'themes/arrow', from:oh-my-zsh
zplug 'plugins/git', from:oh-my-zsh
zplug load

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

# configure a workspace for Golang development
export GOPATH=~/workspace
export PATH="$PATH:$GOPATH/bin"

# this shouldn't be necessary (iirc, all Go programs fall back to /usr/local/go
# as a default value when GOROOT is unset), but it fixes jump-to-definition
# using my vim-go plugin
export GOROOT=/usr/local/go

# add ~/bin to path
export PATH="$PATH:$HOME/bin"

# add cargo (rust) bin directory to path
# allows simple cargo installs with
#
#	cargo install --git "https://some_url"
#
export PATH="$PATH:$HOME/.cargo/bin"

# yes show me what happened when a program crashes thanks
export RUST_BACKTRACE=1

# Ensure TERM is set to screen-256color.
# Fixes some color issues that can happen with tmux and neovim.
export TERM='screen-256color'

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
alias more=less
alias info="info --vi-keys"
alias open="xdg-open"
alias tree='tree -C'
alias htop='htop -d 5' # More frequent updates
alias gpre="hub pull-request"
alias reload='exec zsh'
alias gs='gst'
alias rg='rg -n' # ripgrep line numbers by default
alias k='kubectl'
alias gcc='gcc-7'

alias '..'='cd ..'
alias '...'='cd ../..'
alias '....'='cd ../../..'

# Why does zsh reserve "time" as a keyword?
# I want to use the command.
alias time='/usr/bin/time -p'

# Necessary to have an alias like this around since Docker fills up the disk so
# quickly with intermediate images.
docker-clean() {
	(
	set -o xtrace
	docker rm $(docker ps -a -q)
	docker rm -v $(docker ps -a -q -f status=exited)
	docker rmi $(docker images -q -f dangling=true)
	)
}

# random_hash generates a random-ish list of uuid characters.
alias random_hash="python -c 'from uuid import uuid4; print \"\".join(str(uuid4()).split(\"-\")[0:2])'"

# mk_pass generates a new password, prints it, and copies to the clipboard
alias mk_pass='random_hash | tee /dev/tty | pbcopy'

# Include local init script if it exists. This is for when the local computer
# needs custom configuration that I don't want in my standard dotfiles.
if [ -f "$HOME/.zshrc_local" ]; then
	source "$HOME/.zshrc_local"
fi

SCREENFETCH_CACHE="$HOME/dotfiles/.screenfetch_cache"
if which screenfetch > /dev/null; then
	if [ -f "$SCREENFETCH_CACHE" ]; then
		cat "$SCREENFETCH_CACHE"
	else
		screenfetch | tee "$SCREENFETCH_CACHE"
	fi
else
	uname -a
fi

