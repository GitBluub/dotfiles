#!/bin/env bash
mkdir back
cp ~/.config/i3/config back/i3.conf
cp ~/.bashrc back/.bashrc

rm -f ~/.config/i3/config
rm -f ~/.bashrc

ln -s "$(pwd)/i3.conf" "$HOME/.config/i3/config"
ln -s "$(pwd)/.bashrc" "$HOME/.bashrc"

