#!/usr/bin/env bash
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/helpers.sh"

print_player_icon() {   
  echo $(get_player_icon)
}

main() {
    print_player_icon
}

main
