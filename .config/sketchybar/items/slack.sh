#!/bin/bash

source "$CONFIG_DIR/icons.sh"

slack=(
  padding_right=8
  padding_right=2
  icon=":slack:"
  icon.font="sketchybar-app-font:Regular:16.0"
  label.color=$WHITE
  script="$PLUGIN_DIR/noti_slack.sh"
  label=""
  update_freq=60
  updates=true
)

sketchybar --add item slack right \
           --set slack "${slack[@]}" \
           --subscribe slack mouse.clicked

# sketchybar --add item slack right                                     \
#            --set      slack script="$PLUGIN_DIR/noti_slack.sh"       \
#                            update_freq=60                            \
#                            padding_left=8                            \
#                            padding_right=2                           \
#                            background.border_width=0                 \
#                            background.height=24                      \
#                            icon=":slack:"                           \
#                            icon.font="sketchybar-app-font:Regular:16.0" \
#                            icon.color=$WHITE                   \
#                            label.color=$WHITE                  \
#                            label.drawing=on                     \
#                            label.width=10                   \
#                            label="$LABEL"\
#                            icon.highlight=on                  \
# 						    icon.highlight_color=$WHITE \
# 								label.highlight=on                 \
# 								label.highlight_color=$WHITE \
#                                 $NAME  \