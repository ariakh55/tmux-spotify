#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/helpers.sh"

print_track() {
  current_track_property "title" 1
}

main() {
  print_track $APP
}

main


