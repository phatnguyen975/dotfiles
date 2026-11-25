# Share Storage Between Windows and Linux

A dedicated data partition is useful when both operating systems need access to the same documents or media. Keep it separate from the Windows system volume, Linux root and EFI System Partitions.

## Choose a Filesystem

| Filesystem | Compatibility                                          | Trade-Off                                                        |
| ---------- | ------------------------------------------------------ | ---------------------------------------------------------------- |
| exFAT      | Read/write on modern Windows and Linux                 | No journaling or native Unix permissions                         |
| NTFS       | Windows native; Linux read/write with supported driver | More care needed around Windows hibernation and filesystem state |
| FAT32      | Broad compatibility                                    | Individual files limited to less than 4 GiB                      |

Use exFAT for ordinary cross-platform file exchange, not for Linux home directories, executable project environments or workloads requiring POSIX permissions and symbolic links. Use NTFS when Windows-specific features matter and the Linux distribution supports your access requirements.

An unencrypted shared partition is readable by anyone with physical access to the drive. Linux root encryption does not protect that partition.

## Reserve Space Before Installation

Do this only for the optional shared-data layout. For an existing installation with no unallocated space, prefer another drive instead of resizing the encrypted Linux filesystem.

### On a Shared Internal Disk

1. In Windows, use the unallocated space created in step 2 of [Same-Disk Dual Boot](../install/dual-boot.md). Plan the initial shrink to cover the combined desired Linux and shared-data capacity; do not shrink twice if sufficient space already exists.
2. Open Disk Management, right-click the verified unallocated region, and choose **New Simple Volume**.
3. Specify only the shared-data capacity, not the entire region. Assign a drive letter and choose exFAT if the wizard offers it; otherwise create the volume using an offered format and reformat only that new volume to exFAT in File Explorer, if supported.
4. Label the volume, for example `SHARED`, and confirm that a single sufficiently large unallocated region remains for Linux.

### On an External SSD

1. While still in Windows, connect the external SSD and identify it using [Disk Identification](disk-identification.md).
2. If the SSD is empty and uninitialized, initialize only that disk as GPT in Disk Management. If it contains any data or partitions, back them up and resolve the layout before proceeding; do not delete existing partitions merely because they are unfamiliar.
3. Create the shared volume from unallocated space using the procedure above, leaving the rest unallocated for Linux. Verify its label, size and disk identity.

Return to the chosen installation method and use free-space installation, not full-disk mode. The new shared volume must be explicitly preserved in the proposed partition layout; if the installer does not support this, stop and use the Linux-only layout with separate shared storage instead.

## Verify Access From Linux

After installation, locate the new volume:

```bash
lsblk -f
```

Match its filesystem, label, capacity and physical disk to the Windows record. Open it from the Linux file manager if it supports mounting removable volumes; create a small test file, unmount safely, and verify the file in Windows.

The Linux kernel provides exFAT filesystem support on modern distributions. Formatting and checking tools are supplied by `exfatprogs` on Arch-based systems; install them through your distribution's package manager only if needed.

## Optional Persistent Mount

Use this only if you want a consistent mount path in Linux rather than mounting through the file manager. The following example applies to exFAT, a single local user and a systemd-based distribution.

First identify the actual filesystem UUID and numeric user/group IDs:

```bash
lsblk -f
id -u
id -g
sudo mkdir -p /mnt/shared
sudo cp -a /etc/fstab /etc/fstab.before-shared
sudoedit /etc/fstab
```

Add one line, replacing the UUID and IDs with the actual values. The example values are not universal.

```fstab
UUID=1234-ABCD /mnt/shared exfat rw,nofail,x-systemd.device-timeout=5s,uid=1000,gid=1000,fmask=0177,dmask=0077 0 0
```

The masks restrict access to the assigned user and avoid marking ordinary files executable. `nofail` allows startup to continue if the shared device is unavailable; the device timeout limits how long systemd waits for it.

If the volume was mounted by the file manager, unmount it there before testing this configuration. Then check and mount only the new entry:

```bash
sudo findmnt --verify --verbose
sudo systemctl daemon-reload
sudo mount /mnt/shared
findmnt --mountpoint /mnt/shared
```

If verification or mounting fails, correct the entry or remove it using `sudoedit /etc/fstab`, then reload systemd. Do not reboot with an unresolved configuration error.

Write a small test file as your normal user, check it in Windows after a full shutdown, and test the reverse direction. Do not write to `/mnt/shared` unless `findmnt --mountpoint /mnt/shared` confirms the intended volume is mounted; otherwise files may be written to the Linux root disk.

## Daily Use

Disable Windows Fast Startup as described in [Preparation](preparation.md), and fully shut down one system before accessing shared files from the other. Never force-mount an NTFS volume that Linux reports as hibernated or unsafe.

Save files and unmount removable data volumes before disconnecting them. Because exFAT lacks journaling, keep backups and avoid unexpected power loss during writes.

## References

- [Microsoft: Manage Basic Volumes](https://learn.microsoft.com/en-us/windows-server/storage/disk-management/manage-basic-volumes)
- [ArchWiki: exFAT](https://wiki.archlinux.org/title/ExFAT)
- [ArchWiki: NTFS](https://wiki.archlinux.org/title/NTFS)
- [ArchWiki: Dual Boot With Windows](https://wiki.archlinux.org/title/Dual_boot_with_Windows)
- [Linux Manual: fstab](https://man7.org/linux/man-pages/man5/fstab.5.html)
- [systemd.mount Manual](https://www.freedesktop.org/software/systemd/man/latest/systemd.mount.html)
