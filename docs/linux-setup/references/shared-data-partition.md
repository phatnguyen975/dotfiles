# Shared Data Partition (Windows + Linux, no permission headaches)

How to set up a partition that both Windows and Omarchy can read and write to normally, without extra permission mapping. Relevant any time you want a dedicated data area separate from your Linux root partition, alongside Windows.

## 1. Filesystem choice

A quick reminder of what each filesystem is normally used for, before picking one:

- **NTFS** is Windows' own native filesystem (used for the Windows `C:` drive itself) — best when Windows needs full native permissions/features on the data.
- **exFAT** was designed by Microsoft specifically as a lightweight, cross-platform filesystem for removable/external drives (its most common real-world use: SD cards, USB drives, external SSDs meant to move between different operating systems) — this is exactly our use case.
- **FAT32** (mentioned for comparison) is the oldest and most universally compatible, but limited to single files under 4 GB — usually only chosen today for small boot/EFI partitions or very old hardware, not for a general data partition.

| Filesystem              | Windows           | Linux                                                                                  | Notes                                                                                                       |
| ----------------------- | ----------------- | -------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- |
| **exFAT** (recommended) | Native read/write | Native read/write (via `exfatprogs`, standard on Arch-based systems including Omarchy) | No journaling, no Unix permissions/ownership to fight with — simplest option for a shared area              |
| **NTFS**                | Native read/write | Read/write via the in-kernel `ntfs3` driver (mainline since Linux 5.15+) or `ntfs-3g`  | Keeps Windows-native permissions/ACLs; slightly more moving parts on the Linux side, but fully usable today |

**Recommendation: exFAT.** It's the filesystem exFAT was actually built for (cross-platform external storage), needs no extra permission mapping on the Linux side, and — unlike old FAT32 — has no 4 GB single-file limit. Choose NTFS instead only if you specifically need Windows-native permissions/ACLs on the shared files (for example, a Windows program that checks NTFS-specific file attributes).

## 2. Windows-side setup

1. Open **Disk Management** (`diskmgmt.msc`).
2. Right-click the target unallocated space (or an existing partition you're repurposing) → **New Simple Volume**.
3. Choose a size, then format as **exFAT** (pick an allocation unit size — default is fine for general use).
4. Assign a drive letter.

## 3. Linux-side mount (fstab, permission-free access)

1. Make sure the exFAT driver tools are installed (on Omarchy/Arch-based systems, `exfatprogs` is typically already available or a one-line `pacman -S exfatprogs` install away).
2. Identify the partition and its UUID:
   ```bash
   lsblk -f
   ```
   Note the UUID next to the shared partition.
3. Create a mount point:
   ```bash
   sudo mkdir -p /mnt/shared
   ```
4. Add an entry to `/etc/fstab` (edit as root):
   ```
   UUID=XXXX-XXXX  /mnt/shared  exfat  defaults,uid=1000,gid=1000,umask=000  0  2
   ```
   - `uid=1000,gid=1000` — replace with your own user's UID/GID (check with `id`) so files show up owned by you instead of root.
   - `umask=000` — gives full read/write/execute to everyone; use `umask=022` instead if you want to keep it read-only for other local users while staying fully read/write for your own account.
5. Test without rebooting:
   ```bash
   sudo mount -a
   ```
   If no errors, the partition is mounted at `/mnt/shared` and will auto-mount on every future boot.

## Worked example (Gigabyte A16, Omarchy)

When installing onto free space rather than a whole disk (leaving room for a data partition alongside Linux), Omarchy's own installer only needs to know about its own root/ESP partitions during setup. The extra shared partition is created either:

- **Before** running the Omarchy installer, using a partitioning tool from the live environment (`cfdisk /dev/sdX` or `gparted`) to carve out the space you want to reserve, leaving the rest for Omarchy's own partitioner to use, or
- **After** the Omarchy install finishes, using whatever free space is left on the disk.

Either way, the shared partition ends up as (for example) `/dev/sdX3`, formatted exFAT, and mounted via the fstab entry above — accessible from Omarchy (via `/mnt/shared`) and from Windows (via its assigned drive letter).

## References

- Arch Wiki — exFAT: https://wiki.archlinux.org/title/Exfat
- Arch Wiki — NTFS: https://wiki.archlinux.org/title/NTFS
- Linux kernel `ntfs3` driver documentation: https://www.kernel.org/doc/html/latest/filesystems/ntfs3.html
- `fstab(5)` man page: https://man7.org/linux/man-pages/man5/fstab.5.html
