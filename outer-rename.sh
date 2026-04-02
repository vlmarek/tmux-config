#!/bin/bash
set -eu

name="${1:-}"
[ -n "$name" ] || exit 0

parent=$(tmux show-options -gqv @tmux_parent 2>/dev/null || true)
if [ -z "$parent" ]; then
  line=$(tmux show-environment -g TMUX_PARENT 2>/dev/null || true)
  case "$line" in
    TMUX_PARENT=*) parent=${line#TMUX_PARENT=} ;;
  esac
fi
[ -n "$parent" ] || exit 0

exec tmux -L "$parent" rename-window -- "$name"
