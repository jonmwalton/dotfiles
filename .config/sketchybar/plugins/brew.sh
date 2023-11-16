#!/bin/bash

source "$CONFIG_DIR/colors.sh"

COUNT="$(brew outdated | wc -l | tr -d ' ')"
#OUTDATED=$(brew outdated)

COLOR=$RED

case "$COUNT" in
  [3-5][0-9]) COLOR=$ORANGE
  ;;
  [1-2][0-9]) COLOR=$YELLOW
  ;;
  [1-9]) COLOR=$WHITE
  ;;
  0) COLOR=$GREEN
     COUNT=􀆅
  ;;
esac

if [[ $NAME == "brew" ]]; then
  sketchybar --set $NAME label=$COUNT icon.color=$COLOR
fi

outdated=(
    #icon=":check_box:"
    #icon.font="sketchybar-app-font:Regular:16.0"
      #label="$OUTDATED"
      #click_script="task rc.confirmation=off $i done; $POPUP_OFF; sketchybar --remove $i.task"
      background.height=15
      #y_offset=$yoffset
      #padding_right=120
    )

#  sketchybar --add item outdated popup.brew    \
#              --set outdated "${outdated[@]}" \

#popup () {
 # sketchybar --set brew popup.drawing=$1
#}

case "$SENDER" in
  "mouse.clicked") mouse_clicked
  ;;
 # "mouse.entered") popup on
 # ;;
 # "mouse.exited"|"mouse.exited.global") popup off
 # ;;
esac
