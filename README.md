
## Dotfiles

This repo expects to live at `~/dotfiles`.

**Prerequisites**: zsh git curl alacritty zellij helix babashka iosevka

### Install

```shell
cd
git clone git@github.com:alexandercampbell/dotfiles.git
ln -s dotfiles/.config
ln -s dotfiles/.gitconfig
ln -s dotfiles/.zshrc
ln -s dotfiles/.zprint.edn
ln -s dotfiles/.ideavimrc
ln -s dotfiles/.rustfmt.toml

cd
exec zsh
```

