#!/bin/bash
set -eu

action="${1:-}"
parent=$(tmux show-options -gqv @tmux_parent 2>/dev/null || true)

if [ -z "$parent" ]; then
  line=$(tmux show-environment -g TMUX_PARENT 2>/dev/null || true)
  case "$line" in
    TMUX_PARENT=*) parent=${line#TMUX_PARENT=} ;;
  esac
fi

[ -n "$parent" ] || exit 0

case "$action" in
  new)
    tmux -L "$parent" new-window -n .
    ;;
  last)
    tmux -L "$parent" last-window
    ;;
  next)
    tmux -L "$parent" next-window
    ;;
  prev)
    tmux -L "$parent" previous-window
    ;;
  *)
    exit 1
    ;;
esac
