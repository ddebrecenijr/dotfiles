#!/bin/bash

# Terminate any running bar instances
killall -q polybar

# Wait until completely terminated
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Lanch Polybar, using config in $HOME/.config/polybar/config
polybar -c ~/.config/polybar/config.ini top &
polybar -c ~/.config/polybar/config.ini bottom &
echo "Polybar launched..."
