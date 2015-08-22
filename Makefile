
.PHONY: all programs links vundle

all: programs vundle links tmux-plugin-manager

programs:
	# Get required packages (using the platform's development)
	if [[ $$(uname) == "Darwin" ]]; then \
		ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"; \
		brew install -y zsh bash vim git mercurial tmux curl; \
	else \
		sudo apt-get install -y zsh bash vim git mercurial tmux curl; \
	fi
	# Install Oh-My-Zsh (this step is platform-independent)
	curl -L http://install.ohmyz.sh | sudo sh
	# ohmyzsh comes with a zshrc. get rid of this so we can replace it with
	# ours.
	mv ~/.zshrc ~/.omz_zshrc_default

vundle:
	git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

tmux-plugin-manager:
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

links:
	# Set up symbolic links to configuration files
	ln -s ~/dotfiles/tmux.conf      ~/.tmux.conf
	ln -s ~/dotfiles/vimrc          ~/.vimrc
	ln -s ~/dotfiles/bash_profile   ~/.bash_profile
	ln -s ~/dotfiles/zshrc          ~/.zshrc
	# Alias nvimrc onto vimrc
	ln -s ~/.vimrc                  ~/.nvimrc


