# External SSD Installation

Install a complete Linux system onto a separate SSD while retaining Windows on the internal drive. The goal is for the external disk to carry its own Linux system and boot files, so either drive can boot independently.

This is not a persistent live USB. It is a normal installation on removable storage, and it is not guaranteed to boot on every other computer.

## 1. Choose a Storage Layout

| Layout                | Use Case                                      | Installation Mode |
| --------------------- | --------------------------------------------- | ----------------- |
| Linux-only SSD        | Entire external SSD for Linux                 | Full disk         |
| Linux and shared data | Separate data partition accessible in Windows | Free space        |

The Linux-only layout is the recommended baseline. The second layout needs advance partition planning and an installer that supports installing into unallocated space.

## 2. Prepare the Computer and SSD

Complete [Preparation](../common/preparation.md) for both Windows and the external SSD, then [Disk Identification](../common/disk-identification.md). Use a reliable enclosure, cable and direct USB port; do not install to the USB flash drive carrying the ISO.

For the shared-data layout, use [Shared Storage](../common/shared-storage.md#reserve-space-before-installation) to create the data volume on the external SSD before Linux installation. Leave the remaining region unallocated.

### Isolate the Windows Disk

For the strongest isolation, have the internal disk disconnected or disabled using a documented, supported procedure if your hardware permits it. Do not open a laptop or change storage modes solely for this step if you are not qualified to do so; seek assistance or leave the disk connected and verify the installer plan carefully.

When the internal disk remains visible, an incorrect disk selection or bootloader placement can affect it. Firmware boot entries may change even when the Windows partitions are not modified.

## 3. Prepare and Boot the Installer

Create the [installation media](../common/installation-media.md) with the external SSD disconnected to avoid flashing it by mistake. Then shut down, attach the SSD and installer USB, and follow [Firmware and Boot](../common/firmware-and-boot.md).

Identify all visible disks again. Two removable devices can share the same transport type and similar capacities, so use the model, serial and recorded layout to distinguish them.

## 4. Install to the External SSD

Choose the external SSD as the installation target, not the Windows disk. For a Linux-only SSD, use the full-disk option; for a prepared shared-data layout, select the unallocated region and retain the data partition.

**Omarchy:** use the [Omarchy Installer](../omarchy/installer.md) and choose the corresponding full-disk or free-space mode. The free-space feature is documented upstream, but the shared-data layout on external USB storage is an application of that feature, not a separate hardware-tested Omarchy procedure. Older releases had [reported issues with non-OS partitions](https://github.com/omacom/omarchy/issues/7515); if free-space mode fails on your SSD, stop and prefer the Linux-only layout plus a separate data drive.

### Before You Confirm

Read this checklist before opening the installer workflow, and complete it at the final confirmation screen before accepting any write.

- [ ] The selected disk is the external target, not the installer USB or internal SSD.
- [ ] The mode matches the intended external layout.
- [ ] The Linux root and its EFI boot files will reside on the external SSD; no internal ESP is selected for writing.
- [ ] Any pre-created shared-data partition will remain intact if using free-space mode.

If the installer cannot guarantee the intended boot-file placement, stop and use a supported isolation or manual installation procedure for your distribution. Do not approve a configuration that uses the internal ESP as the external system's only boot path.

## 5. Verify Independent Booting

1. Finish installation and remove only the installer USB when prompted. Keep the external SSD connected.
2. Boot Linux from the external drive using the one-time firmware menu. If the internal disk was isolated, first verify this boot while it is still isolated, then fully shut down before restoring the internal disk through the same supported procedure.
3. In Linux, inspect the root and ESP with [Post-Installation Checks](../common/post-install.md). Both must trace back to the external disk; inspect firmware entries with `sudo efibootmgr -v` if available.
4. Fully shut down Linux and disconnect the external SSD. Boot Windows from its own firmware entry, check personal files and encryption status, then shut down Windows.
5. Reconnect the external SSD and boot Linux again. Confirm that both systems remain independently accessible without the installer USB.

Booting Windows successfully without the external drive is a functional independence test, not a forensic guarantee that no internal disk metadata changed. If Linux requires the internal ESP, resolve that dependency before treating the external SSD as independently bootable.

## 6. Choose Daily Boot Behavior

| Strategy                     | Behavior                                                   | When to Use          |
| ---------------------------- | ---------------------------------------------------------- | -------------------- |
| Windows first, one-time menu | Select external SSD only when needed                       | Recommended baseline |
| External SSD first           | Linux preferred when detected                              | Frequent Linux use   |
| Common Linux boot menu       | Choose Windows or Linux once the external bootloader loads | Optional convenience |

External-first boot order may fall back to Windows when the SSD is absent, but firmware behavior varies. Verify both connected and disconnected startup scenarios rather than assuming automatic fallback.

For Omarchy, a common menu can be configured using [Limine Boot Selection](../omarchy/installer.md#configure-boot-selection). This does not remove the need for an independent Windows firmware entry.

Never unplug the external SSD while Linux is running, suspended or hibernating. Fully shut down before disconnecting it; ensure shared files are saved and unmounted before changing systems.

## 7. Continue Setup

Complete [Post-Installation Checks](../common/post-install.md). If you chose a data partition, test it using [Shared Storage](../common/shared-storage.md#verify-access-from-linux).

For Omarchy, continue with [Desktop Usage](../omarchy/desktop.md) and optionally [Vietnamese Input](../omarchy/vietnamese-input.md). To retire the external installation, see [Recovery and Cleanup](../recovery/README.md).

## References

- [Omarchy: Getting Started](https://omarchy.org/manual/getting-started/)
- [Omarchy: Dual Boot Install](https://omarchy.org/manual/dual-boot-install/)
- [ArchWiki: Install Arch Linux on a Removable Medium](https://wiki.archlinux.org/title/Install_Arch_Linux_on_a_removable_medium)
- [ArchWiki: UEFI](https://wiki.archlinux.org/title/Unified_Extensible_Firmware_Interface)
