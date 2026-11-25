# Vietnamese Input on Omarchy

Use Fcitx5 with the Unikey engine for Telex or VNI composition on Omarchy 4.5.0. This is optional and does not require changing the system's display language.

Omarchy 4.5 documents built-in setup for several East Asian composition engines, but Unikey is not among its documented built-in selections. The following procedure uses the existing Fcitx5 framework and the Arch package for Vietnamese input.

## 1. Check and Install the Input Engine

Open the terminal and check the framework and package availability:

```bash
pacman -Q fcitx5
pacman -Ss fcitx5-unikey
pgrep -a fcitx5
```

On a normal Omarchy 4.5 session, Fcitx5 is already running. If the framework is missing or the service is not running, resolve that first using the [official keyboard documentation](https://omarchy.org/manual/keyboard-mouse-trackpad/) rather than adding a second input framework or duplicate autostart entries.

Update Omarchy through its own update workflow if needed, then install the input engine and configuration utility:

```bash
omarchy pkg add fcitx5-unikey
omarchy pkg add fcitx5-configtool
```

Both packages exist in Arch's Extra repository. If they are unavailable in your current Omarchy channel, do not switch repositories merely to obtain them; check the supported package path first.

## 2. Configure Unikey

1. Open the configuration utility:
   ```bash
   fcitx5-configtool
   ```
2. Open **Input Method**, select the add control, and disable **Only Show Current Language** if the engine is hidden.
3. Search for `Unikey` and add the Vietnamese Unikey engine. Keep your usual keyboard layout in the list so you can switch back to plain Latin typing.
4. Select Unikey and open its engine settings. Choose **Telex** or **VNI** and Unicode output, if offered.
5. Apply the changes. Restart the affected application or sign out and back in if the engine does not appear immediately.

Menu labels may differ by configuration-tool version. Do not change the entire keyboard layout to Vietnamese as a substitute for installing an input engine.

## 3. Choose a Switching Shortcut

Omarchy 4.5 uses `Super + I` to cycle its configured input methods and keyboard layouts. Test whether the manually added Unikey engine participates in that cycle on your installed system.

If it does not, use the Fcitx5 configuration utility's global switching or trigger keys instead. `Ctrl + Space` is a common Fcitx trigger, but it can conflict with Tmux or editor shortcuts; inspect the actual configured key and change it if necessary.

## 4. Verify Vietnamese Typing

Test in a plain-text editor first, then in the browser and terminal applications you actually use.

For Telex, with Unikey active, type `tieengs Vieetj` and confirm that it produces `tiếng Việt`. For VNI, select the VNI engine setting and test `tie6ng1 Vie6t5` for the same result.

Switch back to the normal keyboard and confirm that ordinary Latin input works. Save a UTF-8 test file and reopen it to confirm the text is stored correctly.

## 5. Troubleshoot Input

If no application receives Vietnamese input, check that the process is running and the engine is installed:

```bash
pgrep -a fcitx5
pacman -Q fcitx5-unikey
fcitx5-diagnose
```

If only certain applications fail, determine whether they run natively on Wayland or through XWayland. GTK, Qt and Chromium/Electron applications may need different input integration; use the [Fcitx Wayland guide](https://fcitx-im.org/wiki/Using_Fcitx_5_on_Wayland) to identify the appropriate configuration for that application.

Do not globally force GTK/Qt input variables or launch a second Fcitx daemon as a first fix. Omarchy already provides Wayland-aware input configuration, and conflicting overrides can break working applications.

If you want to undo the customization, remove Unikey from the active input-method list and keep the existing Fcitx5 framework. Verify the normal keyboard works before removing the optional engine package using Omarchy's supported package-management workflow.

## References

- [Omarchy 4.5 Release Announcement](https://omarchy.org/news/2026/11/omarchy-4-5/)
- [Omarchy: Keyboard, Mouse, Trackpad](https://omarchy.org/manual/keyboard-mouse-trackpad/)
- [Arch Linux: fcitx5-unikey](https://archlinux.org/packages/extra/x86_64/fcitx5-unikey/)
- [Arch Linux: fcitx5-configtool](https://archlinux.org/packages/extra/x86_64/fcitx5-configtool/)
- [Fcitx5 Unikey Upstream](https://github.com/fcitx/fcitx5-unikey)
- [ArchWiki: Fcitx5](https://wiki.archlinux.org/title/Fcitx5)
- [Omarchy Community: Vietnamese Input](https://github.com/omacom/omarchy/discussions/3986) (community example, predates 4.5)
