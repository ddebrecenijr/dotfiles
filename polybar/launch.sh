#!/bin/bash

echo "Preparing to launch Polybar..."

echo "Terminating any existing instances."
killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

echo "Launching Polybar."
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload -c $HOME/.config/polybar/config.ini main &
  done
else
  polybar -c $HOME/.config/polybar/config.ini main &
fi

echo "Polybar launched..."
