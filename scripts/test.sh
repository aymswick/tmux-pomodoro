#!/usr/bin/bash
myvar="Working 14:30 remaining"
#echo $myvar

status_right=$(tmux show-option -gqv 'status-right')
status_right="${myvar}${status_right}"
status_right=${status_right//Working [0-9][0-9]:[0-9][0-9] remaining/}

tmux set-option -g status-right "$status_right"

