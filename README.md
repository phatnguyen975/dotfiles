<div align="center">
  <h1>dotfiles</h1>
  <sub>
    Nguyễn Tấn Phát <br />
    June 24, 2026
  </sub>
  <p>My personal dotfiles and development environment configurations</p>
</div>

## Table of Contents

1. [Neovim](#-neovim)
2. [WezTerm](#-wezterm)
3. [Starship](#-starship)
4. [Tmux](#-tmux)

## 📁 Repository Structure

```text
dotfiles/
├── .config/                      # Main configuration
│   ├── nvim/
│   ├── tmux/
│   └── starship.toml
│
├── wezterm/                      # WezTerm configuration
│   └── wezterm.lua
│
├── powershell/                   # PowerShell configuration
│   └── Microsoft.Powershell_profile.ps1
│
├── assets/                       # Screenshots, images, or other visual assets
│
├── docs/                         # Documentation and cheatsheets
│   ├── neovim-cheatsheet.md
│   ├── neovim-setup.md
│   ├── wezterm-setup.md
│   ├── starship-setup.md
│   ├── tmux-cheatsheet.md
│   └── tmux-setup.md
│
└── README.md
```

## ✨ Neovim

Neovim is my primary editor and its setup is designed to be:

- Minimal but powerful
- Keyboard-driven
- Optimized for daily development

### Configuration Location

```text
.config/nvim/
```

### Documentation

- [📘 Setup Guide](./docs/neovim-setup.md) — Step-by-step installation and configuration
- [⌨️ Cheatsheet](./docs/neovim-cheatsheet.md) — Quick reference for keybindings and common workflows

## ✨ WezTerm

WezTerm is the terminal emulator used on Windows, replacing Windows Terminal. It runs on the Windows host and launches directly into a WSL session, giving a seamless terminal experience without leaving the Linux environment for daily work.

The configuration aims to:

- Launch straight into WSL by default
- Support the Kitty graphics protocol (required for in-buffer image/diagram rendering)
- Stay visually consistent with the rest of the setup (Catppuccin, Nerd Font icons)

### Configuration Location

```text
wezterm/wezterm.lua
```

Since WezTerm itself runs on Windows (not inside WSL), this file lives outside `.config/` and is loaded via the `WEZTERM_CONFIG_FILE` environment variable rather than a symlink — symlinked folders are unreliable on Windows, so this approach avoids that issue entirely.

> WezTerm must be installed directly on Windows (e.g. via `scoop install wezterm`), not inside WSL — it's a GUI application and needs access to the Windows display/GPU.

### Documentation

- [📘 Setup Guide](./docs/wezterm-setup.md) — Step-by-step installation and configuration
- [⌨️ Cheatsheet](./docs/wezterm-cheatsheet.md) — Quick reference for keybindings and common workflows

## ✨ Starship

Starship is the shell prompt used across my terminal environments to provide a **fast**, **clean**, and **consistent** CLI experience.

The configuration aims to:

- Display useful context without visual clutter
- Work well with Git and development tools
- Stay readable and minimal

### Configuration Location

```text
.config/starship.toml
```

This file defines:

- Prompt layout
- Colors and symbols
- Enabled modules and their behavior

> Make sure Starship is installed and initialized in your shell to use this configuration.

### Documentation

- [📘 Setup Guide](./docs/starship-setup.md) — Step-by-step installation and configuration

## ✨ Tmux

Tmux is used to manage terminal sessions, windows, and panes efficiently, especially for long-running development tasks, running inside WSL underneath WezTerm.

The setup is designed to:

- Improve pane and window navigation, with seamless `Ctrl+h/j/k/l` movement between tmux panes and Neovim splits (via `vim-tmux-navigator`)
- Minimize mouse usage
- Provide a cleaner, more informative status line (Catppuccin theme, RAM usage, clock)

### Configuration Location

```text
.config/tmux/
```

### Documentation

- [📘 Setup Guide](./docs/tmux-setup.md) — Step-by-step installation and configuration
- [⌨️ Cheatsheet](./docs/tmux-cheatsheet.md) — Quick reference for keybindings and common workflows

## ⚠️ Disclaimer

These dotfiles are tailored to my personal workflow. Feel free to use them as inspiration, but review and adapt them to your own needs.
