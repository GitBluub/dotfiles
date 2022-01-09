# ~/.config/fish/config.fish

set -gx VISUAL "nvim"
set -gx EDITOR "nvim"
set NPM_PACKAGES "$HOME/.npm-packages"
set PATH $PATH $NPM_PACKAGES/bin
set PATH $PATH "$HOME/my_scripts"
set PATH $PATH "$HOME/.config/rofi/bin"

alias ionised 'fish -c "nmcli device wifi connect D8:54:A2:01:05:24 &> /dev/null &"'
alias icat "kitty +kitten icat"
starship init fish | source

