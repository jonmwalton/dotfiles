#!/bin/bash

POPUP_CLICK_SCRIPT='sketchybar --set $NAME popup.drawing=toggle'


source "$CONFIG_DIR/icons.sh"

#TASKS=$(task _get 1.description)
#TASKS=$(task)



task_anchor=(
  padding_right=8
  padding_right=2
  icon=󱃔
  icon.font="sketchybar-app-font:Regular:16.0"
  label.color=$WHITE
  script="$PLUGIN_DIR/noti_task.sh"
  label=""
  update_freq=60
  updates=true
  click_script="$POPUP_CLICK_SCRIPT"
  popup.height=25
  drawing=on
  #popup.horizontal=on
  y_offset=0
)

task_add=(
  icon=":add:"
  icon.font="sketchybar-app-font:Regular:16.0"
  icon.padding_left=5
  icon.padding_right=5
  icon.color=$WHITE
  icon.highlight_color=$GREY
  label.drawing=on
  label="Add new task"
  script="$PLUGIN_DIR/noti_task.sh"
  
)

sketchybar --add item tasks.anchor right \
           --set tasks.anchor "${task_anchor[@]}" \
           --subscribe tasks.anchor mouse.entered mouse.exited \
                                      mouse.exited.global        \
                                      \
          --add item task.add popup.tasks.anchor    \
              --set task.add "${task_add[@]}" \
              --subscribe task.add mouse.clicked             \






