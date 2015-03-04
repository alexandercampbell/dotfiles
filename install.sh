
# Get required packages
sudo apt-get install -y zsh bash vim git mercurial tmux curl

# Install Oh-My-Zsh
curl -L http://install.ohmyz.sh | sh

# Install Vundle
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Set up symbolic links to configuration files
ln -s ~/dotfiles/tmux.conf      ~/.tmux.conf
ln -s ~/dotfiles/vimrc          ~/.vimrc
ln -s ~/dotfiles/bash_profile   ~/.bash_profile
ln -s ~/dotfiles/zshrc          ~/.zshrc


