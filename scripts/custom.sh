#!/usr/bin/env bash
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/helpers.sh"

print_custom() {   
    local status=$(music_status)
    local track=$(current_track_property "title" 1)
    local artist=$(current_track_property "artist" 2)

    if [ "$status" = "Playing" ] || [ "$status" = "Paused" ]; then
        echo "${artist}: ${track}"
    else 
        echo "No active players found"
    fi
}

main() {
    print_custom $APP
}

main
