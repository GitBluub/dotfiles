#!/bin/bash
which stow || yay -S stow
stow config -t $HOME/.config
stow bin -t $HOME/bin
stow wallpapers -t $HOME/wallpapers
