#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/helpers.sh"

playing_icon=""
paused_icon=""
stopped_icon=""

playing_default="▶︎"
paused_default="■"

print_music_status() {
  local status=$(music_status)

  if [[ "$status" == "Playing" ]]; then
    echo "${playing_icon}"
  elif [[ "$status" == "Paused" ]]; then
      echo "${paused_icon}"
  else
      echo "${stopped_icon:-$paused_icon}"
  fi
}

update_status_icon() {
  playing_icon=$(get_tmux_option "@spotify_playing_icon" "$playing_default")
  paused_icon=$(get_tmux_option "@spotify_paused_icon" "$paused_default")
  stopped_icon=$(get_tmux_option "@spotify_stopped_icon" "$paused_default")
}

main() {
  update_status_icon
  print_music_status
}

main


