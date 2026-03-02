<div align="center">
  <h1>Tmux Cheatsheet</h1>
  <sub>
    Nguyễn Tấn Phát <br />
    February 25, 2026
  </sub>
</div>

## Table of Contents

1. [Session Management](#session-management)
2. [Window Management](#window-management)
3. [Pane Management](#pane-management)
4. [Pane Resizing](#pane-resizing)
5. [Copy Mode & Navigation](#copy-mode--navigation)
6. [Miscellaneous & System](#miscellaneous--system)

## Session Management

```bash
tmux                                # Start a new tmux session
tmux new -s [name]                  # Start a new session with a specific name
tmux ls                             # List all active tmux sessions
tmux attach                         # Attach to the last used session
tmux attach -t [N]                  # Attach to a specific session by name/ID
tmux switch -t [N]                  # Switch to a different session while inside tmux
tmux rename-session -t [old] [new]  # Rename an existing session
tmux kill-session -t [name]         # Kill a specific session
tmux kill-server                    # Kill all sessions and the tmux server entirely
Prefix + d                          # Detach from the current session (leave it running)
Prefix + s                          # Interactively select a session from a list
Prefix + $                          # Rename the current session
```

## Window Management

```bash
Prefix + c          # Create a new window (tab)
Prefix + ,          # Rename the current window
Prefix + w          # Interactively select a window from a list
Prefix + n          # Move to the next window
Prefix + p          # Move to the previous window
Prefix + [0-9]      # Switch to window by index number
Prefix + &          # Kill the current window
Prefix + f          # Find a window by name
Prefix + .          # Move/reorder current window to a different index
```

## Pane Management

```bash
Prefix + \          # Split pane horizontally
Prefix + -          # Split pane vertically
Ctrl + h/j/k/l      # Navigate between panes
Ctrl + \            # Move to the previous pane
Prefix + x          # Kill the current pane
Prefix + q          # Show pane numbers (type the number to jump to it)
Prefix + z          # Toggle zoom (maximize) the current pane
Prefix + o          # Cycle through all open panes
Prefix + {          # Swap current pane with the previous one
Prefix + }          # Swap current pane with the next one
Prefix + !          # Break current pane out into a new window
Prefix + Space      # Cycle through preset pane layouts
```

## Pane Resizing

```bash
Prefix + h          # Resize pane LEFT by 5 units (Hold 'h' to repeat)
Prefix + j          # Resize pane DOWN by 5 units (Hold 'j' to repeat)
Prefix + k          # Resize pane UP by 5 units (Hold 'k' to repeat)
Prefix + l          # Resize pane RIGHT by 5 units (Hold 'l' to repeat)
Prefix + m          # Toggle Zoom (Maximize/Minimize current pane)
:resize-pane -D [N] # Resize pane Down by N lines
:resize-pane -U [N] # Resize pane Up by N lines
:resize-pane -L [N] # Resize pane Left by N columns
:resize-pane -R [N] # Resize pane Right by N columns
```

## Copy Mode & Navigation

```bash
Prefix + [          # Enter Copy Mode (allows scrolling and selection)
q                   # Exit Copy Mode
/                   # Search forward in buffer
?                   # Search backward in buffer
n                   # Repeat last search (forward)
N                   # Repeat last search (backward)
v                   # Begin selection
y                   # Copy selection to buffer
Prefix + ]          # Paste the most recent buffer
Prefix + #          # List all paste buffers
:capture-pane       # Capture the current pane's content to a buffer
```

## Miscellaneous & System

```bash
Prefix + r          # Reload tmux.conf
Prefix + I          # Install TPM plugins
Prefix + Alt + u    # Uninstall plugins not in config
Prefix + Ctrl + s   # Save current session (via tmux-resurrect)
Prefix + Ctrl + r   # Restore saved session (via tmux-resurrect)
Prefix + :          # Enter command mode
Prefix + t          # Show a large digital clock in the center
Prefix + ?          # Show all key bindings (Help menu)
```

---

**See also:** [📘 Tmux Setup Guide](./tmux-setup.md) &nbsp;|&nbsp; [← Back to README](../README.md)
```
