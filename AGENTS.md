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
- `number.sh` - move-or-swap helper for current tmux server
- `outer-number.sh` - move-or-swap helper targeting outer tmux from inner
- `outer-rename.sh` - rename outer window from inner

## Startup
Run:
```bash
~/.tmux2/start-outer.sh
```

## Active keybindings

### Inner tmux (`Ctrl-a` prefix)
- `Ctrl-a c` / `Ctrl-a Ctrl-c` - new inner window (`.`)
- `Ctrl-a n` / `Ctrl-a <Space>` - next inner window
- `Ctrl-a p` - previous inner window
- `Ctrl-a Ctrl-a` / `Ctrl-a a` - last inner window
- `Ctrl-a ' ` - choose inner window
- `Ctrl-a A` - rename current inner window
- `Ctrl-a N` - prompt index and move/swap inner window (`number.sh`)
- `Ctrl-a |` - split side by side
- `Ctrl-a -` - split top/bottom
- `Ctrl-a h/j/l` - select pane left/down/right
- `Ctrl-a k` - select pane up
- `Ctrl-a K` - kill current inner window (with confirmation)

### Outer tmux controls (from inner via `Ctrl-x` key table)
- `Ctrl-x c` / `Ctrl-x Ctrl-c` - new outer window (`.`, auto-starts inner)
- `Ctrl-x n` / `Ctrl-x <Space>` - next outer window
- `Ctrl-x p` - previous outer window
- `Ctrl-x Ctrl-x` / `Ctrl-x x` - last outer window
- `Ctrl-x ' ` - choose outer window
- `Ctrl-x a` / `Ctrl-x A` - rename outer window (`outer-rename.sh`)
- `Ctrl-x N` - prompt index and move/swap outer window (`outer-number.sh`)
- `Ctrl-x k` / `Ctrl-x K` - kill current outer window (with confirmation)

### Outer tmux direct prefix (`Ctrl-x`)
- `Ctrl-x c` / `Ctrl-x Ctrl-c` - new outer window (`.`)
- `Ctrl-x n` / `Ctrl-x <Space>` - next outer window
- `Ctrl-x x` / `Ctrl-x Ctrl-x` - last outer window
- `Ctrl-x ' ` - choose outer window
- `Ctrl-x a` / `Ctrl-x A` - rename current outer window
- `Ctrl-x N` - prompt index and move/swap outer window (`number.sh`)
- `Ctrl-x k` / `Ctrl-x K` - kill current outer window (with confirmation)

## Copy mode (inner only customizations)
- `[` exits copy mode
- `Enter` toggles mark/copy flow:
  - first `Enter` starts selection
  - second `Enter` copies to tmux paste buffer and exits copy mode
- paste copied text with `Ctrl-a ]`

## Prompts
- kill confirmation text: `Really kill this window [y/n]`

## Style
- status bars: no explicit background color (`bg=default`)
- active window in status: blue background (`bg=blue,fg=white`)
- inactive window names truncated to 8 chars
- active window name shown in full
- pane borders: `pane-border-lines simple`

## Behavior
- new windows are created with name `.` (`new-window -n .`)
- automatic rename is disabled (`setw -g automatic-rename off`)

## Reload configs in running tmux
```bash
tmux source-file ~/.tmux2/outer.conf
tmux source-file ~/.tmux2/inner.conf
```

## Notes
- setup is isolated via outer socket `tmux2-outer`
- inner sessions are per outer window (socket derived from outer socket + window id)
- `number.sh` and `outer-number.sh` use `ggrep -x` for Solaris compatibility
