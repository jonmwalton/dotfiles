#!/bin/sh
source "$CONFIG_DIR/colors.sh"

POPUP_OFF='sketchybar --set tasks popup.drawing=off'
PENDING_TASK=$(task +PENDING count)
OVERDUE_TASK=$(task +OVERDUE count)

if [[ $PENDING_TASK == 0 ]]; then
	sketchybar --set $NAME label.drawing=off \
		icon.padding_left=4 \
		icon.padding_right=4
else
	if [[ $OVERDUE_TASK == 0 ]]; then
		LABEL=$PENDING_TASK
	else
		LABEL="!$OVERDUE_TASK/$PENDING_TASK"
	fi

    if [[ $NAME == "tasks.anchor" ]]; then
        sketchybar --set $NAME label="${LABEL}" \
            label.drawing=on \
            icon.padding_left=6 \
            icon.padding_right=2
    fi
fi


# Loop through each task
for ((i=1; i<=$PENDING_TASK; i++)); do
  echo "Loop iteration $i"
  description=$(task _get $i.description)
  
  task_item=(
    icon=":check_box:"
    icon.font="sketchybar-app-font:Regular:16.0"
      label="$description"
      click_script="task rc.confirmation=off $i done; $POPUP_OFF; sketchybar --remove $i.task"
      background.height=15
      #y_offset=$yoffset
      #padding_right=120
    )

  sketchybar --add item $i.task popup.tasks.anchor    \
              --set $i.task "${task_item[@]}" \

  # Add your commands or actions here
done


mouse_clicked () {
  case "$NAME" in
    "task.add") add_task
    ;;
    *) exit
    ;;
  esac
}

add_task () {

    osascript -e 'set theResponse to display dialog "Enter task description" default answer "" with icon note buttons {"Cancel", "Continue"} default button "Continue"' -e 'do shell script "task add " & text returned of theResponse'
}

popup () {
  sketchybar --set tasks.anchor popup.drawing=$1
}

case "$SENDER" in
  "mouse.clicked") mouse_clicked
  ;;
  "mouse.entered") popup on
  ;;
  "mouse.exited"|"mouse.exited.global") popup off
  ;;
esac

