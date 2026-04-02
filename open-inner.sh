#!/bin/bash
set -eu

# Do not relaunch if pane already runs tmux.
cmd=$(tmux display-message -p "#{pane_current_command}" 2>/dev/null || true)
[ "$cmd" = "tmux" ] && exit 0

parent=$(basename "$(tmux display-message -p "#{socket_path}")")
parent="${parent%%,*}"

# Replace current pane command with inner tmux startup.
exec tmux respawn-pane -k "TMUX_PARENT=$parent ~/.tmux2/start-inner.sh"
