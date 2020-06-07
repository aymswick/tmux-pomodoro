#!/usr/bin/env bash

# get status variable
init_status_right=$(tmux show-option -gqv 'status-right')

# start a pomodoro timer
status_right="Starting new pomodoro... ${init_status_right}"
tmux set-option -g status-right "$status_right"
sleep 1

# clear out status
tmux set-option -g status-right "$init_status_right"

for ((i=1500; i>=1; i--))
do
  if [ $(($i % 60)) == 0 ]; then
    seconds="00"
  else
    seconds=$(($i % 60))
  fi
  
  countdown_string="Working $(($i / 60)):$seconds remaining "
 
  # swap out time string
  status_right=${init_status_right}
  status_right="${countdown_string}${status_right}"

  # set new tmux status var
  tmux set-option -g status-right "$status_right"

  sleep 1
done

# Pomodoro Complete
tmux set-option -g status-right "$init_status_right"
done_string="Pomodoro complete! "
status_right=${done_string}${status_right}
tmux set-option -g status-right "$status_right"
sleep 2
tmux set-option -g status-right "$init_status_right"

for((i=500; i>=1; i--))
do
  countdown_string="Break time! $(($i / 60)):$(($i % 60)) remaining "

  # swap out time string
  status_right=${init_status_right}
  status_right="${countdown_string}${status_right}"

  # set new tmux status var
  tmux set-option -g status-right "$status_right"

  sleep 1
done

tmux set-option -g status-right "$init_status_right"
