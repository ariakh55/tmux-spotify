#!/usr/bin/env bash
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/helpers.sh"

print_general_player() {   
    local status=$(get_player_status)
    local track=$(get_track_property "title")
    local artist=$(get_track_property "artist")

    if [ "$status" = "Playing" ] || [ "$status" = "Paused" ]; then
        echo "${artist}: ${track}"
    else 
        echo "No active players found"
    fi
}

main() {
  print_general_player $APP
}

main
