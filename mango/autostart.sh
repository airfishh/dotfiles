#! /bin/bash

set +e

waybar -c ~/.config/mango/waybar_mango/config.jsonc -s ~/.config/mango/waybar_mango/style.css >/dev/null 2>&1 &

dunst &

waypaper --restore

/usr/bin/emacs --daemon
