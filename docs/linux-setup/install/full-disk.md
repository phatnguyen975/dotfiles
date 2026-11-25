# Full-Disk Installation

Replace the operating systems on one internal drive with Linux. This is the simplest layout, but it removes Windows, recovery partitions and personal files from the selected disk.

## 1. Prepare the Computer

Complete [Preparation](../common/preparation.md), including a verified backup and Windows recovery media. Disconnect non-target drives if safe and practical, and follow [Disk Identification](../common/disk-identification.md) to record the intended internal SSD.

## 2. Prepare and Boot the Installer

Create the [installation media](../common/installation-media.md), then follow [Firmware and Boot](../common/firmware-and-boot.md). Boot the installer USB in UEFI mode and confirm the target disk again.

## 3. Install Linux

For most guided installers, select the intended internal drive and the option to erase that drive and install Linux. Select the desired encryption and default filesystem layout according to the distribution's documentation.

**Omarchy:** follow the [Omarchy Installer](../omarchy/installer.md) with the full-disk installation option. Keep encryption enabled unless you have a justified reason to use an unencrypted system.

### Before You Confirm

Read this checklist before opening the installer workflow, and complete it at the final confirmation screen before accepting any write.

- [ ] The target is the intended internal disk, identified by model and capacity or serial.
- [ ] All partitions on that disk may be erased, including the original ESP and Windows recovery partitions.
- [ ] No installer, backup or unrelated data drive is selected for writing.
- [ ] The expected boot files and Linux system will reside on the target disk.

If the installer shows an unexpected disk or operation, cancel before committing. No separate disk wipe or manual partitioning is normally needed.

## 4. Verify the Result

1. When installation finishes, remove the installation media when instructed, then boot the installed system using the firmware menu if necessary.
2. Unlock the encrypted system if prompted, and sign in.
3. Confirm that Linux root and the boot partition are on the selected internal drive using [Post-Installation Checks](../common/post-install.md).
4. Restart once more with the installer USB absent, and confirm normal boot without manual intervention.

A stale Windows firmware entry may remain even after its files have been removed. Its presence is not proof that Windows is still installed, and it does not need to be deleted if Linux boots normally.

## 5. Continue Setup

Complete [Post-Installation Checks](../common/post-install.md). For Omarchy, proceed to [Desktop Usage](../omarchy/desktop.md) and optionally [Vietnamese Input](../omarchy/vietnamese-input.md).

To return to Windows later, restore a verified Windows system image or follow [Windows Reinstallation](../recovery/windows-reinstall.md). A Linux snapshot cannot recover Windows partitions erased during installation.

## References

- [Omarchy: Getting Started](https://omarchy.org/manual/getting-started/)
- [ArchWiki: Installation Guide](https://wiki.archlinux.org/title/Installation_guide)
- [Microsoft: Recovery Options](https://support.microsoft.com/en-us/windows/experience/backup-recovery/recovery-options-in-windows)
