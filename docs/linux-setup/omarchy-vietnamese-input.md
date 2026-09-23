# Vietnamese Input on Omarchy (fcitx5 + Unikey)

How to type Vietnamese on Omarchy — installation, configuration, daily usage, and the hotkeys involved.

## Which tool is best for this

**`fcitx5-unikey`** (the Unikey engine running on top of the `fcitx5` input-method framework). This isn't just "a popular choice" in general — it's specifically the right fit for Omarchy for a concrete reason: **fcitx5 already ships and auto-starts by default on Omarchy** (it's what powers the built-in emoji/text-shortcut system). So there's no separate input-method framework to install or wire up first; you're only adding the Vietnamese engine on top of infrastructure that's already running. Installing a different framework (like `ibus`) instead would mean running two competing input-method daemons at once, which is exactly the kind of setup that causes apps to randomly stop accepting Vietnamese input.

`Unikey` itself is the de facto standard Vietnamese input engine across Windows, macOS, and Linux — it's what nearly every Vietnamese Linux user reaches for, and it supports both of Vietnam's two typing conventions (Telex and VNI) in one engine.

## 1. Install

```bash
sudo pacman -S fcitx5-unikey fcitx5-configtool
```

- `fcitx5-unikey` — the Vietnamese input engine itself.
- `fcitx5-configtool` — the GUI settings app used to add and configure it. You may already have this if you've customized fcitx5 for anything else before.

That's the whole install — no `fcitx5` base package needed (already present), no environment variables to export, no autostart entry to add. Omarchy's own environment setup already covers this: native Wayland GTK/Qt apps talk to fcitx5 directly through Hyprland's `text-input-v3` support, and `XMODIFIERS=@im=fcitx` is already set for older XWayland apps that need it.

## 2. Configure

1. Open the config tool — either run `fcitx5-configtool` in a terminal, or launch it from your app launcher (`Super + Space`, search "fcitx5" or "Input Method").
2. Go to the **Input Method** tab.
3. Click the **+** (Add Input Method) button.
4. Uncheck **"Only Show Current Language"** at the bottom of the add-dialog — otherwise Vietnamese won't be listed unless your system locale is already Vietnamese.
5. Search for **"Unikey"**, select **"Vietnamese - Unikey"**, and click **Add**.
6. With Unikey now in your input method list, click it, then click the **Configure** (wrench/gear) button next to it to open its own settings:
   - **Input method:** choose **Telex** (see "Which typing method" below).
   - **Output charset:** leave on the default (Unicode) unless you have a specific reason to change it.
   - **Vietnamese:** keep this checked/enabled (it's the toggle for whether Unikey is actively converting keystrokes at all — separate from the global fcitx5 on/off switch in Section 4).
7. Close the config tool. No reboot needed — fcitx5 picks up input-method changes live. If a specific already-open app doesn't seem to notice, restart just that app.

### Which typing method: Telex or VNI?

**Telex is the one to pick** — it's the default and by far the most widely used method in Vietnam (it's also what Unikey defaults to on Windows), typing Vietnamese diacritics using extra letter keys on a standard QWERTY layout. VNI instead uses number keys (`1`–`9`) for the same marks, and is more common among people who learned on older Vietnamese phone/computer software — pick it instead only if that's what you're already used to typing.

## 3. Hotkeys

| Hotkey                            | Function                                                                                                                       |
| --------------------------------- | ------------------------------------------------------------------------------------------------------------------------------ |
| `Ctrl + Space`                    | Toggle Vietnamese input on/off (switch between Unikey and your regular keyboard layout) — this is fcitx5's default trigger key |
| `Ctrl + Shift` (varies by config) | Temporarily switch to plain English/Latin input without fully disabling Unikey, on some configurations                         |

If `Ctrl + Space` conflicts with something else you use (it doesn't clash with any default Omarchy hotkey from `omarchy-guide.md`, but might with an app-specific binding), change it in `fcitx5-configtool` → **Global Options** tab → **Trigger Input Method**.

## 4. Troubleshooting

- **Check fcitx5 is actually running:**
  ```bash
  ps aux | grep fcitx5
  ```
  If nothing shows up, start it manually to test: `fcitx5 -d` (daemonizes) — but on Omarchy this should already be running automatically; if it's not, something else is wrong rather than a missing autostart entry.
- **Run the built-in diagnostic tool** — this is the fastest way to spot a real misconfiguration:
  ```bash
  fcitx5-diagnose
  ```
  It checks your environment variables, running processes, and installed engines, and reports what's missing.
- **A specific app won't accept Vietnamese input:** confirm the app is actually using Wayland's native text input (most GTK4/Qt6 apps do this automatically on Omarchy) versus XWayland (older apps, some games, some Electron apps) — XWayland apps depend on the `XMODIFIERS=@im=fcitx` environment variable, which Omarchy sets by default, but a small number of apps still don't respect it correctly. As a fallback, you can explicitly export the classic input-method variables before launching just that one app:
  ```bash
  GTK_IM_MODULE=fcitx QT_IM_MODULE=fcitx XMODIFIERS=@im=fcitx <app-command>
  ```
- **Changes in `fcitx5-configtool` don't seem to apply:** log out and back in as a last resort — this fully restarts fcitx5 along with the rest of your session.

## References

- Omarchy Discussions — "Setup unikey vietnam keyboard" (community-verified setup, Ctrl+Space toggle default): https://github.com/basecamp/omarchy/discussions/3986
- Omarchy Discussions — fcitx5 installed and auto-started by default on Omarchy: https://github.com/basecamp/omarchy/discussions/3670
- fcitx5-unikey (upstream project): https://github.com/fcitx/fcitx5-unikey
- Arch Wiki — Fcitx5: https://wiki.archlinux.org/title/Fcitx5
- Arch Linux package — fcitx5-unikey: https://archlinux.org/packages/extra/x86_64/fcitx5-unikey/
