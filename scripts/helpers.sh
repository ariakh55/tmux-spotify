APP=${MUSIC_APP:-"spotify"}

PLAYER_SELECT_CMD="playerctl status -a --format '{{playerName}}:{{lc(status)}}'"

ACTIVE_PLAYER=$($PLAYER_SELECT_CMD| tr -d "'" | grep 'playing' | head -n 1 | cut -d ":" -f 1)
DEFAULT_PLAYER=$([ -z "$ACTIVE_PLAYER" ] && $PLAYER_SELECT_CMD | tr -d "'" | tail -n 1 | cut -d ":" -f 1 || echo "$ACTIVE_PLAYER")

get_tmux_option() {
  local option=$1
  local default_value=$2
  local option_value=$(tmux show-option -gqv "$option")
  if [ -z "$option_value" ]; then
    echo "$default_value"
  else
    echo "$option_value"
  fi
}

set_tmux_option() {
  local option="$1"
  local value="$2"
  tmux set-option -gq "$option" "$value"
}

current_track_property() {
  local prop="${1}"
  local lines=$2
  echo "$(dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:org.mpris.MediaPlayer2.Player string:Metadata | grep -A ${lines} "${prop}" | tail -n 1 | cut -d '"' -f 2)"
}

get_track_property() {
  local prop="${1}"
  local track="$(playerctl metadata -p $DEFAULT_PLAYER ${prop})"
  echo $track | sed 's/\(.\{25\}\).*/\1.../'
}

get_player_status() {
  echo "$(playerctl status -p $DEFAULT_PLAYER)"
}

get_player_icon() {
  local appIcon="󰎆"
  if [ $DEFAULT_PLAYER = "spotify" ]; then
    appIcon=""
  elif [ $DEFAULT_PLAYER = "chromium" ]; then
    appIcon=""
  fi

  echo $appIcon
}

get_player_color() {
  local thm_cyan="#8cdceb"
  local thm_red="#f38ba8"
  local thm_green="#a6e3a1"
  local thm_blue="#8cb4fa"

  local appColor="$thm_blue"
  if [ $DEFAULT_PLAYER = "spotify" ]; then
    appColor="$thm_green"
  elif [ $DEFAULT_PLAYER = "chromium" ]; then
    appColor="$thm_red"
  fi

  echo $appColor
}

music_status() {
    echo "$(playerctl status -p "$APP")"
}
