# Dotfiles

macOS setup managed by [nix-darwin](https://github.com/nix-darwin/nix-darwin) + [home-manager](https://github.com/nix-community/home-manager). The old Linux (i3/polybar/rofi) setup is under the `linux-era` tag.

| | |
| :--- | :--- |
| Window manager | [AeroSpace](https://github.com/nikitabobko/AeroSpace) |
| Terminal | [Ghostty](https://ghostty.org) + tmux ([Oh my tmux!](https://github.com/gpakosz/.tmux)) |
| Shell | zsh + starship |
| Editor | nvim ([lazyvim-nix](https://github.com/pfassina/lazyvim-nix)) |

## Layout

- `nix/`: flake (`flake.nix` system, `home.nix` user, `lazyvim.nix`)
- everything else: plain config files, linked into `$HOME` by `home.file` in `home.nix` with `mkOutOfStoreSymlink`. Edits apply live, no rebuild.

The repo must be cloned at `~/dotfiles`, the links point there.

## Bootstrap

```sh
git clone git@github.com:GitBluub/dotfiles.git ~/dotfiles
# install Nix: https://nixos.org/download
sudo nix run nix-darwin -- switch --flake ~/dotfiles/nix
```

## Update

```sh
sudo darwin-rebuild switch --flake ~/dotfiles/nix
nix flake update --flake ~/dotfiles/nix   # bump inputs
```
