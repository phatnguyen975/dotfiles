# Reinstall Windows 11

Use this guide after a full-disk Linux installation if you want to replace Linux with Windows. A clean Windows installation erases the selected target; if you need the original Windows applications and data, restore your verified system image instead.

## 1. Prepare Recovery Media

- Back up Linux files and any other data on the target disk.
- Record the Windows edition previously licensed on the computer, and locate the product key or digital-license information if applicable.
- Obtain Windows storage and network drivers for the exact machine model from its vendor if Windows Setup may require them.
- On a working Windows computer, use Microsoft's [Media Creation Tool](https://www.microsoft.com/software-download/windows11) to create a dedicated Windows installation USB. Use an empty USB of at least 8 GB and verify its identity before writing.

If no working Windows computer is available, Microsoft's ISO is also available from its download page. Follow a supported media-creation procedure or ask someone with a working Windows PC to prepare the media.

## 2. Restore Compatible Firmware Settings

Follow [Firmware and Boot](../common/firmware-and-boot.md) to enter UEFI setup. Restore the original supported Windows configuration, including TPM and Secure Boot settings if previously enabled, without clearing TPM or changing storage modes speculatively.

Check the official Windows 11 hardware requirements. Do not use requirement bypasses as part of this installation guide.

## 3. Install Windows

1. Disconnect unrelated drives where safely possible, connect the Windows USB and boot its UEFI entry from the one-time firmware menu.
2. Start Windows Setup and follow the clean-installation procedure in [Microsoft's reinstall guide](https://support.microsoft.com/en-us/windows/deployment/install-upgrade/reinstall-windows-with-the-installation-media).
3. Select the correct Windows edition if prompted. On a device with an applicable digital license, the product-key prompt may be skipped; activation depends on the license and edition.
4. At the storage-selection screen, identify the intended Linux disk using the recorded disk model, capacity and partition layout. If the installer cannot uniquely identify it, stop and resolve the ambiguity.
5. For a complete replacement, delete partitions only on the confirmed target disk until it is unallocated. If Setup cannot remove the existing layout, use the [DiskPart fallback](#reset-the-target-with-diskpart-optional); select the unallocated space and allow Windows Setup to create the necessary layout.
6. Continue the installation and complete the initial setup using the network and account requirements displayed by your Windows edition.

No separate disk wipe is normally required before this procedure. If Windows Setup cannot see the drive, obtain the appropriate storage controller driver from the computer vendor rather than switching RST/VMD/RAID settings at random.

### Reset the Target With DiskPart (Optional)

Use this fallback only when Windows Setup cannot remove the existing partition layout or requires a GPT disk for the UEFI installation. It does not resolve a missing storage driver or a failing drive.

**Warning:** This is a full-disk reset. All partitions on the selected disk will be removed; do not use it for dual boot, a partial reinstall or a disk containing data that must survive.

In Windows Setup, press `Shift+F10` to open Command Prompt. Start DiskPart and list the disks:

```text
diskpart
list disk
```

Disk numbers and volume letters in Windows Setup may differ from those in your previous operating system. Replace `<N>` with the current disk number of the intended Windows installation target:

```text
select disk <N>
detail disk
list partition
```

Follow [Confirm Before Every Write](../common/disk-identification.md#confirm-before-every-write). Check the recorded model, capacity and layout, and confirm the selected disk is not the installer USB or any disk to preserve.

Run the following command separately:

```text
clean
```

After a successful reset, run `list partition` to confirm that no partitions remain. Prepare the empty disk for the UEFI installation:

```text
convert gpt
list disk
list partition
exit
```

Confirm that the GPT column shows an asterisk for the intended disk and that there are no partitions on it. If a command fails, stop and resolve the error rather than continuing with a partially completed reset.

Close Command Prompt and refresh the storage-selection screen if needed. Confirm that the target is shown as unallocated space, then continue with Step 5 above; do not create or format Windows partitions manually.

## 4. Verify Windows

- [ ] Windows starts with the installer USB removed.
- [ ] **Settings > System > Activation** shows the expected activation status.
- [ ] Windows Update and necessary model-specific drivers are installed.
- [ ] Disk Management shows the intended Windows layout.
- [ ] Secure Boot, TPM and Device Encryption/BitLocker are configured as intended.
- [ ] Restored personal data is accessible and a fresh backup has been created.

If the Windows installation is not bootable, follow the non-destructive repair steps in [Recovery and Cleanup](README.md).

## References

- [Microsoft: Download Windows 11](https://www.microsoft.com/software-download/windows11)
- [Microsoft: Create Installation Media](https://support.microsoft.com/en-gb/windows/deployment/install-upgrade/create-installation-media-for-windows)
- [Microsoft: Reinstall Windows With Installation Media](https://support.microsoft.com/en-us/windows/deployment/install-upgrade/reinstall-windows-with-the-installation-media)
- [Microsoft: Windows Setup and GPT Partition Style](https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/windows-setup-installing-using-the-mbr-or-gpt-partition-style?view=windows-11)
- [Microsoft: Windows 11 Specifications](https://www.microsoft.com/windows/windows-11-specifications)
