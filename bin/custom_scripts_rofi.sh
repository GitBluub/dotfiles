#!/bin/bash

network='Reload network'
# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$network\n" | rofi -dmenu 
}
chosen="$(run_rofi)"
case ${chosen} in
    $network)
        ~/bin/my_network_card_sucks.sh
        ;;
esac
