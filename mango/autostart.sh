#! /bin/bash

set +e

waybar -c ~/.config/mango/config.jsonc -s ~/.config/mango/style.css >/dev/null 2>&1 &

dunst &

waypaper --restore

/usr/bin/emacs --daemon
