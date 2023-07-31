#!/bin/bash
#
which stow || yay -S stow
stow config -t $HOME/.config
stow tmux -t $HOME
stow bin -t $HOME/bin
stow wallpapers -t $HOME/wallpapers
ln -s $HOME/dotfiles/zsh/.zshrc $HOME/.zshrc
ln -s $HOME/dotfiles/.gitconfig $HOME/.gitconfig

# fish
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish

# for gnome
# dconf load / < gnome-settings.ini
