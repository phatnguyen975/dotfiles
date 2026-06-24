<div align="center">
  <h1>WezTerm Setup</h1>
  <sub>
    Nguyễn Tấn Phát <br />
    June 24, 2026
  </sub>
</div>

## 1. Install WezTerm on Windows

WezTerm is a GUI application and must be installed directly on **Windows**, not inside WSL — it needs access to the Windows display/GPU to render. WSL only provides the shell that runs inside it.

```powershell
scoop bucket add extras
scoop install wezterm
```

> If `scoop install wezterm` ever fails to find the manifest, run `scoop update` first to refresh the bucket index, then retry.

## 2. Link the Configuration File

The full configuration lives at [`dotfiles/wezterm/wezterm.lua`](../wezterm/wezterm.lua) in this repo. It is **not** placed under `.config/` like the other tools here, because:

- WezTerm runs on the Windows host, so its config must be readable from Windows.
- Symlinked _folders_ are unreliable on Windows (a known WezTerm issue — config inside a linked directory may silently fail to load).

Instead, point WezTerm at the file directly using the `WEZTERM_CONFIG_FILE` environment variable:

```powershell
[System.Environment]::SetEnvironmentVariable(
  "WEZTERM_CONFIG_FILE",
  "$HOME\dotfiles\wezterm\wezterm.lua",
  "User"
)
```

Restart WezTerm after setting this. To verify it picked up the right file, open the debug overlay (`Ctrl+Shift+L`) and run:

```lua
wezterm.config_file
```

It should print the path above.

## 3. Fix New Panes/Tabs Opening in the Wrong Directory

By default, splitting a pane or opening a new tab inside the WSL domain drops you back into your home directory instead of wherever you currently are. This happens because WezTerm determines a new pane's working directory from an **OSC 7** escape sequence that the shell must emit on every prompt — without it, WezTerm has nothing to read and falls back to the home directory.

Fix it by sourcing WezTerm's shell-integration script in `~/.bashrc` (inside WSL):

```bash
mkdir -p ~/.config/wezterm
curl -o ~/.config/wezterm/shell-integration.sh \
  https://raw.githubusercontent.com/wezterm/wezterm/main/assets/shell-integration/wezterm.sh

echo '[ -n "$WEZTERM_PANE" ] && source ~/.config/wezterm/shell-integration.sh' >> ~/.bashrc
source ~/.bashrc
```

The `[ -n "$WEZTERM_PANE" ]` guard makes sure this only runs when the shell is actually inside a WezTerm pane (`WEZTERM_PANE` is set automatically by WezTerm) — so it stays a no-op on any other terminal.

After this, splitting a pane (`LEADER + -` / `LEADER + \`) or opening a new tab (`LEADER + t`) will inherit the current pane's working directory correctly.

## 4. What's Already Configured

Key points baked into [`wezterm.lua`](../wezterm/wezterm.lua):

- `default_domain = "WSL:Ubuntu-24.04"` — opens straight into WSL on startup. **This name must exactly match the output of `wsl -l -v` in PowerShell** — if your distro is registered under a different name, update this value or WezTerm silently falls back to a Windows (`local`) domain instead of WSL.
- A Nerd Font (`FiraCode Nerd Font`) — required for the icons used throughout the Neovim config. Install it via Scoop too:
  ```powershell
  scoop bucket add nerd-fonts
  scoop install nerd-fonts/FiraCode-NF
  ```
- A `LEADER` key (`Ctrl+Space`) with `h/j/k/l` pane navigation, splits, tab switching, and a fuzzy color-scheme picker.
- Catppuccin Frappé color scheme with a background image layer.

## 5. Terminal Capabilities Inside WSL

After installing WezTerm, confirm the terminal type is recognized correctly from inside WSL:

```bash
echo $TERM
```

This should print `wezterm` (outside tmux) or `tmux-256color` (inside tmux — see [Tmux Setup](./tmux-setup.md)). If you see `xterm-256color` instead, or get `unknown terminal type` errors, make sure `ncurses-term` is installed (see [Neovim Setup](./neovim-setup.md), step 2) — WSL's default terminfo database is quite minimal and is missing entries for `wezterm`/`tmux-256color` out of the box.

---

**See also:** [⌨️ WezTerm Cheatsheet](./wezterm-cheatsheet.md) &nbsp;|&nbsp; [← Back to README](../README.md)
