<div align="center">
  <h1>WezTerm Cheatsheet</h1>
  <sub>
    Nguyễn Tấn Phát <br />
    June 24, 2026
  </sub>
</div>

## Table of Contents

1. [General](#general)
2. [Font Size](#font-size)
3. [Clipboard](#clipboard)
4. [Window](#window)
5. [Tabs](#tabs)
6. [Panes](#panes)
7. [Scrolling](#scrolling)

## General

> [!NOTE]
> Leader key: `Ctrl + Space` (held for up to 1 second — press Leader, release, then the next key). Bindings below are grouped by where they come from: custom (defined in [`wezterm.lua`](../wezterm/wezterm.lua)) vs. WezTerm's built-in defaults (still active, since `disable_default_key_bindings` is not set).

| Keybinding             | Action                                                    |
| ---------------------- | --------------------------------------------------------- |
| `Leader` + `r`         | Reload configuration                                      |
| `Leader` + `o`         | Show launcher menu (palette of tabs/panes/launch items)   |
| `Leader` + `c`         | Fuzzy color scheme picker                                 |
| `F11`                  | Toggle fullscreen                                         |
| `F12`                  | Hide window                                               |
| `Ctrl+Shift` + `P`     | Activate command palette _(default)_                      |
| `Ctrl+Shift` + `L`     | Show debug overlay (Lua REPL) _(default)_                 |
| `Ctrl+Shift` + `X`     | Activate copy mode _(default)_                            |
| `Ctrl+Shift` + `Space` | Quick select mode (jump to visible text/URLs) _(default)_ |
| `Ctrl+Shift` + `U`     | Character select _(default)_                              |
| `Ctrl+Shift` + `F`     | Search scrollback _(default)_                             |
| `Ctrl+Shift` + `K`     | Clear scrollback _(default)_                              |

## Font Size

| Keybinding   | Action             |
| ------------ | ------------------ |
| `Ctrl` + `=` | Increase font size |
| `Ctrl` + `-` | Decrease font size |
| `Ctrl` + `0` | Reset font size    |

## Clipboard

| Keybinding         | Action                                   |
| ------------------ | ---------------------------------------- |
| `Ctrl+Shift` + `C` | Copy to clipboard                        |
| `Ctrl+Shift` + `V` | Paste from clipboard                     |
| `Shift` + `Insert` | Paste from primary selection _(default)_ |

## Window

| Keybinding     | Action           |
| -------------- | ---------------- |
| `Leader` + `n` | Spawn new window |

## Tabs

| Keybinding                           | Action                              |
| ------------------------------------ | ----------------------------------- |
| `Leader` + `t`                       | New tab (current pane's domain)     |
| `Leader` + `q`                       | Close current tab (no confirmation) |
| `Leader` + `[`                       | Previous tab                        |
| `Leader` + `]`                       | Next tab                            |
| `Leader` + `e`                       | Rename current tab                  |
| `Leader` + `1`–`9`                   | Jump to tab 1–9                     |
| `Ctrl+Shift` + `Tab`                 | Next tab _(default)_                |
| `Ctrl+Shift+Shift` + `Tab`           | Previous tab _(default)_            |
| `Ctrl` + `PageUp` / `PageDown`       | Previous / next tab _(default)_     |
| `Ctrl+Shift` + `PageUp` / `PageDown` | Move tab left / right _(default)_   |

## Panes

| Keybinding                       | Action                                                              |
| -------------------------------- | ------------------------------------------------------------------- |
| `Leader` + `-`                   | Split pane down (vertical split)                                    |
| `Leader` + `\`                   | Split pane right (horizontal split)                                 |
| `Leader` + `h` / `j` / `k` / `l` | Move to pane left / down / up / right                               |
| `Leader` + `z`                   | Toggle pane zoom                                                    |
| `Leader` + `x`                   | Close current pane (no confirmation)                                |
| `Ctrl+Shift` + `←` `→` `↑` `↓`   | Move to pane in direction _(default — works alongside Leader+hjkl)_ |
| `Ctrl+Shift` + `Z`               | Toggle pane zoom _(default — same as Leader+z)_                     |

### Resize Mode

| Keybinding                                  | Action                                                                           |
| ------------------------------------------- | -------------------------------------------------------------------------------- |
| `Leader` + `w`                              | Enter resize mode (stays active for 3s of inactivity, or until `Escape`/`Enter`) |
| `↑` `↓` `←` `→` _(while in resize mode)_    | Grow/shrink the active pane by 3 cells per press                                 |
| `Escape` / `Enter` _(while in resize mode)_ | Exit resize mode                                                                 |

## Scrolling

| Keybinding                      | Action                                 |
| ------------------------------- | -------------------------------------- |
| `Shift` + `PageUp` / `PageDown` | Scroll up / down by a page _(default)_ |

---

**See also:** [📘 Setup Guide](./wezterm-setup.md) &nbsp;|&nbsp; [← Back to README](../README.md)
