#!/bin/bash

# Trigger the brew_udpate event when brew update or upgrade is run from cmdline
# e.g. via function in .zshrc

brew=(
  icon=􀐛
  label=?
  padding_right=10
  script="$PLUGIN_DIR/brew.sh"
)

brew_outdated=(
  #icon=":add:"
  #icon.font="sketchybar-app-font:Regular:16.0"
  #icon.padding_left=5
  #icon.padding_right=5
  #icon.color=$WHITE
  #icon.highlight_color=$GREY
  label.drawing=on
  #label="Add new task"
  script="$PLUGIN_DIR/brew.sh"
  
)

sketchybar --add event brew_update \
           --add item brew right   \
           --set brew "${brew[@]}" \
           --subscribe brew brew_update mouse.entered mouse.exited \
                        mouse.exited.global        \
                                      \
            --add item brew.outdated popup.brew    \
            --set brew.outdated "${brew_outdated[@]}"
              

