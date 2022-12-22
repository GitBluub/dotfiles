#!/bin/bash

network='reload network'
translate='translate clipboard'
# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$network\n$translate\n" | rofi -dmenu 
}
chosen="$(run_rofi)"
case ${chosen} in
    $network)
        ~/bin/my_network_card_sucks.sh
        ;;
    $translate)
        ~/bin/translate_clipboard.sh
        ;;
esac
