# Rollback & Cleanup

Reference for undoing/reclaiming media after you're done with an install, split by scenario. Before running any command below, confirm you have the correct disk by checking its size and model (`list disk` in diskpart, or `lsblk` in Linux) — a wrong selection here is irreversible, same risk as the original install.

## Scenario A — Reformat the install USB back to normal storage

A USB written by Rufus/Etcher/Ventoy often shows as unformatted/RAW or an unfamiliar partition layout in Windows Explorer, and Explorer's own "Format" option may be greyed out or fail. `diskpart clean` resets it cleanly:

```
diskpart
list disk
select disk N
clean
convert gpt
create partition primary
list partition
select partition N
format fs=exfat quick label="USB"
assign
exit
```

Type each line exactly and press Enter after each one. Replace `N` in `select disk N` with the actual number shown by `list disk` (e.g. `select disk 2`) — **verify it by size/model first; this must be the USB stick, not anything else**, since `clean` erases the partition table and is irreversible.

Same command meanings as above: `clean` wipes the existing partition table, `convert gpt` sets a fresh GPT layout, `create partition primary` + `format` + `assign` turn it back into a normal, drive-lettered, Explorer-visible volume. **Why `exfat` here instead of `fat32`:** once you're using the drive for everyday storage (rather than as an empty base for Rufus/Etcher), exFAT removes FAT32's 4 GB single-file limit while staying readable on Windows, macOS, and Linux without extra drivers — a better fit for general use. Use `fs=fat32` instead only if you specifically need compatibility with an older device (an old camera, a car stereo, a game console) that doesn't understand exFAT.

## Scenario B — Wipe an external SSD back to a clean/empty state

Same approach, from a Windows PC with the external SSD connected:

```
diskpart
list disk
select disk N
clean
convert gpt
create partition primary
list partition
select partition N
format fs=exfat quick label="SSD"
assign
exit
```

Same as Scenario A: replace `N` with the number matching the external SSD (verify by size/model — **this must be the external SSD, not the internal drive**), then type each line and press Enter after each one.

**From Linux instead** (e.g. still booted into the Omarchy live environment, or any Linux system):

```bash
lsblk -o NAME,SIZE,MODEL,TRAN        # confirm which device is the external SSD
sudo wipefs -a /dev/sdX              # clears filesystem/partition-table signatures
sudo parted /dev/sdX mklabel gpt     # writes a fresh, empty GPT partition table
```

Either path leaves the SSD as blank, unpartitioned space ready to reuse for normal storage, or to reinstall onto later.

## Scenario C — Method 1 rollback: restoring Windows after a full-disk wipe

This is different from Scenarios A/B because **Windows itself is gone**, so you no longer have a Windows environment to run `diskpart` from. Three practical options, from simplest to most manual:

1. **GParted Live USB (simplest, GUI-based, hardest to get wrong).**
   - Download GParted Live (https://gparted.org/livecd.php) and flash it to a spare USB the same way you'd flash any distro ISO — with Rufus (GPT partition scheme, UEFI target, DD Image mode) or balenaEtcher.
   - Boot from it: power on, then press your machine's one-time boot-menu key (commonly F12, F11, F9, or Esc depending on the manufacturer) and select the GParted USB.
   - Select your internal disk in the top-right dropdown, verify by size, then **Device menu → Create Partition Table → gpt → Apply**.
   - This clears the Linux install completely, leaving a blank GPT disk. Then boot your Windows installer USB and install fresh.

2. **Boot a Windows installation USB and run `diskpart` from within the installer.**
   - Create a Windows install USB via Microsoft's official Media Creation Tool.
   - Boot from it, and at the first "Where do you want to install Windows?" screen, press **Shift + F10** to open a command prompt.
   - Run the same `diskpart` sequence as Scenario B (`list disk` → `select disk N` → `clean` → `convert gpt`) against the internal disk, then close the command prompt and continue the normal Windows setup flow, which will now see a clean disk to install onto.

3. **Boot the same Linux live USB (Omarchy/Arch) and clear the disk manually**, then boot the Windows installer separately:
   ```bash
   sudo wipefs -a /dev/nvme0n1
   sudo parted /dev/nvme0n1 mklabel gpt
   ```
   Reboot into the Windows installer USB afterward and install normally onto the now-empty disk.

All three end at the same place — a blank GPT internal disk ready for a fresh Windows install — pick whichever tool you're most comfortable navigating.

## Scenario D — Method 2 rollback: removing a dual-boot Linux install

1. Boot into Windows.
2. Open **Disk Management** → right-click each Linux partition (they'll show as "Unknown"/unformatted, sized to match what you gave Linux at install time) → **Delete Volume**, turning that space into Unallocated.
3. Right-click your Windows partition → **Extend Volume** → reclaim the newly-freed unallocated space back into Windows.
4. Repair the Windows boot manager, since it may still try to chain-load the now-deleted Linux bootloader. Open an **elevated Command Prompt** and run:
   ```
   bootrec /fixmbr
   bootrec /fixboot
   bootrec /rebuildbcd
   ```
   - `fixmbr` — rewrites the master boot record (relevant on legacy/MBR setups).
   - `fixboot` — rewrites the boot sector of the system partition.
   - `rebuildbcd` — rescans for Windows installations and rebuilds the Boot Configuration Data store, dropping stale entries.
5. If a stale Linux entry still shows in the Windows Boot Manager menu afterward, list and remove it directly:
   ```
   bcdedit /enum
   bcdedit /delete {the-stale-entry-id}
   ```

## References

- Microsoft Learn — `diskpart` command reference: https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/diskpart
- Microsoft Learn — `bootrec` command reference: https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/bcd-boot-recovery-in-windows-pe
- Microsoft Learn — `bcdedit` command reference: https://learn.microsoft.com/en-us/windows-hardware/drivers/devtest/bcdedit-command-line-options
- GParted Live: https://gparted.org/livecd.php
- Arch Wiki — `wipefs` / `parted` usage: https://wiki.archlinux.org/title/Parted
