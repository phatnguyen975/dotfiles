# Omarchy Desktop Usage

A practical starting guide for Omarchy 4.5.0 (Quattro RS). Complete [Post-Installation Checks](../common/post-install.md) before customizing the desktop.

## Learn the Desktop

Omarchy is an Arch-based desktop built around Hyprland and Wayland. It starts with a keyboard-oriented tiling layout, but 4.5 also provides a conventional floating layout.

`Super` refers to the Windows or Command key. Open the Omarchy menu to explore available applications, system tools and settings; inspect the current hotkey list whenever your local configuration differs from the defaults below.

## Essential Hotkeys

### Navigation and Windows

| Hotkey                     | Action                                 |
| -------------------------- | -------------------------------------- |
| `Super + Space`            | Open the Omarchy menu                  |
| `Super + Alt + Space`      | Open the app grid                      |
| `Super + Escape`           | Open power and session controls        |
| `Super + Ctrl + L`         | Lock the session                       |
| `Super + W` or `Super + Q` | Close the focused window               |
| `Super + L`                | Cycle window layouts                   |
| `Super + T`                | Toggle floating for the focused window |
| `Super + F`                | Make the focused window fullscreen     |
| `Super + Arrow`            | Change window focus                    |
| `Super + Shift + Arrow`    | Swap windows                           |
| `Super + 1/2/3/4`          | Switch workspaces                      |
| `Super + Shift + 1/2/3/4`  | Move a window to a workspace           |

Try opening two windows, switching workspace and cycling layout. Use the floating layout if you prefer traditional overlapping windows.

### Launch Applications

| Hotkey                   | Action              |
| ------------------------ | ------------------- |
| `Super + Return`         | Terminal            |
| `Super + Alt + Return`   | Tmux terminal       |
| `Super + Ctrl + Return`  | Herdr agent manager |
| `Super + Shift + Return` | Browser             |
| `Super + Shift + F`      | File manager        |
| `Super + Shift + N`      | Editor              |

Applications and defaults can change through user settings and package updates. A binding is not proof that the associated application is installed or already authenticated.

### Clipboard and System Controls

| Hotkey                    | Action                                 |
| ------------------------- | -------------------------------------- |
| `Super + C` / `Super + V` | Copy / paste                           |
| `Super + Ctrl + V`        | Clipboard history                      |
| `Super + Ctrl + C`        | Capture menu                           |
| `Super + Ctrl + A`        | Audio panel                            |
| `Super + Ctrl + N`        | Network panel                          |
| `Super + Ctrl + T`        | Theme picker                           |
| `Super + I`               | Cycle configured input methods/layouts |

Use the [official hotkey reference](https://omarchy.org/manual/hotkeys/) for grouping, monitor navigation, screenshots, recording, notification controls, reminders and other shortcuts. Local bindings are authoritative for a customized system.

## Configure the Desktop

Start with the Omarchy menu instead of editing system files manually.

- **Setup:** keyboard, monitors, language and default applications. Language changes and input-method changes are separate; see [Vietnamese Input](vietnamese-input.md) for composition.
- **Style:** themes and backgrounds. Try an included theme first, and review third-party themes or plugins before installing them.
- **Install:** additional applications, development tools and services. Check whether an app is a native program, a web app or an installer for an external service.
- **Trigger:** actions such as screenshots, recording, clipboard and toggles.
- **Update:** supported system updates and update-channel selection. Keep stable unless you deliberately want to test development builds.

Back up your user configuration before changing it. In 4.5, custom Hyprland keybindings are documented in `~/.config/hypr/bindings.lua`; do not copy old `.conf` examples into a Lua-based configuration without adapting them.

## Manage Packages

Use the Omarchy menu for installation and removal. The CLI provides equivalent commands, including `omarchy update` for system upgrades and `omarchy pkg add` for adding packages.

For example, add an application after checking it exists in the current repositories:

```bash
omarchy pkg add fcitx5-configtool
```

These read-only pacman commands are useful for inspection:

```bash
pacman -Q omarchy
pacman -Qs fcitx5
pacman -Ss fcitx5-unikey
```

Do not run an independent full-system pacman/yay upgrade or refresh the package database without upgrading. Omarchy coordinates package changes with its own migrations, snapshots and repository policy.

For other CLI operations, consult the [Omarchy CLI manual](https://omarchy.org/manual/omarchy-cli/) and check the installed tool's help. Review unfamiliar AUR build scripts and do not install from arbitrary shell snippets.

## Work in a Terminal

Use the default terminal for ordinary shell work and Tmux when you need multiple persistent panes or sessions. Omarchy supplies custom bindings, so inspect the configured shortcuts rather than assuming the stock Tmux prefix.

In Neovim, start with `:Tutor` for basic editing, then explore the LazyVim mappings and command hints. Use the file manager for normal browsing and removable-volume access, and keep development repositories on a native Linux filesystem rather than exFAT.

The official [Terminal](https://omarchy.org/manual/terminal/) and [Neovim](https://omarchy.org/manual/neovim/) pages cover the available terminals, splits, tabs, Tmux and editor workflows. The [Development Tools](https://omarchy.org/manual/development-tools/) page covers language runtimes and tooling.

## Use AI Tools Deliberately

Omarchy provides agent launchers, optional AI applications and agent-oriented desktop workflows. Availability, provider accounts, pricing and age eligibility depend on the individual service; do not assume that an installed launcher includes a subscription.

- Use the menu or terminal to inspect supported tools; the current [AI manual](https://omarchy.org/manual/ai/) explains lazy installation, default agents, the agents panel and local models.
- Prefer a normal, permission-reviewing agent session. Some Omarchy shortcuts and aliases launch agents with automatic approval, so do not use those for sensitive system tasks.
- Work inside a dedicated project, use version control, and review proposed changes before execution. Never grant an agent unrestricted access to disks, boot configuration, credentials or recovery keys.
- Review the privacy implications of cloud agents, crash diagnosis and dictation before sending logs, voice or project files. A local model also needs sufficient memory and compatible hardware.

For desktop customization, make a backup and apply small reversible changes. Use the built-in Omarchy skill as guidance, not as evidence that a proposed command is safe.

## Maintain and Troubleshoot

Run system updates through [Post-Installation Checks](../common/post-install.md). If an update causes a regression, follow [Recovery and Cleanup](../recovery/README.md) rather than resetting all user configuration immediately.

Use the [Networking](https://omarchy.org/manual/networking/) and [Troubleshooting](https://omarchy.org/manual/troubleshooting/) pages for specific hardware problems. Capture the installed version, relevant hardware identifiers and error logs before seeking help, and remove credentials or personal data from logs before sharing.

## References

- [Omarchy 4.5 Release Announcement](https://omarchy.org/news/2026/11/omarchy-4-5/)
- [Omarchy: Hotkeys](https://omarchy.org/manual/hotkeys/)
- [Omarchy: Keyboard, Mouse, Trackpad](https://omarchy.org/manual/keyboard-mouse-trackpad/)
- [Omarchy: Other Packages](https://omarchy.org/manual/other-packages/)
- [Omarchy: Updates](https://omarchy.org/manual/updates/)
- [Omarchy: AI](https://omarchy.org/manual/ai/)
- [Omarchy: Themes](https://omarchy.org/manual/themes/)
