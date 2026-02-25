<div align="center">
  <h1>Neovim Setup</h1>
  <sub>
    Nguyễn Tấn Phát <br />
    February 25, 2026
  </sub>
</div>

## Step 1: Install a Nerd Font on Windows

Before touching WSL, you must configure your Windows Terminal to support icons.

1. Go to the [Nerd Fonts](https://www.nerdfonts.com/font-downloads) website.
2. Download a font like **JetBrainsMono** or **FiraCode**.
3. Extract the `.zip` file, select all `.ttf` files, right-click, and choose **Install for all users**.
4. Open **Windows Terminal**, press `Ctrl + ,` to open **Settings**.
5. Go to your **Ubuntu profile** -> **Appearance** -> **Font face** and select the Nerd Font (e.g., `FiraCode NF`).

> Modern Neovim plugins use special characters for file icons, git branches, and UI separators. Standard fonts do not have these characters; Nerd Fonts are patched to include them.

## Step 2: Install System Dependencies on Ubuntu

Open your WSL Ubuntu terminal and run the following commands:

```bash
sudo apt update && sudo apt upgrade -y
```

**Explanation:** Refreshes the package list and updates existing software on your Ubuntu system to prevent dependency issues.

```bash
sudo apt install -y build-essential git curl unzip ripgrep fzf bat python3 python3-pip python3-venv
```

**Explanation:**

- `build-essential`: Provides the `gcc` compiler, which the `nvim-treesitter` plugin needs to compile code for syntax highlighting.
- `git`: Needed to download plugins.
- `curl`: Command-line tools to download files from the internet.
- `unzip`: Tools to extract downloaded archive files.
- `ripgrep`: A lightning-fast search tool used by Neovim to search for text inside files.
- `fzf`: A fast, interactive fuzzy finder for searching and filtering files, buffers, commands, and search results in real time.
- `bat`: A modern replacement for cat with syntax highlighting, line numbers, and Git integration.
- `python3` / `python3-pip` / `python3-venv`: Installs Python and its package managers. Many Neovim Language Servers and tools require a Python environment to function.

## Step 3: Install Node.js via NVM

Neovim relies heavily on Node.js to run Language Servers (via Mason or LSPConfig) for features like autocomplete and error checking. We will use Node Version Manager (NVM) to install it safely without permission issues.

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

source ~/.bashrc

nvm install --lts
```

## Step 4: Install the Latest Neovim Binary

The [Releases](https://github.com/neovim/neovim/releases) page provides an [AppImage](https://appimage.org/) that runs on most Linux systems. No installation is needed, just download `nvim-linux-x86_64.appimage` and run it. (It might not work if your Linux distribution is more than 4 years old.) The following instructions assume an `x86_64` architecture; on ARM Linux replace with `arm64`.

```bash
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
chmod u+x nvim-linux-x86_64.appimage
./nvim-linux-x86_64.appimage
```

To expose nvim globally:

```bash
mkdir -p /opt/nvim
mv nvim-linux-x86_64.appimage /opt/nvim/nvim
```

And the following line to your shell config (`~/.bashrc`, `~/.zshrc`, ...):

```bash
export PATH="$PATH:/opt/nvim/"
```

If the `./nvim-linux-x86_64.appimage` command fails, try:

```bash
./nvim-linux-x86_64.appimage --appimage-extract
./squashfs-root/AppRun --version

# Optional: exposing nvim globally.
sudo mv squashfs-root /
sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
nvim
```

## Step 5: Install win32yank for Clipboard Sync

To copy text in Neovim (WSL) and paste it into Windows (and vice versa) without delay, we use `win32yank`.

```bash
mkdir -p /tmp/win32yank
curl -sLo /tmp/win32yank/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.1.1/win32yank-x64.zip
unzip -p /tmp/win32yank/win32yank.zip win32yank.exe > /tmp/win32yank/win32yank.exe
chmod +x /tmp/win32yank/win32yank.exe
mv /tmp/win32yank/win32yank.exe ~/.local/bin/
rm -rf /tmp/win32yank
```

**Explanation:** This sequence downloads the Windows executable (`win32yank.exe`) , grants it execution permissions, and places it directly into your WSL Linux filesystem (`~/.local/bin/`). Keeping it in the Linux filesystem instead of the Windows `C:` drive prevents massive speed delays when copying text.

## Step 6: Pull The GitHub Configuration

Now, instead of configuring everything manually, we will pull the specific Neovim configuration directly from `dotfiles` repository.

```bash
# Clean up any existing or default Neovim folders to avoid conflicts
rm -rf ~/.config/nvim ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim

# Clone your dotfiles repository into a temporary folder
git clone --depth 1 https://github.com/phatnguyen975/dotfiles.git /tmp/dotfiles

# Ensure the parent.config directory exists
mkdir -p ~/.config

# Move the specific Neovim configuration folder to the required location
mv /tmp/dotfiles/.config/nvim ~/.config/nvim

# Clean up the temporary repository folder
rm -rf /tmp/dotfiles
```

**Explanation:** This script safely removes any generic Neovim files, downloads your personal GitHub repository into a temporary space, extracts only the `.config/nvim` folder you need, and places it exactly where Neovim expects it to be. Finally, it deletes the leftover files.
