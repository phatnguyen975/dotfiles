# Method 1 — Full Disk Install

Omarchy takes over the **entire internal disk** — Windows is completely erased in the process. This is the simplest of the three methods (no partition math, no dual-boot menu to configure), but also the least reversible: undoing it means reinstalling Windows from scratch (covered at the end of this guide).

Worked example throughout: **Omarchy 4.0.4** on a **Gigabyte A16** gaming laptop, installer built with a **SanDisk USB stick**.

## Step 1 — Prerequisites

Follow [prerequisites.md](../references/prerequisites.md) in full: confirm UEFI mode, download and checksum-verify the Omarchy 4.0.4 ISO. **Back up everything you want to keep before starting.** This is the highest-stakes of the three methods — there's no partial undo once the disk is wiped, so treat the backup step as mandatory, not optional.

## Step 2 — Identify the correct internal disk

Follow [disk-and-usb-identification.md](../references/disk-and-usb-identification.md) in full. With this method you'll typically only have two devices connected — the internal disk and the install USB — but the disk-selection screen in Step 5 is still the single most important click in this whole process, since it wipes whatever you select there.

## Step 3 — Build the install USB

Follow [usb-preparation.md](../references/usb-preparation.md) in full using the Omarchy 4.0.4 ISO and your SanDisk USB stick.

## Step 4 — Enter BIOS, adjust settings

Follow [bios-uefi-and-boot-menu.md](../references/bios-uefi-and-boot-menu.md) in full. On the Gigabyte A16: power on, press **F2** repeatedly to enter BIOS setup, disable **Secure Boot** (Omarchy-specific requirement) and **Fast Boot** (general), leave CSM/Legacy off. Save and exit (**F10**), then press **F12** repeatedly on the next boot to bring up the one-time boot menu and select the install USB.

## Step 5 — Boot the installer, select the internal disk, choose full-disk

1. From the Omarchy live boot menu, boot into the installer — a text-based, keyboard-driven flow (arrow keys to move, Enter to select, on every screen).
2. **Keyboard layout** — highlight yours and press **Enter**.
3. **Network connection** — connect to Wi-Fi if no wired connection is detected (arrow keys to pick your network, type the password if prompted, Enter to connect).
4. **Disk selection** — the installer lists every disk it can install to. Highlight your **internal disk** (cross-check size/model against Step 2) and press **Enter**. **This is the step that decides what gets wiped** — everything after this point applies only to the disk you select right here.
5. **Partitioning mode** — choose the **full-disk** option (as opposed to a free-space install). This erases the entire disk, including the existing Windows partitions, and installs Omarchy's default layout: Btrfs root + Snapper + Limine bootloader.

## Step 6 — Complete the install

Continue through the remaining prompts, typing each value and pressing **Enter**:

1. **Username** — alphanumeric, no spaces (e.g. `phatnguyen`).
2. **Password** — used for three things: your user login, the root account, and unlocking the LUKS-encrypted disk at every boot (full-disk installs are LUKS-encrypted by default).
3. **Full name and email** (optional, for Git config) — press Enter to skip if not needed.
4. **Hostname** — e.g. `a16-omarchy`.
5. **Timezone** — arrow keys + Enter.
6. **Summary/confirmation screen** — this is the final disk-wipe warning. **Re-check the disk shown here one last time** — this is the point of no return, after which Windows and everything else on that disk is gone.
7. Installation runs — typically well under 5 minutes. On completion, select **Reboot** and remove the install USB when prompted.

## Step 7 — First boot

The Limine boot menu now shows **only Omarchy** (plus its own Btrfs/Snapper snapshot entries) — there's no Windows entry to worry about, no boot-order decisions to make, and no `limine-scan` step needed, since Windows no longer exists on this machine. Powering on takes you straight to the Limine menu, and Omarchy is the only real choice.

## Step 8 — Post-install

Follow [post-install.md](../references/post-install.md): first-boot LUKS password (wired/2.4GHz keyboard — Bluetooth won't work this early), network check, run `omarchy-update`, and read up on Limine's automatic Btrfs/Snapper snapshots for easy rollback if an update ever breaks something.

## If you ever want Windows back

Since Windows is fully erased by this method, restoring it later means a fresh Windows install, not an undo. Clearing the disk beforehand — including that you can no longer run `diskpart` from within Windows since it's gone, and the alternatives that work instead (GParted Live, booting the Windows installer USB directly, or clearing the disk from a Linux live USB) — is covered in **Scenario C** of [rollback-and-cleanup.md](../references/rollback-and-cleanup.md). For the actual Windows 11 reinstall itself — creating the install USB, re-enabling the BIOS settings Omarchy needed off, and walking through Windows Setup — see [reinstall-windows-11.md](references/reinstall-windows-11.md).

## References

- Omarchy — Getting Started (official install flow, disk selection, encryption defaults): https://omarchy.org/manual/getting-started/
- Omarchy — System Snapshots: https://omarchy.org/manual/system-snapshots/
- Omarchy ISO releases (GitHub): https://github.com/basecamp/omarchy/releases
