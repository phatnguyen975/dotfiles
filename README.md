<div align="center">
  <h1>dotfiles</h1>
  <sub>
    Nguyễn Tấn Phát <br />
    January 25, 2026
  </sub>
  <p>My personal dotfiles and development environment configurations</p>
</div>

## Table of Contents

- [Neovim](#-neovim)
- [Starship](#-starship)
- [Tmux](#-tmux)

## 📁 Repository Structure

```text
dotfiles/
├── .config/                  # Main configuration directory
│   ├── nvim/
│   ├── powershell/
│   ├── starship/
│   └── tmux/
│
├── assets/                   # Screenshots, images, or other visual assets
│
├── docs/                     # Documentation and notes
│   ├── neovim-cheatsheet.md
│   ├── neovim-setup.md
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

## ✨ Starship

Starship is the shell prompt used across my terminal environments to provide a **fast**, **clean**, and **consistent** CLI experience.

The configuration aims to:

- Display useful context without visual clutter
- Work well with Git and development tools
- Stay readable and minimal

### Configuration Location

```text
.config/starship/
```

This directory contains the `starship.toml` file, which defines:

- Prompt layout
- Colors and symbols
- Enabled modules and their behavior

> Make sure Starship is installed and initialized in your shell to use this configuration.

### Documentation

- [📘 Setup Guide](./docs/starship-setup.md) — Step-by-step installation and configuration

## ✨ Tmux

Tmux is used to manage terminal sessions, windows, and panes efficiently, especially for long-running development tasks.

The setup is designed to:

- Improve pane and window navigation
- Minimize mouse usage
- Integrate smoothly with Neovim

### Configuration Location

```text
.config/tmux/
```

This configuration typically includes:

- Custom keybindings
- Sensible defaults for splits and resizing
- A cleaner, more informative status line

> The goal is to support a terminal-centric workflow where Tmux and Neovim work together naturally.

### Documentation

- [📘 Setup Guide](./docs/tmux-setup.md) — Step-by-step installation and configuration
- [⌨️ Cheatsheet](./docs/tmux-cheatsheet.md) — Quick reference for keybindings and common workflows

## ⚠️ Disclaimer

These dotfiles are tailored to my personal workflow. Feel free to use them as inspiration, but review and adapt them to your own needs.
