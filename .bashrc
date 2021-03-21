# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/my_scripts" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH="$PATH:/$HOME/my_scripts"
export PATH="my_scripts/$PATH"
# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
