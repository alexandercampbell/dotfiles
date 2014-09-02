
# Retrieve Pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Install Plugins
git clone git://github.com/altercation/vim-colors-solarized.git ~/.vim/bundle/vim-colors-solarized
git clone https://github.com/fatih/vim-go.git ~/.vim/bundle/vim-go
git clone git://github.com/tpope/vim-vinegar.git ~/.vim/bundle/vim-vinegar
git clone https://github.com/bling/vim-airline ~/.vim/bundle/vim-airline
git clone git://github.com/tpope/vim-sensible.git ~/.vim/bundle/vim-sensible

# Set up symbolic links to configuration files
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/vimrc ~/.vimrc
ln -s ~/dotfiles/bash_profile ~/.bash_profile

