# Method 3 — Install onto an External SSD

Your internal drive (Windows) is **never touched** by this method — the installer only ever writes to the external SSD. This makes it the lowest-risk of the three methods, and the one used for the worked example throughout: **Omarchy 4.0.4** on a **Gigabyte A16** gaming laptop, installed **full-disk** onto an **external SSD** (install media is a SanDisk USB stick — see [usb-preparation.md](../references/usb-preparation.md)).

Two variants are covered:

- **Full-disk:** the entire external SSD becomes the Linux install (the worked-example path).
- **Partitioned:** the external SSD is split into a Linux install + a separate shared-data partition readable/writable from both Windows and Linux.

## Step 1 — Prerequisites

Read [prerequisites.md](../references/prerequisites.md) in full: confirm UEFI mode, back up anything already on the external SSD, download and checksum-verify the Omarchy 4.0.4 ISO.

Because Windows itself isn't being modified, this method carries less risk than Methods 1/2 — but still back up the external SSD's existing contents, since Step 5 will erase it.

## Step 2 — Identify the external SSD correctly

Read [disk-and-usb-identification.md](../references/disk-and-usb-identification.md) in full before going further — this is the step where mixing up the external SSD with the internal NVMe drive would cause real damage.

**Worked example:** with the Gigabyte A16's internal NVMe SSD, the external SSD, and the install USB all connected, `lsblk -o NAME,SIZE,MODEL,TRAN` inside the Omarchy live environment shows three distinct devices — the internal drive under `nvme0n1` (transport `nvme`), and the external SSD and install USB both under `sdX` (transport `usb`), distinguished from each other by size (e.g. ~1 TB SSD vs ~16 GB install USB). Confirm the external SSD's device name by size before Step 5.

## Step 3 — Build the install USB

Follow [usb-preparation.md](../references/usb-preparation.md) in full using the Omarchy 4.0.4 ISO and your SanDisk USB stick. Summary:

1. Download `omarchy-4.0.4.iso`, verify its SHA256 checksum.
2. Flash it with Rufus (Windows — choose **GPT** partition scheme, **UEFI (non CSM)** target, and **DD Image mode** when prompted) or balenaEtcher (any OS, no mode choice needed).
3. Confirm the USB boots (do a quick test boot before relying on it for the real install).

## Step 4 — Connect the external SSD, enter BIOS, adjust settings

1. Plug in **both** the install USB and the external SSD.
2. Power on the Gigabyte A16 and press **F2** to enter BIOS setup (see [bios-uefi-and-boot-menu.md](../references/bios-uefi-and-boot-menu.md) for the full vendor key table and settings explanations).
3. Set:
   - **Secure Boot → Disabled** _(Omarchy-specific requirement — see [bios-uefi-and-boot-menu.md](../references/bios-uefi-and-boot-menu.md) for why, and why other distros may not need this)_
   - **Fast Boot → Disabled** _(general — helps the boot-menu key respond)_
   - Leave **CSM/Legacy** off, UEFI only _(general)_
   - Confirm storage controller isn't in a RAID/VMD mode that would hide the internal NVMe drive _(general; shouldn't be an issue on a stock A16, but worth a glance while you're in there)_
4. Save and exit (usually **F10**), which reboots the machine.
5. Immediately press **F12** repeatedly to bring up the one-time boot menu, and select the install USB.

## Step 5 — Boot the installer, select the external SSD as target

1. From the Omarchy live boot menu, boot into the installer. It starts automatically as a text-based (keyboard-driven) installer — use the **arrow keys** to move between options and **Enter** to select, throughout every screen.
2. **Keyboard layout** — the first screen. Use the arrow keys to highlight your layout (e.g. "US") and press **Enter**.
3. **Network connection** — if the installer doesn't detect a wired connection, it automatically scans for Wi-Fi networks. Use the arrow keys to highlight your network and press **Enter**; if it's password-protected, a text field opens automatically — type the password and press **Enter**.
4. **Disk selection** — the installer lists every disk it can install to. Use the arrow keys to highlight the external SSD (cross-check its size against what you confirmed in Step 2 — **not** the internal NVMe drive) and press **Enter**. **This is the step that actually decides which physical disk gets used** — whatever you choose next (full-disk or free-space) only ever applies to the disk you selected right here, never to any other disk in the machine.
5. **Partitioning mode** — after selecting the disk, the installer offers a choice between wiping the whole disk and a free-space install. Which one to pick is covered next — both apply only to the external SSD you just selected in step 4, so the internal Windows drive is unaffected either way.

### Full-disk variant (worked example)

Choose the **full-disk** install option. Since you already selected the external SSD in step 4 above, this wipes and takes over the **entire external SSD only** — installing Omarchy's default layout: Btrfs root + Snapper + Limine bootloader, with full-disk LUKS encryption on by default. The internal Windows drive is never referenced during this process, because it was never the disk selected in step 4.

