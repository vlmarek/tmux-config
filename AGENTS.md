# AGENTS.md - tmux2 session notes

This directory contains a custom nested tmux setup with two layers:
- outer tmux (prefix `Ctrl-x`)
- inner tmux (prefix `Ctrl-a`)

## Files
- `outer.conf` - outer tmux config
- `inner.conf` - inner tmux config
- `start-outer.sh` - start/attach outer tmux (`tmux -L tmux2-outer`)
- `start-inner.sh` - start/attach inner tmux for current outer window
- `open-inner.sh` - auto-start inner tmux in newly created outer windows
- `outer-action.sh` - inner-to-outer actions for `Ctrl-x` key table
- `number.sh` - move-or-swap helper used by `Ctrl-a N`

## Startup
Run:
```bash
~/.tmux2/start-outer.sh
```

## Active keybindings

### Inner tmux (`Ctrl-a` prefix)
- `Ctrl-a c` / `Ctrl-a Ctrl-c` - new inner window
- `Ctrl-a n` / `Ctrl-a <Space>` - next inner window
- `Ctrl-a p` - previous inner window
- `Ctrl-a Ctrl-a` / `Ctrl-a a` - last inner window
- `Ctrl-a ' ` - choose inner window
- `Ctrl-a A` - rename current inner window
- `Ctrl-a N` - prompt for index and move/swap window (`number.sh`)
- `Ctrl-a |` - split side by side
- `Ctrl-a -` - split top/bottom
- `Ctrl-a h/j/k/l` - select pane left/down/up/right

### Outer tmux controls (from inner via `Ctrl-x` key table)
- `Ctrl-x c` / `Ctrl-x Ctrl-c` - new outer window (auto-starts inner)
- `Ctrl-x n` / `Ctrl-x <Space>` - next outer window
- `Ctrl-x p` - previous outer window
- `Ctrl-x Ctrl-x` / `Ctrl-x x` - last outer window
- `Ctrl-x ' ` - choose outer window

### Outer tmux direct prefix (`Ctrl-x`)
- `Ctrl-x c` / `Ctrl-x Ctrl-c` - new outer window
- `Ctrl-x n` / `Ctrl-x <Space>` - next outer window
- `Ctrl-x x` / `Ctrl-x Ctrl-x` - last outer window
- `Ctrl-x ' ` - choose outer window

## Style
- status bars: no explicit background color (`bg=default`)
- active window in status: blue background (`bg=blue,fg=white`)
- inactive window names truncated to 8 chars
- active window name shown in full
- pane borders: `pane-border-lines simple`

## Reload configs in running tmux
```bash
tmux source-file ~/.tmux2/outer.conf
tmux source-file ~/.tmux2/inner.conf
```

## Notes
- This setup is isolated from other tmux setups by using outer socket `tmux2-outer`.
- Inner sessions are per outer window (socket derived from outer socket + window id).
- `number.sh` uses `ggrep -x` (GNU grep) for Solaris compatibility.
