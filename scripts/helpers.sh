APP=${MUSIC_APP:-"spotify"}
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

music_status() {
    echo "$(playerctl status -p "$APP")"
}
