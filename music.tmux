#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/scripts/helpers.sh"

artist="#($CURRENT_DIR/scripts/artist.sh)"
album="#($CURRENT_DIR/scripts/album.sh)"
track="#($CURRENT_DIR/scripts/track.sh)"
music_status="#($CURRENT_DIR/scripts/status.sh)"
music_custom="#($CURRENT_DIR/scripts/custom.sh)"
player_status="#($CURRENT_DIR/scripts/general_status.sh)"
general_player="#($CURRENT_DIR/scripts/general_player.sh)"
player_icon="#($CURRENT_DIR/scripts/player_icon.sh)"
player_color="#($CURRENT_DIR/scripts/player_color.sh)"

artist_interpolation="\#{artist}"
album_interpolation="\#{album}"
track_interpolation="\#{track}"
status_interpolation="\#{music_status}"
custom_interpolation="\#{music_custom}"
player_status_interpolation="\#{player_status}"
general_player_interpolation="\#{general_player}"
player_icon_interpolation="\#{player_icon}"
player_color_interpolation="\#{player_color}"

#Backwards compatibility
spotify_artist=artist
spotify_album=album
spotify_track=track
spotify_status=music_status
spotify_custom=music_custom
spotify_general_status=player_status
spotify_general_player=music_general_player
spotify_player_icon="player_icon"
spotify_player_color="player_color"

spotify_artist_interpolation=artist_interpolation
spotify_album_interpolation=album_interpolation
spotify_track_interpolation=track_interpolation
spotify_status_interpolation=status_interpolation
spotify_custom_interpolation=custom_interpolation
spotify_general_status_interpolation=player_status_interpolation
spotify_general_player_interpolation=general_player_interpolation
spotify_player_icon_interpolation="player_icon_interpolation"
spotify_player_color_interpolation="player_color_interpolation"

do_interpolation() {
  local output="$1"
  local output="${output/$artist_interpolation/$artist}"
  local output="${output/$album_interpolation/$album}"
  local output="${output/$track_interpolation/$track}"
  local output="${output/$status_interpolation/$music_status}"
  local output="${output/$custom_interpolation/$music_custom}"
  local output="${output/$player_status_interpolation/$player_status}"
  local output="${output/$general_player_interpolation/$general_player}"
  local output="${output/$player_icon_interpolation/$player_icon}"
  local output="${output/$player_color_interpolation/$player_color}"
  echo "$output"
}

update_tmux_uptime() {
  local option="$1"
  local option_value="$(get_tmux_option "$option")"
  local new_option_value="$(do_interpolation "$option_value")"
  set_tmux_option "$option" "$new_option_value"
}

main() {
  update_tmux_uptime "status-right"
  update_tmux_uptime "status-left"
}
main
