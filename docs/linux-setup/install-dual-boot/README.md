# Method 2 — Dual Boot on the Shared Internal SSD

Windows and Omarchy live side by side on the **same physical disk** — you shrink the existing Windows partition to free up space, then install Omarchy into that free space. This carries more risk than Method 3 (external SSD) since it modifies the disk Windows is already on, but keeps everything on one internal drive with no extra hardware needed.

Worked example throughout: **Omarchy 4.0.4** on a **Gigabyte A16** gaming laptop, installer built with a **SanDisk USB stick**.

## Step 1 — Prerequisites

Follow [prerequisites.md](../references/prerequisites.md) in full: confirm UEFI mode, download and checksum-verify the Omarchy 4.0.4 ISO. **Back up your data before starting** — more important here than for Method 3, since this method resizes the disk Windows is actively running on.

## Step 2 — Identify the correct internal disk

Follow [disk-and-usb-identification.md](../references/disk-and-usb-identification.md) in full. For this method there's no external SSD to distinguish — just your internal disk and the install USB — but the same size/model verification habit still matters, especially once you reach the installer's disk-selection screen in Step 6.

## Step 3 — Shrink the Windows partition to free up space

Full detailed walkthrough (exact fields, BitLocker note): [windows-shrink-and-boot-menu.md](references/windows-shrink-and-boot-menu.md). Summary:

1. Open **Disk Management** (search "disk management" in the Start menu).
2. Right-click your `C:` partition → **Shrink Volume...**.
3. Enter how much space to free up (in MB) — this becomes the size of your entire future Omarchy install, so leave enough headroom for the OS itself plus any shared data partition you might want.
4. Click **Shrink** — you'll see a new **Unallocated** block appear next to `C:`. Leave it unallocated; don't format it or give it a drive letter.

## Step 4 — Build the install USB

Follow [usb-preparation.md](../references/usb-preparation.md) in full using the Omarchy 4.0.4 ISO and your SanDisk USB stick.

## Step 5 — Enter BIOS, adjust settings

Follow [bios-uefi-and-boot-menu.md](../references/bios-uefi-and-boot-menu.md) in full. On the Gigabyte A16: power on, press **F2** repeatedly to enter BIOS setup, disable **Secure Boot** (Omarchy-specific requirement) and **Fast Boot** (general), leave CSM/Legacy off. Save and exit (**F10**), then press **F12** repeatedly on the next boot to bring up the one-time boot menu and select the install USB.

## Step 6 — Boot the installer, select free-space install

1. From the Omarchy live boot menu, boot into the installer — a text-based, keyboard-driven flow (arrow keys to move, Enter to select, on every screen).
2. **Keyboard layout** — highlight yours and press **Enter**.
3. **Network connection** — connect to Wi-Fi if no wired connection is detected (arrow keys to pick your network, type the password if prompted, Enter to connect).
4. **Disk selection** — the installer lists every disk it can install to. Highlight your **internal disk** (cross-check size/model against Step 2) and press **Enter**.
5. **Partitioning mode** — after selecting the disk, you're offered a choice between a full-disk install and **Free space install**. Choose **Free space install** — this is what tells the installer to use only the unallocated space you freed up in Step 3, leaving your existing Windows partition untouched.

## Step 7 — Complete the install

Continue through the remaining prompts, typing each value and pressing **Enter**:

1. **Username** — alphanumeric, no spaces (e.g. `phatnguyen`).
2. **Password** — used for three things: your user login, the root account, and unlocking the LUKS-encrypted Omarchy partition at every boot (free-space installs are LUKS-encrypted by default, same as full-disk).
3. **Full name and email** (optional, for Git config) — press Enter to skip if not needed.
4. **Hostname** — e.g. `a16-omarchy`.
5. **Timezone** — arrow keys + Enter.
6. **Summary/confirmation screen** — review everything, especially that the target is your free space and not the whole disk, then confirm.
7. Installation runs — typically well under 5 minutes. On completion, select **Reboot** and remove the install USB when prompted.

## Step 8 — Add Windows to the boot menu

This is a **required extra step** for this method, not optional — Omarchy's installer does not automatically detect or list Windows in the Limine menu, even though both are on the same disk. Full explanation and boot-order notes: [windows-shrink-and-boot-menu.md](references/windows-shrink-and-boot-menu.md). Quick version:

1. Boot into Omarchy (it's the only entry Limine shows at this point).
2. Open a terminal (**Super + Return**) and run:
   ```bash
   sudo limine-scan
   ```
   Type your password when prompted, follow any on-screen prompts to confirm adding the Windows entry.
3. Reboot. The Limine menu should now list both **Omarchy** and **Windows** — test both to confirm.

## Step 9 — Post-install

Follow [post-install.md](../references/post-install.md): first-boot LUKS password (wired/2.4GHz keyboard — Bluetooth won't work this early), network check, run `omarchy-update`, and read up on Limine's automatic Btrfs/Snapper snapshots.

## Step 10 — (Optional) Shared data partition

If you left extra unallocated space beyond what Omarchy's root/boot partitions used, or want to carve out a separate area later, see [shared-data-partition.md](../references/shared-data-partition.md) for setting up an exFAT partition both OSes can read and write to without permission issues.

## References

- Omarchy — Dual Boot Install (official manual: shrinking Windows, free-space install, `limine-scan`, BitLocker note): https://omarchy.org/manual/dual-boot-install/
- Omarchy — Getting Started (installer flow, encryption defaults): https://omarchy.org/manual/getting-started/
- Omarchy — System Snapshots: https://omarchy.org/manual/system-snapshots/
- Omarchy ISO releases (GitHub): https://github.com/basecamp/omarchy/releases
- Dual Boot Omarchy 4 & Windows 11 on Same Drive: https://www.youtube.com/watch?v=26GnlpsvaFw
- Omarchy Linux 4 Dual Boot Install with Windows 11: https://www.youtube.com/watch?v=2fkWrFAhHDg
