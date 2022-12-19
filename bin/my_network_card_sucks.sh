#!/bin/bash
#

CONNECTION=$(nmcli connection show --active | grep wifi | awk '{print $1}')
nmcli connection up $CONNECTION
