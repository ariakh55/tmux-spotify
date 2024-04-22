#!/usr/bin/env bash
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/helpers.sh"

print_player_color() {   
  echo $(get_player_color)
}

main() {
    print_player_color
}

main
