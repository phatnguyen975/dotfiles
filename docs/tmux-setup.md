<div align="center">
  <h1>Tmux Setup</h1>
  <sub>
    Nguyễn Tấn Phát <br />
    June 23, 2026
  </sub>
</div>

## 1. Install tmux

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

# Install Catppuccin theme MANUALLY (not via TPM)
mkdir -p ~/.config/tmux/plugins/catppuccin
git clone -b v2.3.0 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux
```

## 3. Create the `tmux.conf` File

The full configuration lives at `.config/tmux/tmux.conf` in this repo. You can copy it or use your own configuration.

Then install the TPM-managed plugins:

```bash
# Inside a tmux session:
Prefix + I   # install plugins
Prefix + U   # update plugins later
```

## 4. Configure Neovim for Integration

Add `christoomey/vim-tmux-navigator` to your Neovim plugin spec — see `.config/nvim/lua/plugins/tmux-navigator.lua`.

## 5. Final Activation

1. **Open tmux:** `tmux`
2. **Install TPM plugins:** `Prefix` (`Ctrl+a`) then `Shift+I`.
3. **Font check:** Confirm your terminal (WezTerm) uses a Nerd Font, e.g. `FiraCode Nerd Font`.
4. **Verify:** Status bar (session name, RAM, clock) should render correctly immediately.

---

**See also:** [⌨️ Tmux Cheatsheet](./tmux-cheatsheet.md) &nbsp;|&nbsp; [← Back to README](../README.md)
