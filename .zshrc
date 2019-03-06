
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

autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd ' ' edit-command-line

export LS_COLORS=""
export EDITOR=nvim
export VISUAL=nvim
export PAGER="nvim -c 'set ft=man' -"
export MANPAGER="$PAGER"

export SAVEHIST=2000
export HISTFILE=~/.zsh_history

# each terminal has its own command-line history
unsetopt share_history

# plan9, if I have it set up
export PLAN9="$HOME/workspace/src/github.com/9fans/plan9port"
export PATH="$PATH:$PLAN9/bin"

# add ~/bin to path
export PATH="$PATH:$HOME/bin"

# add cargo (rust) bin directory to path
# allows simple cargo installs with
#
#	cargo install --git "https://some_url"
#
export PATH="$PATH:$HOME/.cargo/bin"

# Ensure TERM is set to screen-256color.
# Fixes some color issues that can happen with tmux and neovim.
export TERM='screen-256color'

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

if which xset > /dev/null; then
	# Increase the key repeat rate
	# I don't like to wait
	xset r rate 250 60
fi

# load theme if it's there
if [ -n "$PS1" ]; then
	theme_path="$HOME/.vim/plugged/snow/shell/snow_light.sh"
	if [ -f "$theme_path" ]; then
		sh "$theme_path"
	fi
	unset theme_path
fi

# Include local init script if it exists. This is for when the local computer
# needs custom configuration that I don't want in my standard dotfiles.
if [ -f "$HOME/.zshrc_local" ]; then
	source "$HOME/.zshrc_local"
fi

NEOFETCH_CACHE="$HOME/dotfiles/.neofetch_cache"
if which neofetch > /dev/null; then
	if [ -f "$NEOFETCH_CACHE" ]; then
		cat "$NEOFETCH_CACHE"
	else
		neofetch | tee "$NEOFETCH_CACHE"
	fi
else
	uname -a
fi

