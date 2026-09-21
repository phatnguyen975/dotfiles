# Omarchy Usage Guide

A complete reference for using Omarchy day to day — keybindings, built-in apps, AI tooling, theming, and system management, organized from first-login basics to power-user features. Compiled from Omarchy's official manual (omarchy.org / learn.omacom.io) and cross-checked community references, for **Omarchy 4.0.4 (the "Quattro" release line)**.

**The single most useful shortcut in this whole guide: `Super + K` shows the full, live, current hotkey list on your own machine** — this file is a study/reference companion, but `Super + K` is always the source of truth if something here is ever out of date.

## 1. Orientation

Omarchy is an opinionated Arch Linux + Hyprland desktop, built by DHH (of 37signals/Basecamp). "Hyprland" is the tiling Wayland compositor underneath — instead of windows overlapping freely like Windows/macOS, windows are automatically arranged (tiled) side by side, and most navigation happens via keyboard rather than a mouse.

- **`Super`** below means the Windows/Command key.
- The **top bar** (Waybar) sits at the top of the screen, showing workspaces, the clock, system tray, and notifications.
- The **Omarchy menu** (`Super + Alt + Space`) is the control center for the whole system — installing apps, changing themes, editing configs, updating, and more. You'll come back to this constantly, so it's worth memorizing early.

## 2. Keybindings — Window & Workspace Management

### Basics

| Hotkey                | Function                                        |
| --------------------- | ----------------------------------------------- |
| `Super + Space`       | Application launcher                            |
| `Super + Alt + Space` | Omarchy control menu                            |
| `Super + Escape`      | System menu (suspend, restart, shut down, etc.) |
| `Super + Ctrl + L`    | Lock computer                                   |
| `Super + W`           | Close window                                    |
| `Ctrl + Alt + Del`    | Close all windows                               |
| `Super + K`           | **Show all hotkeys**                            |

### Window layout & style

| Hotkey             | Function                                           |
| ------------------ | -------------------------------------------------- |
| `Super + T`        | Toggle window between tiling/floating              |
| `Super + J`        | Toggle window position (horizontal/vertical split) |
| `Super + O`        | Toggle popping window into sticky + floating       |
| `Super + L`        | Toggle between dwindle and scrolling layout        |
| `Super + P`        | Toggle pseudo window style (natural vs. stretch)   |
| `Super + F`        | Go full screen                                     |
| `Super + Alt + F`  | Go full width                                      |
| `Super + Ctrl + F` | Go full screen inside the window                   |

### Workspaces

| Hotkey                          | Function                                                |
| ------------------------------- | ------------------------------------------------------- |
| `Super + 1/2/3/4`               | Jump to specific workspace                              |
| `Super + Tab`                   | Jump to next workspace                                  |
| `Super + Shift + Tab`           | Jump to previous workspace                              |
| `Super + Ctrl + Tab`            | Jump to former workspace                                |
| `Super + Shift + 1/2/3/4`       | Move window to workspace                                |
| `Super + Shift + Alt + 1/2/3/4` | Move window to workspace without following it           |
| `Super + Shift + Alt + Arrow`   | Move a whole workspace to the monitor in that direction |

### Moving and resizing windows

| Hotkey                       | Function                                   |
| ---------------------------- | ------------------------------------------ |
| `Super + Arrow`              | Move focus to the window in that direction |
| `Super + Shift + Arrow`      | Swap window with the one in that direction |
| `Super + Equal`              | Grow window to the left                    |
| `Super + Minus`              | Grow window to the right                   |
| `Super + Shift + Equal`      | Grow window to the bottom                  |
| `Super + Shift + Minus`      | Grow window to the top                     |
| `Super + Left Mouse (drag)`  | Drag a window around                       |
| `Super + Right Mouse (drag)` | Resize a window                            |
| `Super + Scroll Wheel`       | Scroll through workspaces                  |

### Window grouping (tabs within a tile)

| Hotkey                  | Function                                      |
| ----------------------- | --------------------------------------------- |
| `Super + G`             | Toggle window grouping                        |
| `Super + Alt + G`       | Move window out of a group                    |
| `Super + Alt + Tab`     | Cycle between windows inside a group          |
| `Super + Alt + 1/2/3/4` | Jump to a specific window inside a group      |
| `Super + Alt + Arrow`   | Move a window into a group, in that direction |
| `Super + Ctrl + Arrow`  | Move between windows inside a tiling group    |

