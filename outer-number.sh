#!/bin/bash
set -eu

raw="${1:-}"
target="${raw#:}"

case "$target" in
  ''|*[!0-9]*)
    tmux display-message "number: enter numeric index"
    exit 0
    ;;
esac

parent=$(tmux show-options -gqv @tmux_parent 2>/dev/null || true)
if [ -z "$parent" ]; then
  line=$(tmux show-environment -g TMUX_PARENT 2>/dev/null || true)
  case "$line" in
    TMUX_PARENT=*) parent=${line#TMUX_PARENT=} ;;
  esac
fi
[ -n "$parent" ] || exit 0

current=$(tmux -L "$parent" display-message -p '#{window_index}')
[ "$target" = "$current" ] && exit 0

if tmux -L "$parent" list-windows -F '#{window_index}' | ggrep -qx "$target"; then
  tmux -L "$parent" swap-window -s ":$current" -t ":$target"
else
  tmux -L "$parent" move-window -t ":$target"
fi