### Partitioned variant

If you want a dedicated shared-data partition alongside Linux on the same external SSD:

1. Before running the Omarchy installer's own partitioner, use `cfdisk /dev/sdX` or `gparted` from the live environment to carve out the space you want to reserve for shared data, leaving the rest of the disk free.
2. Run the Omarchy installer and point it at the **free space** on the external SSD (same "free-space install" mechanism Omarchy uses for dual-boot — see [shared-data-partition.md](../references/shared-data-partition.md) and the official dual-boot manual page: https://omarchy.org/manual/dual-boot-install/) rather than the full disk.
3. After Omarchy is installed, format the remaining reserved space as exFAT and set up the fstab mount — full instructions in [shared-data-partition.md](../references/shared-data-partition.md).

## Step 6 — Complete the install

Continue through the installer's remaining prompts, typing each value and pressing **Enter** to move to the next field:

1. **Username** — alphanumeric, no spaces (e.g. `phatnguyen`).
2. **Password** — this single password is used for three things: logging into your user account, the root account, and unlocking the LUKS-encrypted disk at every boot, so choose something you'll remember and re-type reliably on a physical keyboard.
3. **Full name and email** (optional) — used only for local Git configuration; press Enter to skip if you don't want to set these now.
4. **Hostname** — the name this computer shows as on your network (e.g. `a16-omarchy`).
5. **Timezone** — arrow keys + Enter to select from the list.
6. **Disk encryption confirm** — if the disk-encryption/LUKS screen shows a passphrase step separately, make sure you actually apply it to the target partition (this is the step that's easy to skip by accident and end up with an unencrypted disk).
7. **Summary/confirmation screen** — review everything, then confirm to proceed. This triggers the actual disk-format warning — **re-check the target disk shown here one last time** before confirming, since this is the point of no return.
8. Installation runs — typically finishes in well under 5 minutes on modern hardware (per Omarchy's own documentation, packages are pre-bundled in the ISO rather than downloaded during install). On completion, select **Reboot** and remove the install USB when prompted.

## Step 7 — Decide and configure your boot-selection method

Because the external SSD carries its own bootloader (Limine) and the internal Windows disk's own boot files are untouched, you have several ways to control which one boots on any given power-on. Full detail, tradeoffs, and how Limine behaves in each case: [boot-selection-strategies.md](references/boot-selection-strategies.md). In short:

1. **Plug in before power-on** — with the external SSD connected at boot, firmware typically lists its EFI boot entry; select it via boot order or boot menu to load Limine, which then boots into Omarchy. Unplugged, the machine falls straight through to Windows untouched.
2. **One-time boot-menu hotkey** — leave saved boot order as-is (Windows default), press **F12** whenever you specifically want to boot the external SSD.
3. **Reordered boot priority** — set the external SSD's EFI entry above the internal Windows entry in BIOS boot order; when the SSD isn't connected, the firmware automatically falls through to Windows.
4. **Add Windows into the Limine menu itself** (`sudo limine-scan`) — instead of relying on firmware to switch between two separate boot managers, Limine can detect Windows Boot Manager and list it as a second option inside its own menu, giving you one unified "pick Linux or Windows" screen once Limine loads. Full walkthrough in [boot-selection-strategies.md](references/boot-selection-strategies.md).

## Step 8 — First reboot, both scenarios

1. Reboot **with** the external SSD connected — confirm you reach the Limine menu and can boot into Omarchy.
2. Reboot **without** the external SSD connected — confirm the machine boots straight into Windows as before, with no leftover Linux boot entries interfering (this confirms Method 3's core promise: the internal Windows disk is untouched).

## Step 9 — Post-install

Follow [post-install.md](../references/post-install.md): first-boot LUKS password (wired/2.4GHz keyboard — Bluetooth won't work this early), network check, run `omarchy-update`, and read up on Limine's automatic Btrfs/Snapper snapshots for easy rollback if an update ever breaks something.

## Step 10 — (Optional) Set up the shared data partition

If you used the partitioned variant, finish the cross-OS mount setup in [shared-data-partition.md](../references/shared-data-partition.md) so the shared area is accessible with normal read/write permissions from both Omarchy and Windows.

## References

- Omarchy — Getting Started (official install flow, disk selection, encryption defaults): https://omarchy.org/manual/getting-started/
- Omarchy — Dual Boot Install (free-space install mechanism, used here for the partitioned variant; also documents `limine-scan`): https://omarchy.org/manual/dual-boot-install/
- Omarchy — System Snapshots: https://omarchy.org/manual/system-snapshots/
- Omarchy ISO releases (GitHub): https://github.com/basecamp/omarchy/releases
- How to Dual Boot Omarchy and Windows: https://www.youtube.com/watch?v=JnjLMfoFarY
- How to Install Linux on External SSD: https://www.youtube.com/watch?v=lz8TDYSKXu8