### Scratchpad, zoom, and scaling

| Hotkey                     | Function                                                             |
| -------------------------- | -------------------------------------------------------------------- |
| `Super + S`                | Show scratchpad workspace overlay (a hidden, quick-access workspace) |
| `Super + Alt + S`          | Move the current window to the scratchpad                            |
| `Super + Ctrl + Z`         | Zoom in on screen (repeat to zoom further)                           |
| `Super + Ctrl + Alt + Z`   | Zoom fully back out                                                  |
| `Super + /`                | Cycle forward through monitor scaling options                        |
| `Super + Alt + /`          | Cycle backward through monitor scaling options                       |
| `Alt + Tab`                | Cycle forward through windows on the active workspace                |
| `Alt + Shift + Tab`        | Cycle backward through windows on the active workspace               |
| `Ctrl + Alt + Tab`         | Cycle focus forward through monitors                                 |
| `Ctrl + Alt + Shift + Tab` | Cycle focus backward through monitors                                |

## 3. Keybindings — System Controls & Adjustments

| Hotkey             | Function                                             |
| ------------------ | ---------------------------------------------------- |
| `Super + Ctrl + A` | Audio controls (wiremix)                             |
| `Super + Ctrl + B` | Bluetooth controls (bluetui)                         |
| `Super + Ctrl + W` | Wi-Fi controls (impala)                              |
| `Super + Ctrl + S` | Share menu (via LocalSend)                           |
| `Super + Ctrl + T` | Activity monitor (btop)                              |
| `Super + Ctrl + C` | Capture controls (screenshot/recording/color picker) |
| `Super + Ctrl + O` | Toggle menu                                          |
| `Super + Ctrl + H` | Hardware menu                                        |
| `Super + Ctrl + .` | Transcoding menu                                     |

**Brightness and volume:**

| Hotkey                        | Function                      |
| ----------------------------- | ----------------------------- |
| `Shift + Brightness Up key`   | Maximum screen brightness     |
| `Shift + Brightness Down key` | Minimum screen brightness     |
| `Alt + Brightness Up/Down`    | Precise 1% brightness changes |
| `Alt + Volume Up/Down`        | Precise 1% volume changes     |

## 4. Keybindings — Launching Apps

These are Omarchy's default app bindings. Every one of them can be changed in `~/.config/hypr/bindings.conf`.

| Hotkey                        | Launches                                                 |
| ----------------------------- | -------------------------------------------------------- |
| `Super + Return`              | Terminal (Ghostty)                                       |
| `Super + Alt + Return`        | Tmux terminal                                            |
| `Super + Shift + Return`      | Browser                                                  |
| `Super + Shift + Alt + B`     | Browser (private/incognito)                              |
| `Super + Shift + F`           | File manager                                             |
| `Super + Shift + Alt + F`     | File manager, opened in the terminal's current directory |
| `Super + Shift + M`           | Music (Spotify)                                          |
| `Super + Shift + Alt + M`     | Music (cmus)                                             |
| `Super + Shift + /`           | Password manager (1Password)                             |
| `Super + Shift + N`           | Neovim                                                   |
| `Super + Shift + C`           | Calendar (HEY)                                           |
| `Super + Shift + E`           | Email (HEY)                                              |
| **`Super + Shift + A`**       | **AI — ChatGPT**                                         |
| **`Super + Shift + Alt + A`** | **AI — Grok**                                            |
| `Super + Shift + G`           | Messenger (Signal)                                       |
| `Super + Shift + P`           | Google Photos                                            |
| `Super + Shift + Alt + G`     | Messenger (WhatsApp)                                     |
| `Super + Shift + Ctrl + G`    | Messenger (Google)                                       |
| `Super + Shift + D`           | Docker (LazyDocker)                                      |
| `Super + Shift + O`           | Obsidian                                                 |
| `Super + Shift + W`           | Writing (Typora)                                         |
| `Super + Shift + X`           | X                                                        |
| `Super + Shift + Alt + X`     | X Compose                                                |
| `Super + Shift + Y`           | YouTube                                                  |

### About web apps (this is how ChatGPT, HEY, WhatsApp, etc. work)

Omarchy doesn't install separate native clients for services like ChatGPT or WhatsApp — it wraps their websites in a clean, frameless "web app" window (no browser chrome), each with its own hotkey. Default web apps that ship out of the box: **HEY** (email + calendar), **Basecamp**, **ChatGPT**, **WhatsApp**, **X**.

