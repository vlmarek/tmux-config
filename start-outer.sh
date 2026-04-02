#!/bin/bash
# Start/attach outer tmux on dedicated socket to avoid conflicts with existing setup.
exec env TMUX= tmux -L tmux2-outer -f ~/.tmux2/outer.conf new-session -A -s outer
