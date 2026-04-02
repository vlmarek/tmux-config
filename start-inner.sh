#!/bin/bash
set -eu

parent="${TMUX_PARENT:-}"
if [ -z "$parent" ] && [ -n "${TMUX:-}" ]; then
  parent=$(basename "$TMUX")
  parent="${parent%%,*}"
fi

[ -n "$parent" ] || exit 1

# One inner server per outer window
wid=$(tmux display-message -p "#{window_id}" 2>/dev/null || echo "w0")
wid="${wid#@}"
sock="tmux2-inner-${parent}-${wid}"
sock=$(printf "%s" "$sock" | tr -c 'A-Za-z0-9._-' '_')

# Export parent so inner tmux server keeps it in global environment
export TMUX_PARENT="$parent"

exec tmux -L "$sock" -f ~/.tmux2/inner.conf new-session -A -s inner -n .