- **Add your own web app:** Omarchy menu (`Super + Alt + Space`) → **Install > Web App** → enter the app name, URL, and (optionally) an icon URL. Good icon sources: [dashboardicons.com](https://dashboardicons.com/). It then appears in the app launcher (`Super + Space`) and can be given its own hotkey in `~/.config/hypr/bindings.conf`.
- **Remove a web app:** Omarchy menu → **Remove > Web App**.
- Log into each service in a regular browser tab first — the thin web-app wrapper doesn't play well with some in-page password-manager popups (1Password especially), so it's simpler to already be signed in.
- While inside any web app, `Shift + Alt + L` copies the current page's URL to the clipboard.

## 5. Keybindings — Clipboard, Screenshots & Recording, Notifications

### Universal clipboard

Unlike most Linux setups (`Ctrl+Shift+C/V` in terminals vs. plain `Ctrl+C/V` everywhere else), Omarchy uses **one consistent set of clipboard hotkeys everywhere** (except the file manager):

| Hotkey             | Function                                                         |
| ------------------ | ---------------------------------------------------------------- |
| `Super + C`        | Copy                                                             |
| `Super + X`        | Cut (not inside a terminal)                                      |
| `Super + V`        | Paste                                                            |
| `Super + Ctrl + V` | Open the clipboard manager (history of everything you've copied) |

### Capture: screenshots, recording, color picker, OCR, dictation

| Hotkey                        | Function                                                                                                                                                        |
| ----------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `Super + Ctrl + C`            | Capture menu (useful on keyboards with no Print Screen key)                                                                                                     |
| `Print Screen`                | Take a screenshot                                                                                                                                               |
| `Alt + Print Screen`          | Start/stop a screen recording (hit once to start, again to stop)                                                                                                |
| `Super + Print Screen`        | Color picker                                                                                                                                                    |
| `Super + Ctrl + Print Screen` | **Text extraction** — select a screen region, OCR (via Tesseract) converts it to text on the clipboard. Great for pulling text out of a screenshot or an image. |
| `Alt + Shift + L`             | Copy the current URL from a webapp or Chromium-based browser                                                                                                    |
| `Super + Ctrl + X`            | Start/stop **AI dictation** (hold or toggle — see the AI section below; requires installing it first)                                                           |
| `F9`                          | Push-to-talk dictation                                                                                                                                          |

All capture options are also reachable from the Omarchy menu under **Capture**.

### Notifications

| Hotkey              | Function                             |
| ------------------- | ------------------------------------ |
| `Super + ,`         | Dismiss the latest notification      |
| `Super + Shift + ,` | Dismiss all notifications            |
| `Super + Ctrl + ,`  | Toggle silencing notifications       |
| `Super + Alt + ,`   | Re-show the most recent notification |

## 6. Keybindings — Theming, Toggles, Reminders

### Style / theming

| Hotkey                         | Function                                 |
| ------------------------------ | ---------------------------------------- |
| `Super + Ctrl + Shift + Space` | Pick a new theme                         |
| `Super + Ctrl + Space`         | Cycle the theme's background image       |
| `Super + Backspace`            | Toggle transparency on a window          |
| `Super + Ctrl + Backspace`     | Toggle single-window square aspect ratio |

All style options are also reachable from the Omarchy menu under **Style**. See Section 8 (Theming) below for the full picture.

### System toggles

| Hotkey                        | Function                                             |
| ----------------------------- | ---------------------------------------------------- |
| `Super + Ctrl + I`            | Toggle idle/sleep prevention (keep the screen awake) |
| `Super + Ctrl + N`            | Toggle nightlight (warmer display temperature)       |
| `Super + Ctrl + Delete`       | Toggle the laptop's built-in display on/off          |
| `Super + Ctrl + Alt + Delete` | Toggle laptop-display mirroring                      |
| `Super + Shift + Space`       | Toggle the top bar                                   |
| `Super + Mute`                | Switch to the next audio output device               |
| `Super + Shift + Backspace`   | Toggle window gaps                                   |

### Reminders & notices

| Hotkey                     | Function                                |
| -------------------------- | --------------------------------------- |
| `Super + Ctrl + R`         | Set a reminder                          |
| `Super + Ctrl + Alt + R`   | See all reminders                       |
| `Super + Ctrl + Shift + R` | Clear all reminders                     |
| `Super + Ctrl + Alt + T`   | Show the current time as a notification |
| `Super + Ctrl + Alt + B`   | Show battery level as a notification    |
| `Super + Ctrl + Alt + W`   | Show the weather as a notification      |

## 7. AI Features

This is the part most new users don't discover on their own — Omarchy ships with real, working AI tooling out of the box, not just a chat-website shortcut.

### 7.1 AI chat web apps (quickest to start with)

- **`Super + Shift + A`** — ChatGPT
- **`Super + Shift + Alt + A`** — Grok
- You can add any other AI chat site (Claude.ai, Gemini, etc.) as your own web app the same way as any other service: Omarchy menu → **Install > Web App** (see Section 4).

### 7.2 AI coding agents in the terminal (the deeper feature)

Omarchy ships with two AI coding-agent CLIs pre-installed and pre-aliased, meant to be run from inside whatever project directory you're working in:

| Alias | Tool            | What it is                                                                                                                                                                      |
| ----- | --------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `c`   | **OpenCode**    | Lets you use models from essentially every major commercial provider, plus fast-improving open-weight models. `cd` into your project directory, then run `c` to start it there. |
| `cx`  | **Claude Code** | Anthropic's own coding agent, used with your Anthropic subscription. Can be started in "danger mode" (fewer permission prompts) via the same `cx` alias.                        |

Beyond these two default aliases, Omarchy also ships **pre-wired, lazy-loaded launchers for essentially every other major coding-agent CLI** (Aider and others), so if you already have a preferred tool, it's likely already one command away without extra setup.

### 7.3 Local LLMs (run models fully offline)

Omarchy menu → **Install > AI** offers two ways to run models locally, entirely on your own hardware:

- **LM Studio** — a GUI for finding, installing, and running open-weight models. Recommended starting point if you're new to local models.
- **Ollama** — a CLI equivalent, for the same purpose.

### 7.4 The Omarchy Skill (AI that can configure your desktop for you)

Omarchy ships a built-in **agent skill** — a set of instructions that teaches AI coding agents how to safely make changes to the system itself (waybar tweaks, building a theme from scratch, etc.). It's automatically wired into OpenCode, Claude Code, and any other harness that supports the `~/.claude/skills` convention.

Practical advice from the official manual: treat this as **experimental** — different models use it with different results. Run the agent in **plan mode first** so you can see what it intends to change before it touches anything, and know that `omarchy-reinstall-configs` is your rollback if an agent-driven change makes a mess.

### 7.5 AI dictation (voice-to-text anywhere)

Install via Omarchy menu → **Install > AI > Dictation** (powered by [Voxtype](https://voxtype.io/)). Loads a ~150 MB base English model by default; change the model with `voxtype setup model` in the terminal, and tune further via `~/.config/voxtype/config.toml`.

**Usage:** hold `Super + Ctrl + X` (or toggle it) — or use `F9` for push-to-talk — and speak; the transcribed text appears wherever your cursor currently is focused.

### 7.6 AI dev layouts in Tmux

If you use Tmux (see Section 9), two custom functions build a ready-to-go development layout that includes an AI agent pane automatically:

```bash
tdl <ai> [<second_ai>]     # dev layout: editor + AI agent + terminal, in one tmux window
tdlm <ai> [<second_ai>]    # same, but one such layout per subdirectory
```

`<ai>` is whichever agent alias you want in that pane (e.g. `c` or `cx`).

## 8. Applications Overview

| Category             | What's included                                                                                    |
| -------------------- | -------------------------------------------------------------------------------------------------- |
| **Terminal**         | Ghostty (install/switch via Omarchy menu → **Install > Terminal**)                                 |
| **Editor**           | Neovim, pre-configured with LazyVim (see Section 10)                                               |
| **File manager**     | Default GUI file manager, plus a terminal-based option                                             |
| **Activity monitor** | btop (`Super + Ctrl + T`)                                                                          |
| **Docker UI**        | LazyDocker (`Super + Shift + D`)                                                                   |
| **Password manager** | 1Password (`Super + Shift + /`)                                                                    |
| **Music**            | Spotify or cmus                                                                                    |
| **Writing**          | Typora, Obsidian                                                                                   |
| **AI**               | OpenCode, Claude Code, alternative agent CLIs, LM Studio/Ollama, Voxtype dictation (see Section 7) |

Browse and install additional software (GUIs, TUIs, dev tools, gaming, PDF tools, and more) from the Omarchy menu under **Install** — this is the primary way Omarchy expects you to add software, rather than manually hunting for packages.

## 9. Terminal: Ghostty & Tmux

### Ghostty (the default terminal)

| Hotkey                               | Function                    |
| ------------------------------------ | --------------------------- |
| `Ctrl + Shift + E`                   | New split, below            |
| `Ctrl + Shift + O`                   | New split, beside           |
| `Ctrl + Alt + Arrow`                 | Move between splits         |
| `Super + Ctrl + Shift + Arrow`       | Resize split by 10 lines    |
| `Super + Ctrl + Shift + Alt + Arrow` | Resize split by 100 lines   |
| `Ctrl + Shift + T`                   | New tab                     |
| `Ctrl + Shift + Arrow`               | Move between tabs           |
| `Alt + Number`                       | Go to a specific tab        |
| `Shift + Page Up/Down`               | Scroll back through history |
| `Ctrl + Left-click`                  | Open a link in the browser  |

### Tmux

The prefix key is `Ctrl + Space` (`Ctrl + B` also works). Change any of these in `~/.config/tmux/tmux.conf`.

**Panes:**

| Hotkey                       | Function                               |
| ---------------------------- | -------------------------------------- |
| `Prefix + v`                 | Split pane vertically (side by side)   |
| `Prefix + h`                 | Split pane horizontally (top/bottom)   |
| `Prefix + x`                 | Kill the current pane                  |
| `Prefix + z`                 | Toggle pane zoom (fullscreen the pane) |
| `Ctrl + Alt + Arrow`         | Move between panes                     |
| `Ctrl + Alt + Shift + Arrow` | Resize panes                           |

**Windows:**

| Hotkey             | Function                  |
| ------------------ | ------------------------- |
| `Prefix + c`       | New window                |
| `Prefix + k`       | Kill window               |
| `Prefix + r`       | Rename window             |
| `Alt + 1-9`        | Jump to a specific window |
| `Alt + Left/Right` | Move between windows      |

**Sessions:**

| Hotkey               | Function              |
| -------------------- | --------------------- |
| `Prefix + C` (shift) | New session           |
| `Prefix + K` (shift) | Kill session          |
| `Prefix + R` (shift) | Rename session        |
| `Prefix + N` (shift) | Next session          |
| `Prefix + P` (shift) | Previous session      |
| `Alt + Up/Down`      | Move between sessions |
| `Prefix + s`         | List sessions         |
| `Prefix + d`         | Detach from session   |

**Copy mode (vi-style) & general:**

| Hotkey             | Function           |
| ------------------ | ------------------ |
| `Prefix + [`       | Enter copy mode    |
| `v` (in copy mode) | Begin selection    |
| `y` (in copy mode) | Copy selection     |
| `Prefix + q`       | Reload tmux config |
| `Prefix + :`       | Command prompt     |

And see Section 7.6 above for `tdl` / `tdlm` — the AI-integrated dev layout commands.

## 10. Neovim (with LazyVim)

### Navigation

| Hotkey              | Function                        |
| ------------------- | ------------------------------- |
| `Space`             | Show command options            |
| `Space Space`       | Open a file via fuzzy search    |
| `Space E`           | Toggle the sidebar              |
| `Space G G`         | Show git controls               |
| `Space S G`         | Search file contents (grep)     |
| `Ctrl + W W`        | Jump between sidebar and editor |
| `Ctrl + Left/Right` | Resize the sidebar              |
| `Shift + H`         | Go to the file tab on the left  |
| `Shift + L`         | Go to the file tab on the right |
| `Space B D`         | Close the current file tab      |

### While in the sidebar

| Hotkey      | Function                               |
| ----------- | -------------------------------------- |
| `A`         | Add a new file in the parent directory |
| `Shift + A` | Add a new subdirectory                 |
| `D`         | Delete the highlighted file/directory  |
| `M`         | Move the highlighted file/directory    |
| `R`         | Rename the highlighted file/directory  |
| `?`         | Show help for all sidebar commands     |

For the complete keymap set, see [LazyVim's own documentation](https://www.lazyvim.org/keymaps) — Omarchy ships LazyVim largely as-is.

## 11. File Manager

| Hotkey      | Function                                                         |
| ----------- | ---------------------------------------------------------------- |
| `Ctrl + L`  | Go directly to a path                                            |
| `Space`     | Preview the selected file (arrow keys navigate through previews) |
| `Backspace` | Go back one folder                                               |

## 12. Emoji & Text Shortcuts

`Super + Ctrl + E` opens a full emoji picker (puts your selection on the clipboard). There are also instant shortcuts via `CapsLock` as a compose key — hold `CapsLock`, then `M`, then a letter:

| Shortcut       | Emoji      |     | Shortcut       | Emoji        |
| -------------- | ---------- | --- | -------------- | ------------ |
| `CapsLock M S` | 😄 smile   |     | `CapsLock M K` | 😘 kiss      |
| `CapsLock M C` | 😂 cry     |     | `CapsLock M P` | 🙏 pray      |
| `CapsLock M L` | 😍 love    |     | `CapsLock M M` | 💰 money     |
| `CapsLock M V` | ✌️ victory |     | `CapsLock M X` | 🎉 celebrate |
| `CapsLock M H` | ❤️ heart   |     | `CapsLock M T` | 🥂 toast     |
| `CapsLock M Y` | 👍 yes     |     | `CapsLock M O` | 👌 ok        |
| `CapsLock M N` | 👎 no      |     | `CapsLock M G` | 👋 greeting  |
| `CapsLock M R` | 🤘 rock    |     | `CapsLock M A` | 💪 arm       |

Add your own via `~/.XCompose`, then run `omarchy-restart-xcompose` in the terminal to pick up the changes.

**Quick text completions** (same CapsLock-compose mechanism):

| Shortcut               | Inserts                              |
| ---------------------- | ------------------------------------ |
| `CapsLock Space Space` | — (em dash)                          |
| `CapsLock Space N`     | Your name (as entered during setup)  |
| `CapsLock Space E`     | Your email (as entered during setup) |

## 13. Theming

Omarchy ships with **nine built-in themes**, each covering the whole system consistently — terminal colors, Neovim, Waybar, btop, GTK apps, and the wallpaper — not just one app at a time.

- **Switch theme:** `Super + Ctrl + Shift + Space`, or Omarchy menu → **Style**.
- **Cycle the current theme's background image:** `Super + Ctrl + Space`.
- **Add your own background images:** drop them into `~/.config/omarchy/current/backgrounds/`, or use Omarchy menu → **Install > Background**.
- **Build your own theme from scratch:** create a folder under `~/.config/omarchy/themes/<your-theme-name>/` with a `colors.toml` defining the theme's color palette (16 ANSI colors plus a handful of UI-specific ones) and a `backgrounds/` folder with at least one wallpaper, then apply it with `omarchy-theme-set <your-theme-name>`. This is also a good candidate task to hand to an AI coding agent, since Omarchy's built-in skill (Section 7.4) specifically covers theme creation.

## 14. System Management

### The Omarchy menu (`Super + Alt + Space`)

This is the hub for almost everything system-level:

- **Setup** — configure security (fingerprint, FIDO2), edit config files (opens the relevant file straight in Neovim), install backgrounds.
- **Install** — add software: terminals, web apps, AI tooling, backgrounds, gaming support, and more.
- **Remove** — uninstall anything added via Install.
- **Update** — check for and install Omarchy updates.
- **Style** — theme and background controls.
- **Capture** — screenshot/recording controls.

### Package management (pacman & AUR)

Omarchy is Arch-based, so standard Arch tooling applies underneath everything above:

```bash
# Update the whole system
sudo pacman -Syu

# Install / remove a package
sudo pacman -S <package>
sudo pacman -Rs <package>       # -s also removes now-unused dependencies

# Search for a package
pacman -Ss <keyword>

# List installed / orphaned packages
pacman -Q
pacman -Qdt

# Remove orphaned packages
sudo pacman -Rns $(pacman -Qdtq)
```

For packages outside the official Arch repos (the AUR — Arch User Repository), Omarchy includes **yay** as a pacman wrapper:

```bash
yay -Syu              # update repos + AUR packages together
yay -Ss <keyword>     # search both
yay -S <package>      # install from either
```

### The Omarchy CLI

Omarchy provides roughly 145 of its own `omarchy-*` commands for managing the system beyond raw pacman — theme switching, config resets, restarting individual components, and more. A few of the most useful:

```bash
omarchy-update                  # check for and apply Omarchy updates (same as menu > Update)
omarchy-theme-list              # list available themes
omarchy-theme-set <name>        # apply a theme
omarchy-theme-next              # cycle to the next theme
omarchy-restart-<app>           # restart a specific component after editing its config
omarchy-refresh-<app>           # reset a component's config to Omarchy's defaults (auto-backs up first)
omarchy-reinstall-configs       # broad rollback if something (including an AI agent) breaks your configs
```

To discover the full list on your own system:

```bash
compgen -c | grep -E '^omarchy-' | sort -u
```

**A rule worth remembering:** Never edit files under `~/.local/share/omarchy/` directly — that's Omarchy's own system directory and gets overwritten on updates. Your customizations belong in `~/.config/` instead, which Omarchy is designed to read as overrides.

### Plugins

Omarchy has a plugin system for community-built extensions (extra Waybar widgets, taskbars, visual keybinding guides, and more):

```bash
omarchy plugin add <git-url> --enable
omarchy plugin list
omarchy plugin disable <plugin-id>
omarchy plugin remove <plugin-id>
```

### Updates & rollback safety net

Omarchy's default disk layout (Btrfs + Snapper + the Limine bootloader) takes automatic snapshots before significant changes. If an update or a config change ever breaks your system, you can boot straight into a prior snapshot from the Limine boot menu — no recovery USB needed. This is separate from, but complementary to, `omarchy-reinstall-configs` mentioned above (which resets configs without a full snapshot rollback).

## 15. Networking

```bash
# Enable Wi-Fi radio
nmcli radio wifi on

# List networks / connect
nmcli device wifi list
nmcli device wifi connect "SSID_NAME" password "PASSWORD"

# Check status
nmcli general status
nmcli connection show --active
```

During installation (before NetworkManager is running), `iwctl` is used instead:

```bash
iwctl
station wlan0 scan
station wlan0 get-networks
station wlan0 connect NETWORK_NAME
```

A quicker GUI path day-to-day: `Super + Ctrl + W` opens Wi-Fi controls directly (Section 3).

## 16. Power-User Tips

- **Custom keybindings:** edit `~/.config/hypr/bindings.conf` — this is where every default binding above can be changed, and where new ones (including for web apps you add) get defined.
- **Multiple keyboard layouts:** edit `~/.config/hypr/hyprland.conf`:
  ```
  input {
    kb_layout = us,fr
    kb_options = compose:caps,grp:alts_toggle
  }
  ```
  Then switch layouts with `Left Alt + Right Alt`.
- **Restart a broken component instead of rebooting:** `omarchy-restart-<app>` — much faster than a full reboot when you've just tweaked a config and want to see the change.
- **Editing configs the guided way:** Omarchy menu → **Setup > Configs > [component]** opens the relevant file directly in Neovim; save and quit (`:wq`) and the component restarts automatically.
- **If an AI agent (or you) makes a mess of a config:** `omarchy-reinstall-configs` is the documented recovery path — safer than trying to hand-undo a tangle of edits.

## References

- Omarchy Manual — Hotkeys (official, current keybinding reference): https://learn.omacom.io/2/the-omarchy-manual/53/hotkeys
- Omarchy Manual — AI: https://learn.omacom.io/2/the-omarchy-manual/107/ai
- Omarchy Manual — Web Apps: https://learn.omacom.io/2/the-omarchy-manual/63/web-apps
- Omarchy Manual — Text Extraction & Dictation: https://learn.omacom.io/2/the-omarchy-manual/116/text-extraction-dictation
- Omarchy Manual — Getting Started: https://omarchy.org/manual/getting-started/
- Omarchy Manual — Dual Boot Install: https://omarchy.org/manual/dual-boot-install/
- Omarchy Manual — System Snapshots: https://omarchy.org/manual/system-snapshots/
- Omarchy Manual — full table of contents (mirrored source): https://github.com/basecamp/omarchy (see `manual/` directory)
- LazyVim — Keymaps reference: https://www.lazyvim.org/keymaps
- Arch Wiki — pacman: https://wiki.archlinux.org/title/Pacman
- Arch Wiki — AUR helpers (yay): https://wiki.archlinux.org/title/AUR_helpers

**A note on accuracy:** Omarchy updates frequently, and keybindings occasionally change between versions (a few did between the 3.x and 4.x/Quattro lines — this guide reflects the current 4.x defaults per the official manual, not older community cheat sheets). `Super + K` on your own machine is always the definitive, live answer if anything here ever drifts out of date.
