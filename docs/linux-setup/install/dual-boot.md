# Same-Disk Dual Boot

Keep Windows and install Linux in unallocated space on the same internal GPT disk. This method requires resizing an existing Windows volume and preserving its boot and recovery partitions.

## 1. Prepare and Check Encryption

Complete [Preparation](../common/preparation.md) and [Disk Identification](../common/disk-identification.md). Back up the entire Windows system if you need to restore it exactly, and record the original partition layout.

**Omarchy:** the official [dual-boot manual](https://omarchy.org/manual/dual-boot-install/) documents an incompatibility with BitLocker for its same-disk installation. Do not assume suspending protection is sufficient, or that this limitation applies to all distributions.

If the Windows volume is encrypted, choose a different method or distribution if you need to retain encryption. If you choose to decrypt on an authorized personal machine, use **Settings > Privacy & security > Device encryption** or **Control Panel > BitLocker Drive Encryption**, as appropriate for your Windows edition, and wait until `manage-bde -status` reports the relevant volume fully decrypted.

Decryption exposes Windows data at rest, and the upstream documentation does not establish that re-enabling BitLocker afterward is supported for this layout. Do not use this method where Windows encryption must remain enabled.

## 2. Allocate Space in Windows

1. Open Disk Management (`diskmgmt.msc`). Identify the correct Windows NTFS volume, usually `C:`, on the intended disk.
2. Right-click that volume, choose **Shrink Volume**, and review the maximum available shrink size. Allow enough room for both operating systems to grow.
3. Enter the desired amount in the dialog's MB field, then click **Shrink**. For example, 102400 MB in this dialog corresponds to approximately 100 GiB of space.
4. Confirm that the newly freed region is labeled **Unallocated** and leave it unformatted for Linux.

Do not delete or format the original ESP, MSR, Windows, OEM or recovery partitions. If Windows cannot shrink enough because of immovable files, do not force a resize with an unfamiliar third-party tool; reduce the requested size or choose the external SSD method.

### Optional Shared Data

If you want a separate cross-platform data volume, reserve it before installation as described in [Shared Storage](../common/shared-storage.md). Do not expect the installer to leave a portion of its selected free region unused.

## 3. Boot the Installer

Create the [installation media](../common/installation-media.md), then follow [Firmware and Boot](../common/firmware-and-boot.md). Boot in UEFI mode, match the target disk to your saved Windows layout, and confirm that the expected unallocated region is available.

## 4. Install Into Unallocated Space

For another distribution, use its supported alongside-Windows or manual partitioning procedure. If it reuses the Windows ESP, make sure formatting of that partition is explicitly disabled; bootloader and ESP requirements vary by distribution.

**Omarchy:** follow the [Omarchy Installer](../omarchy/installer.md), selecting the internal SSD and **Free space install**. The reserved space must cover the Linux installation and its boot partition; encryption is enabled by default.

### Before You Confirm

Read this checklist before opening the installer workflow, and complete it at the final confirmation screen before accepting any write.

- [ ] The target disk matches the Windows disk in your records.
- [ ] The selected mode is free-space installation, not whole-disk erase.
- [ ] Only the intended unallocated region will receive new Linux partitions.
- [ ] All pre-existing Windows, recovery and data partitions will be preserved without formatting.

If there is more than one eligible free region and the installer cannot clearly identify the intended one, cancel rather than guessing. If free-space mode is missing, do not continue in full-disk mode.

## 5. Configure Boot Selection

Remove the installer USB when instructed and boot Linux. Test the original Windows Boot Manager from the firmware's one-time menu before setting a preferred boot order.

**Omarchy:** Limine is the boot manager used by the normal installation. To optionally add Windows to Limine, follow [Configure Boot Selection](../omarchy/installer.md#configure-boot-selection); firmware boot selection is also a valid alternative.

For a different distribution, use its documented boot manager integration rather than running an Omarchy command. Do not replace Windows boot files just to add a menu entry.

## 6. Verify Both Operating Systems

1. In Linux, confirm root and the boot files are in the expected layout using [Post-Installation Checks](../common/post-install.md). Record new partition numbers, UUIDs and sizes for future recovery.
2. Restart into Windows using its firmware entry. Verify the login, personal files, Disk Management layout and encryption status.
3. Fully shut down Windows, then boot Linux again. If you configured a common boot menu, test both entries from it as well.
4. Confirm the intended default boot behavior with the installer USB removed.

If Windows fails to boot, stop before attempting any further partition changes and follow [Recovery and Cleanup](../recovery/README.md).

## 7. Continue Setup

Complete [Post-Installation Checks](../common/post-install.md), then optionally set up [Shared Storage](../common/shared-storage.md). Omarchy users can continue with [Desktop Usage](../omarchy/desktop.md) and [Vietnamese Input](../omarchy/vietnamese-input.md).

If you later want to remove Linux, use the same-disk procedure in [Recovery and Cleanup](../recovery/README.md).

## References

- [Omarchy: Dual Boot Install](https://omarchy.org/manual/dual-boot-install/)
- [Microsoft: Shrink a Basic Volume](https://learn.microsoft.com/windows-server/storage/disk-management/shrink-a-basic-volume)
- [ArchWiki: Dual Boot With Windows](https://wiki.archlinux.org/title/Dual_boot_with_Windows)
