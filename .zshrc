
source "$HOME/dotfiles/vendor/antigen.zsh"
antigen bundle 'git'
antigen bundle 'vi-mode'
antigen bundle 'zsh-users/zsh-autosuggestions'
antigen bundle 'zsh-users/zsh-syntax-highlighting'
antigen apply

setopt promptsubst
export PROMPT='$($HOME/dotfiles/tool/zsh-prompt.clj $?)'
# Rust implementation is much faster but harder to modify.
#export PROMPT='$(ac-tool prompt $?)'
export RPROMPT=''

# Repository status check for large repositories is much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

export EDITOR=hx
export VISUAL=hx

export SAVEHIST=2000
export HISTFILE=~/.zsh_history

# make each instance of zsh have its own command-line history
unsetopt share_history

export PATH="$HOME/bin:$PATH"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.cargo/bin"

export GOPATH="$HOME/workspace/gopath"

alias ls='ls --color=auto --group-directories-first'
alias l='ls'
alias ll='ls -lh'
alias la='ls -la'
alias sl='ls'
alias dc='cd'

alias bb='rlwrap bb'

# Ref https://stackoverflow.com/a/24005600
alias strip-ansi="sed -r 's/\x1b\[[^@-~]*[@-~]//g'"

# Treat symbolic links to directories as jumps.
# This may not fit with traditional Linux model of a filesystem, but it makes
# more sense for my usages of symbolic links.
alias cd='cd -P'

alias gb='git branch -vv'
alias gs='gst'
alias gdt='git difftool'
alias git-watcher='watch -n 1 --no-title --color "
   echo === LAST COMMIT === &&
   git -c color.ui=always show --stat &&
   echo && echo && echo === STATUS === &&
   git -c color.ui=always status &&
   echo && echo && echo === UNSTAGED === &&
   git -c color.ui=always diff --stat
   "'

alias '..'='cd ..'
alias '...'='cd ../..'
alias '....'='cd ../../..'

# Why does zsh reserve "time" as a keyword?
# I want to use the command.
alias time='/usr/bin/time'

if which xset > /dev/null; then
	# Increase the key repeat rate
	# I don't like to wait
	xset r rate 250 60

	# attempt to disable mouse acceleration
	xset m 0 0
fi

if [[ "$(uname)" = 'Darwin' ]]
then
	APPLE_INTERFACE_STYLE=$(defaults read -g AppleInterfaceStyle 2>/dev/null)
	if [[ $APPLE_INTERFACE_STYLE = 'Dark' ]]
	then
		export DARK_MODE=1
	else
		export DARK_MODE=0
	fi
else
	# not on MacOS-- not sure how you detect dark theme on ubuntu
	# default to dark
	export DARK_MODE=1
fi

"$HOME/dotfiles/tool/theme-switcher.clj"

# Include local init script if it exists. This is for when the local computer
# needs custom configuration that I don't want in my standard dotfiles.
if [ -f "$HOME/.zshrc_local" ]; then
	source "$HOME/.zshrc_local"
fi
