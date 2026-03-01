# ─── Helper ───────────────────────────────────────────────────────────────────

has_cmd() { command -v "$1" &>/dev/null }

# ─── Homebrew ─────────────────────────────────────────────────────────────────

if [ -d /home/linuxbrew/.linuxbrew ]; then
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [ -d /opt/homebrew ]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# ─── Antigen ──────────────────────────────────────────────────────────────────

if [ -f "$HOME/dotfiles/vendor/antigen.zsh" ]; then
	source "$HOME/dotfiles/vendor/antigen.zsh"
	antigen bundle 'git'
	antigen bundle 'vi-mode'
	antigen bundle 'zsh-users/zsh-autosuggestions'
	antigen bundle 'zsh-users/zsh-syntax-highlighting'
	antigen apply
fi

# ─── Prompt ───────────────────────────────────────────────────────────────────

setopt promptsubst

if has_cmd fk; then
	export PROMPT='$(fk prompt $?)'
else
	export PROMPT='%F{blue}%~%f %F{yellow}λ%f '
fi

# ─── Colors ───────────────────────────────────────────────────────────────────

if [ -f "$HOME/dotfiles/generated-ls-colors.zsh" ]; then
	source "$HOME/dotfiles/generated-ls-colors.zsh"
fi

# ─── Shell Options ────────────────────────────────────────────────────────────

autoload -U select-word-style
select-word-style bash

DISABLE_UNTRACKED_FILES_DIRTY="true"

export SAVEHIST=2000
export HISTFILE=~/.zsh_history
unsetopt share_history

# ─── Editor ───────────────────────────────────────────────────────────────────

if has_cmd hx; then
	export EDITOR=hx
	export VISUAL=hx
elif has_cmd nvim; then
	export EDITOR=nvim
	export VISUAL=nvim
else
	export EDITOR=vi
	export VISUAL=vi
fi

# ─── PATH ─────────────────────────────────────────────────────────────────────

[ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"
[ -d "$HOME/.local/bin" ] && export PATH="$PATH:$HOME/.local/bin"
[ -d "$HOME/.cargo/bin" ] && export PATH="$PATH:$HOME/.cargo/bin"

# ─── Go ───────────────────────────────────────────────────────────────────────

if has_cmd go; then
	export GOPATH="$HOME/workspace/gopath"
fi

# ─── GPG ──────────────────────────────────────────────────────────────────────

export GPG_TTY=$(tty)

# ─── Aliases ──────────────────────────────────────────────────────────────────

alias ls='ls --color=auto --group-directories-first'
alias l='ls'
alias ll='ls -lh'
alias la='ls -la'
alias sl='ls'
alias dc='cd'

alias cd='cd -P'

alias gb='git branch -vv'
alias gs='gst'
alias gdt='git difftool'

alias '..'='cd ..'
alias '...'='cd ../..'
alias '....'='cd ../../..'
alias '.....'='cd ../../../..'

alias strip-ansi="sed -r 's/\x1b\[[^@-~]*[@-~]//g'"
alias time='/usr/bin/time'

if has_cmd rlwrap && has_cmd bb; then
	alias bb='rlwrap bb'
fi

# ─── X11 ──────────────────────────────────────────────────────────────────────

if has_cmd xset; then
	xset r rate 250 60
	xset m 0 0
fi

# ─── Greeting ─────────────────────────────────────────────────────────────────

if has_cmd fk; then
	fk greet
fi

# ─── Local ────────────────────────────────────────────────────────────────────

if [ -f "$HOME/.zshrc_local" ]; then
	source "$HOME/.zshrc_local"
fi
