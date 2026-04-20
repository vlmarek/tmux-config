#!/bin/bash
set -eu

pane_id=$(tmux display-message -p '#{pane_id}')
pipe_on=$(tmux display-message -p -t "$pane_id" '#{pane_pipe}')

if [ "$pipe_on" = "1" ]; then
  tmux pipe-pane -t "$pane_id"
  tmux display-message "Recording stopped for ${pane_id}"
  exit 0
fi

log_dir="$HOME/.tmux2/logs"
mkdir -p "$log_dir"

sess=$(tmux display-message -p '#{session_name}')
win=$(tmux display-message -p '#{window_index}')
pidx=$(tmux display-message -p '#{pane_index}')
ts=$(date +%Y%m%d-%H%M%S)
file="$log_dir/${sess}-w${win}-p${pidx}-${ts}.log"

tmux pipe-pane -t "$pane_id" "cat >> \"$file\""
tmux display-message "Recording started: ${file}"
