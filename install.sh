#!/bin/bash
#
which stow || yay -S stow
stow config -t $HOME/.config
stow tmux -t $HOME
stow bin -t $HOME/bin
stow wallpapers -t $HOME/wallpapers

# fish
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
