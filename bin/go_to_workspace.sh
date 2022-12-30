#!/bin/bash

chosen=$(hyprctl clients -j | jq -c '.[] | .title' | cut -d '"' -f 2 | rofi -dmenu -i)
workspace=$(hyprctl clients -j | jq -c ".[] | select(.title | contains(\"$chosen\")) | .workspace.name" | cut -d '"' -f 2)
hyprctl dispatch workspace $workspace
