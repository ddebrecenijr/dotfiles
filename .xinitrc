#!/bin/sh

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

compton --config ~/.compton.conf &
~/.fehbg &
exec i3
