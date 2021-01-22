#!/bin/bash

# Specifying the icon(s) in the script
# This allows us to change its appearance conditionally
icon=""

playingColor="%{F#78a090}" # Orange
#playingColor="%{F#D08770}" # Orange
pausedColor="%{F#65737E}" # Gray
stoppedColor="%{F#65737E}" # Gray



if [ "$#" -gt 0 ]; then
  playerctl -i "$ignoredPlayers" $@ 2> /dev/null
  exit $?
fi

player_status=$(playerctl -i "$ignoredPlayers" status 2> /dev/null)
if [[ $? -eq 0 ]]; then
    metadata="$(playerctl -i "$ignoredPlayers" metadata artist 2> /dev/null) - $(playerctl -i "$ignoredPlayers" metadata title 2> /dev/null)"
else
	metadata="No music playing"
fi

# Foreground color formatting tags are optional
if [[ $player_status = "Playing" ]]; then
    echo "$playingColor$icon $metadata"       # when playing
elif [[ $player_status = "Paused" ]]; then
    echo "$pausedColor$icon $metadata"        # when paused
else
    echo "$stoppedColor$icon $metadata"       # when stopped
fi
