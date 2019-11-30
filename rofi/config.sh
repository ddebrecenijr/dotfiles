#!/bin/bash

rofi -no-lazy-grab -show drun \
    -display-drun "Applications :" -drun-display-format "{name}" \
    -hide-scrollbar true \
    -bw 0
    -lines 10 \
    -line-padding 10 \
    -padding 20 \
    -width 30 \
    -xoffset 10 -yoffset 40 \
    -location 1 \
    -columns 2 \
    -show-icons -icon-theme "Papirus" \
    -font "Noto Sans 9" \
    -color-enabled true \
    -color-window "#383c4a,#383c4a,#383c4a" \
    -color-normal "#3c4150,#b0b0b0,#3c4150,#476b99,#ffffff" \
    -color-active "#383c4a,#00897b,#3c4150,#476b99,#ffffff" \
    -color-urgent "#383c4a,#fdd835,#3c4150,#476b99,#ffffff" 
