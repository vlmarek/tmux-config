#!/bin/bash
set -eu

raw="${1:-}"
# Accept both "3" and ":3"
target="${raw#:}"

# Must be numeric window index
case "$target" in
  ''|*[!0-9]*)
    tmux display-message "number: enter numeric index"
    exit 0
    ;;
esac

current=$(tmux display-message -p '#{window_index}')

# Same index: nothing to do
[ "$target" = "$current" ] && exit 0

if tmux list-windows -F '#{window_index}' | ggrep -qx "$target"; then
  # Target exists: swap current window with target window.
  # Then switch to target index where the current window moved.
  tmux swap-window -s ":$current" -t ":$target"
  tmux select-window -t ":$target"
else
  # Target does not exist: move current window to target index
  tmux move-window -t ":$target"
fi
