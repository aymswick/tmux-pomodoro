#!/usr/bin/env bash

# get status variable
status_right=$(tmux show-option -gqv 'status-right')

# set init message
#status_right="Starting new pomodoro... ${status_right}"
#tmux set-option -g status-right "$status_right"
sleep 1

# clear out last timer value
#status_right=${status_right//Starting new pomodoro... /}
status_right=${status_right//Working [0-9][0-9]:[0-9][0-9] remaining/}

for ((i=1500; i>=1; i--))
do
  if [ $(($i % 60)) == 0 ]; then
    seconds="00"
  else
    seconds=$(($i % 60))
  fi
  
  countdown_string="Working $(($i / 60)):$seconds remaining"
 
  # clear out last timer value
  status_right=${status_right//Working [0-9][0-9]:[0-9][0-9] remaining/}
  status_right="${countdown_string}${status_right}"
 
  # set new tmux status var
  tmux set-option -g status-right "$status_right"
  #eval tmux show-option -gqv status-right # show the result in stdout

  sleep 1
done

echo "Woo! Pomodoro complete."

for((i=500; i>=1; i--))
do
  echo "Break time!" $(($i / 60)):$(($i % 60)) "remaining "
  sleep 1
done
