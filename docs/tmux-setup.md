<div align="center">
  <h1>Tmux Setup</h1>
  <sub>
    Nguyễn Tấn Phát <br />
    February 25, 2026
  </sub>
</div>

## 1. Install tmux

Ensure your WSL system is up to date and has the necessary tools for the plugins to function.

```bash
sudo apt update
sudo apt install tmux -y
```

## 2. Set Up Configuration Directories

```bash
# Create the tmux config folder
mkdir -p ~/.config/tmux

# Install TPM (Tmux Plugin Manager)
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
```

## 3. Create the `tmux.conf` File

Create and edit the file `nvim ~/.config/tmux/tmux.conf`. Paste the optimized configuration below:

```bash
# ==========================================
# TERMINAL COLORS & SETTINGS
# ==========================================

# TrueColor support
set -g default-terminal "screen-256color"
set -as terminal-features ",xterm-256color:RGB"

# Enable mouse support (scrolling, resizing, selecting)
set -g mouse on

# Start window and pane numbering at 1
set -g base-index 1
set -g pane-base-index 1
set-window-option -g pane-base-index 1
set-option -g renumber-windows on

# ==========================================
# KEY BINDINGS
# ==========================================

# Change Prefix from Ctrl-b to Ctrl-a
unbind C-b
set -g prefix C-a
bind-key C-a send-prefix

# Reload config file quickly
unbind r
bind r source-file ~/.config/tmux/tmux.conf \; display-message "Reloaded!"

# Split panes using '\' and '-' (remembers current folder)
unbind %
bind '\' split-window -h -c '#{pane_current_path}'
unbind '"'
bind - split-window -v -c '#{pane_current_path}'

# New window (remembers current folder)
bind c new-window -c '#{pane_current_path}'

# Resize panes using Vim keys (h, j, k, l)
bind -r j resize-pane -D 5
bind -r k resize-pane -U 5
bind -r h resize-pane -L 5
bind -r l resize-pane -R 5
bind -r m resize-pane -Z # Maximize current pane

# Vim-style copy mode
set-window-option -g mode-keys vi
bind-key -T copy-mode-vi 'v' send -X begin-selection
bind-key -T copy-mode-vi 'y' send -X copy-selection
unbind -T copy-mode-vi MouseDragEnd1Pane # Don't exit copy mode on mouse release

# ==========================================
# PLUGINS (TPM)
# ==========================================

# Set plugin folder to ~/.config/tmux/plugins/
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'christoomey/vim-tmux-navigator' # Move between nvim and tmux panes
set -g @plugin 'tmux-plugins/tmux-resurrect'    # Save sessions even after reboot
set -g @plugin 'catppuccin/tmux'                # Beautiful theme

# ==========================================
# THEME & STATUS BAR (CATPPUCCIN)
# ==========================================

# Configure the catppuccin plugin
set -g @catppuccin_flavor "mocha"
set -g @catppuccin_window_status_style "basic"

# Window appearance
set -g window-status-separator ""
set -g @catppuccin_window_current_text_color "#{@thm_surface_1}"
set -g @catppuccin_window_current_number_color "#{@thm_peach}"
set -g @catppuccin_window_current_text "#[bg=#{@thm_mantle}] #{b:pane_current_path}"

set -g @catppuccin_window_text " #W"
set -g @catppuccin_window_default_text "#W"
set -g @catppuccin_window_number_color "#{@thm_lavender}"

# Status Left: Session Name
set -g status-left "#[bg=#{@thm_green},fg=#{@thm_crust}]#[reverse]█#[noreverse]#S "

# Status Right: RAM and Clock
set -g status-interval 15
set -g status-right-length 150
set -g status-right ""
set -agF status-right "#[bg=#{@thm_green},fg=#{@thm_crust}]#[reverse]█#[noreverse]󰍛 "
set -agF status-right "#[fg=#{@thm_fg},bg=#{@thm_mantle}] #(free | grep Mem | awk '{print int($3/$2 * 100)}')%% "
set -agF status-right "#[bg=#{@thm_green},fg=#{@thm_crust}]#[reverse]█#[noreverse]󰢗 "
set -agF status-right "#[fg=#{@thm_fg},bg=#{@thm_mantle}] %d/%m/%Y %H:%M "

# Make status bar background transparent
set -g status-bg default
set -g status-style bg=default

# ==========================================
# FINISH
# ==========================================

# Run Tmux Plugin Manager
run '~/.config/tmux/plugins/tpm/tpm'
```

## 4. Configure Neovim for Integration

To move between tmux and Neovim using `Ctrl + h/j/k/l`, add the `vim-tmux-navigator` plugin to your Neovim config (e.g., using `Lazy.nvim`):

```lua
return {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
  },
  keys = {
    { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
    { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
    { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
    { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
    { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
  },
}
```

## 5. Final Activation

1. **Open tmux:** Type `tmux` in your terminal.
2. **Install plugins:** Press `Prefix` (`Ctrl+a`) then `Shift+i`. Wait for the "Success" message.
3. **Reload:** Press `Prefix` (`Ctrl+a`) then `r`.
4. **Font check:** Ensure Windows Terminal is using a Nerd Font (like `FiraCode NF`) to see icons.
