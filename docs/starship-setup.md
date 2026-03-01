<div align="center">
  <h1>Starship Setup</h1>
  <sub>
    Nguyễn Tấn Phát <br />
    February 25, 2026
  </sub>
</div>

## 1. Install Starship Binary

First, ensure the Starship binary is installed on your WSL instance. Run the following command:

```bash
curl -sS https://starship.rs/install.sh | sh
```

**Note:** You may be prompted for your password to authorize the installation.

## 2. Prepare the Configuration Folder

Starship looks for its configuration file in a specific hidden folder in your home directory (`~/.config`). Let's create it:

```bash
mkdir -p ~/.config
```

## 3. Copy Your Configuration File

Now, take your existing `starship.toml` file and move it into that folder.

```bash
cp ~/path/to/repo/.config/starship/starship.toml ~/.config/starship.toml
```

## 4. Activate Starship in Bash

To make Starship start automatically every time you open WSL, you must add it to your Bash profile.

- Open the `.bashrc` file:

```bash
vim ~/.bashrc
```

- Add the initialization command at the very bottom of the file:

```bash
eval "$(starship init bash)"
```

- Press `:wqa`, then `Enter` to save and exit.

## 5. Apply the Changes

To see your new prompt immediately without restarting WSL, run:

```bash
source ~/.bashrc
```
