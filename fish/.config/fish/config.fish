# ~/.config/fish/config.fish

set -gx VISUAL "nvim"
set -gx EDITOR "nvim"
set NPM_PACKAGES "$HOME/.npm-packages"
set PATH $PATH $NPM_PACKAGES/bin
set PATH $PATH "$HOME/bin"
set PATH $PATH "$HOME/.config/rofi/bin"
set PATH $PATH "$HOME/.ghcup/bin"
set PATH $PATH "$HOME/.local/bin"

alias k "kubectl"
alias g "git"
alias ionised 'fish -c "nmcli device wifi connect D8:54:A2:01:05:24 &> /dev/null &"'
alias icat "kitty +kitten icat"
starship init fish | source

