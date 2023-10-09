#!/bin/sh

source "$CONFIG_DIR/colors.sh" # Loads all defined colors
source "$CONFIG_DIR/icons.sh"

IP_ADDRESS=$(scutil --nwi | grep address | sed 's/.*://' | tr -d ' ' | head -1)
IS_VPN=$(scutil --nwi | grep -m1 'utun' | awk '{ print $1 }')

if [[ $IS_VPN != "" ]]; then
	COLOR=$WHITE
	ICON="$LOCK"
	LABEL="VPN"
elif [[ $IP_ADDRESS != "" ]]; then
	COLOR=$WHITE
	ICON="$WIFI_CONNECTED"
	LABEL=$IP_ADDRESS
else
	COLOR=$WHITE
	ICON="$WIFI_DISCONNECTED"
	LABEL="Not Connected"
fi

#sketchybar --set $NAME background.color=$COLOR \
#	icon=$ICON \
#	label="$LABEL"

sketchybar --add item  ip_address right                              \
		--set       ip_address script="$PLUGIN_DIR/ip_address.sh" \
								update_freq=30                     \
								padding_left=2                     \
								padding_right=8                    \
								background.border_width=0          \
								background.corner_radius=6         \
								background.height=24               \
								icon.highlight=on                  \
								icon.highlight_color=$WHITE \
								label.highlight=on                 \
								label.highlight_color=$WHITE \
								$NAME  \
								icon=$ICON \
								label="$LABEL"\
		--subscribe ip_address wifi_change wifi                      \