# ~/.config/fish/config.fish

set -gx KUBECONFIG "/home/bluub/EPI/3/DOP/bernstein/kubeconfig"
set -gx VISUAL "nvim"
set -gx EDITOR "nvim"
set NPM_PACKAGES "$HOME/.npm-packages"
set PATH $PATH $NPM_PACKAGES/bin
set PATH $PATH "/home/bluub/my_scripts"
set MANPATH $NPM_PACKAGES/share/man $MANPATH
starship init fish | source

