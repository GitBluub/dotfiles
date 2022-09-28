# ~/.config/fish/config.fish

function posix-source
	for i in (cat $argv)
		set arr (echo $i |tr = \n)
  		set -gx $arr[1] $arr[2]
	end
end

set -gx VISUAL "nvim"
set -gx EDITOR "nvim"
set NPM_PACKAGES "$HOME/.npm-global"
set PATH $PATH $NPM_PACKAGES/bin
set PATH $PATH "$HOME/bin"
set PATH $PATH "$HOME/.config/rofi/bin"
set PATH $PATH "$HOME/.ghcup/bin"
set PATH $PATH "$HOME/.local/bin"

#  IBUS  (input  processor  (for  Japanese))
set  GTK_IM_MODULE "fcitx"
set  QT_IM_MODULE "fcitx"
set  XMODIFIERS "@im=fcitx"
set  GLFW_IM_MODULE "ibus"

alias k "kubectl"
alias g "git"
alias vim "nvim"
alias n "nvim"
alias v "nvim"
alias ionised 'fish -c "nmcli device wifi connect D8:54:A2:01:05:24 &> /dev/null &"'
alias icat "kitty +kitten icat"
starship init fish | source

