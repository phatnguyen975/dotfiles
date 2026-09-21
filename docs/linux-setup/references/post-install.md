# Post-Install Checks

## 1. First boot

After the installer finishes and reboots:

1. At the **Limine** boot menu (Omarchy's default bootloader — Btrfs + Snapper + Limine, installed automatically), select the **Linux** entry.
2. If you enabled full-disk encryption (the Omarchy default), you'll be prompted for your **LUKS password** here — **use a wired or 2.4 GHz-dongle keyboard**, not Bluetooth, since Bluetooth isn't initialized this early in boot (this is explicitly called out in Omarchy's own manual).
3. Hyprland loads, and you land on the Omarchy top bar / first-run experience.

## 2. Common checks for every method

- **Date/time correct** — matters for package signature verification during updates.
- **Network works** — connect Wi-Fi via the network panel (NetworkManager-based as of Omarchy 4.x), or confirm Ethernet auto-connected.
- **Update the system immediately:**
  - GUI: Omarchy menu (**Super**) → **Update → Omarchy**.
  - CLI: `omarchy-update`.
- **Confirm the bootloader sees what you expect.** Reboot fully (not just log out) and check the Limine menu shows the entries you expect for your install method — this is your main correctness check that the install completed properly and that boot-order/boot-menu behavior matches what you configured.

## 3. Limine snapshots (Omarchy's built-in rollback)

Omarchy's default Btrfs + Snapper + Limine setup takes automatic snapshots, which appear as extra boot entries in the Limine menu — if an update or config change breaks your system, you can boot into a prior snapshot straight from the boot menu without any recovery media. See the official manual: https://omarchy.org/manual/system-snapshots/.

## 4. Driver/firmware checks (worked example: Gigabyte A16)

- Check `dmesg` after first boot for any hardware warnings (`dmesg | grep -i -E "error|fail"`), particularly around GPU and Wi-Fi, since gaming laptops often combine a discrete GPU with hybrid graphics switching.
- Omarchy's **Install** menu (Super → Install) exposes optional package groups (gaming tools, etc.) — install what you need from there rather than manually chasing packages, consistent with Omarchy's "opinionated defaults" approach.
- If Wi-Fi or the GPU isn't recognized out of the box, search the Arch Wiki for your exact chipset (found via `lspci -k` for GPU/network controllers) — this is the most reliable, up-to-date source for Linux hardware support on any given component.

## References

- Omarchy — Getting Started (first-boot keyboard requirement): https://omarchy.org/manual/getting-started/
- Omarchy — System Snapshots: https://omarchy.org/manual/system-snapshots/
- Omarchy — Updates: https://omarchy.org/manual/updates/
- Arch Wiki — general hardware troubleshooting starting point: https://wiki.archlinux.org/title/Category:Hardware
