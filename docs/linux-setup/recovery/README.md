# Recovery and Cleanup

Use the procedure matching your installation method. Start with non-destructive diagnostics; do not delete partitions or boot entries to troubleshoot a system that has not yet been recovered.

## If a System Will Not Boot

1. Shut down, remove unneeded removable media, and select the intended boot entry in the one-time firmware menu. On an external Linux installation, check the SSD connection and use a direct port.
2. If Windows asks for a BitLocker recovery key, use the saved matching key or follow [Microsoft's recovery-key guide](https://support.microsoft.com/en-us/windows/security/encryption/find-your-bitlocker-recovery-key). Do not clear TPM or erase the disk to bypass the prompt.
3. If Windows cannot boot, start the Windows installation or recovery USB in UEFI mode and select the repair option, not the clean installation option. Open **Troubleshoot > Advanced options > Startup Repair**.
4. If Linux cannot boot, use its official recovery procedure and installation media. Inspect the partition layout without formatting or reinstalling first.

For advanced Windows UEFI boot repair, Microsoft's [BCDBoot documentation](https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/bcdboot-command-line-options-techref-di?view=windows-11) explains how to recreate boot files. Windows drive letters may differ in recovery mode, and selecting the wrong ESP can break an independent dual-boot layout; obtain assistance if the correct Windows directory and ESP cannot be established.

Legacy MBR repair commands are not a general UEFI/GPT recovery procedure. Do not run `bootrec /fixmbr` or `bootrec /fixboot` as a routine cleanup step.

## Recover an Omarchy Update

Omarchy creates system snapshots before updates. If a recent update breaks the system, select Limine from the firmware menu if necessary, then choose a snapshot from before the update.

After booting the snapshot, test the affected functionality and follow the restoration notification, or use the documented command:

```bash
omarchy-snapshot restore
```

Restoring a snapshot changes the root filesystem, not `/home`. User configuration and recorded migration state can remain newer than the restored system; review the [snapshot guide](https://omarchy.org/manual/system-snapshots/) before updating again.

If the installed desktop still works, a manual system snapshot can be created with `omarchy-snapshot create`. Neither type of snapshot replaces an independent file or disk-image backup.

## Reverse a Full-Disk Installation

A full-disk installation removed the previous Windows layout from that drive. To return to Windows, restore the verified system image or follow [Windows Reinstallation](windows-reinstall.md); do not expect a Linux system snapshot to restore Windows.

## Remove a Same-Disk Linux Installation

This operation permanently removes Linux and its data. Back up Linux files and confirm that Windows boots independently before removing any partition.

1. Select Windows Boot Manager in the firmware's one-time menu. If Windows cannot boot independently, repair that first.
2. Set Windows Boot Manager first in firmware boot order and verify a restart into Windows with no Linux media connected.
3. Open Disk Management and compare the original Windows partition record with the record made after Linux installation. Use Linux UUIDs, partition numbers, sizes and start locations when identifying any Linux-only partitions.
4. Delete only partitions positively identified as belonging exclusively to Linux. Preserve the Windows ESP, MSR, recovery, OEM and shared-data partitions; if an ESP is shared or its purpose is uncertain, leave it alone.
5. Extend the Windows NTFS volume only when the new unallocated space is contiguous immediately to its right on the same disk. If **Extend Volume** is unavailable, leave the space unallocated or use it as a separate volume rather than moving recovery partitions blindly.

Windows Disk Management may refuse to remove some protected or unfamiliar partition types. Do not force deletion using a generic partition number or override command; use a trusted partitioning specialist or a supported procedure after identifying the exact Linux-only partition.

A stale Linux firmware entry is usually harmless once Windows is first in boot order. Only remove it using the firmware's supported entry-management controls if its identity is clear.

Finally, restore any firmware settings that are no longer needed for Linux, following BitLocker precautions if applicable. Confirm Windows boots, review Windows security settings and verify the recovered storage capacity.

## Retire an External SSD Installation

1. Fully shut down Linux and disconnect the external SSD.
2. Boot Windows directly and verify it works independently. Restore Windows-first boot order if necessary.
3. If you wish to keep the external Linux installation, store it disconnected; no partition cleanup is needed.
4. If you wish to reuse the SSD for ordinary storage, first back up its contents and use the cleanup procedure below.

Restore firmware settings only after deciding whether you still need to boot Omarchy. Re-enabling Secure Boot may prevent Omarchy from starting under the configuration used in this guide.

## Reuse Installation Media or a Linux-Only Disk

Use this procedure only for a dedicated device whose entire contents may be lost. It does not apply to an external SSD where a shared-data partition must survive.

### Disk Management (Default)

1. Back up the device and disconnect all other unnecessary removable storage.
2. In Windows, use [Disk Identification](../common/disk-identification.md) to identify the device and open Disk Management.
3. Delete the old partitions only on that device if the tool allows it, then create a new simple volume using the desired filesystem. Choose GPT when initializing an SSD for this guide's UEFI PCs.
4. Confirm the new volume appears with the expected capacity, then test reading and writing a small file.

Some boot-media layouts contain protected partitions that Disk Management cannot delete. Rufus offers a non-bootable formatting option for supported devices, or use the DiskPart alternative below.

### DiskPart (Alternative)

**Warning:** This procedure removes all existing partitions and data access on the selected device, including protected boot partitions. Never use it to remove only Linux from a dual-boot disk or to preserve a shared-data partition.

Back up the device, disconnect unrelated removable storage and open Command Prompt as administrator. Start DiskPart and identify the device:

```text
diskpart
list disk
```

Replace `<N>` with the current disk number of the device to reuse:

```text
select disk <N>
detail disk
list partition
```

Follow [Confirm Before Every Write](../common/disk-identification.md#confirm-before-every-write). Confirm that no operating system, backup or shared data on the selected device needs to survive.

Run the following command separately:

```text
clean
```

After a successful reset, run `list partition` and confirm that no partitions remain. For the modern UEFI computers covered by this guide, create a GPT layout and a single data partition:

```text
convert gpt
create partition primary
```

Choose one filesystem before formatting. Use exFAT for general Windows, Linux and macOS file exchange where supported, or NTFS for primarily Windows storage.

For exFAT:

```text
format fs=exfat quick label=DATA
```

For NTFS instead:

```text
format fs=ntfs quick label=DATA
```

Assign an available drive letter and verify the layout:

```text
assign
list partition
list volume
exit
```

In Disk Management, confirm that the correct device has the expected data volume and capacity (allowing for partitioning and filesystem overhead). Open it in File Explorer, create and read a small test file, then safely eject and reconnect it to confirm access.

If any command fails, stop and inspect the error before continuing. `clean` and quick formatting are not secure data sanitization; `clean all` is unnecessary for ordinary storage reuse.

Do not clear Windows boot files or change unrelated firmware entries when simply reusing a flash drive.

## References

- [Microsoft: Recovery Options](https://support.microsoft.com/en-us/windows/experience/backup-recovery/recovery-options-in-windows)
- [Microsoft: BCDBoot](https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/bcdboot-command-line-options-techref-di?view=windows-11)
- [Microsoft: Extend a Volume](https://learn.microsoft.com/en-us/windows-server/storage/disk-management/extend-a-basic-volume?tabs=disk-management)
- [Omarchy: System Snapshots](https://omarchy.org/manual/system-snapshots/)
- [Microsoft: DiskPart](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/diskpart)
- [Microsoft: Change Disk Partition Style](https://learn.microsoft.com/en-us/windows-server/storage/disk-management/change-disk-partition-scheme?tabs=diskpart)
- [Rufus](https://rufus.ie/)
