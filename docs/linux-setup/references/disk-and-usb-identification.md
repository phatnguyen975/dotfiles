# Disk & USB Identification

**Read this file first, before any method.** Almost every serious mistake — wiping the wrong drive, installing over the wrong disk — happens because someone picked the wrong disk number or name. This file explains how disks are named on Windows and Linux, and gives a simple checklist to make sure you pick the right one every time.

## 1. How Windows names disks

- **Disk Management** (`diskmgmt.msc`) and **`diskpart`** call physical disks **"Disk 0", "Disk 1", "Disk 2", etc.** Windows assigns these numbers each time it starts up or detects a new device. **The same disk can get a different number next time** — never assume "Disk 1 was the USB last time, so it's still Disk 1".
- Partitions get **drive letters** (`C:`, `D:`, `E:`, etc.). But a fresh Linux install USB often has **no drive letter** and shows as "RAW" or "Healthy (Unknown Partition)" — this is normal, not an error.
- To list every disk in `diskpart`:
  ```
  list disk
  ```
  This shows each disk's number, **size**, and whether it uses **GPT** (a `*` under the `Gpt` column) or the older MBR (no `*`).
- To see more detail about one disk — its model name, and whether it's a removable USB drive:
  ```
  select disk N
  detail disk
  ```

## 2. How Linux names disks

- **NVMe drives** (most modern internal laptop SSDs — this is the Gigabyte A16's internal drive): named `/dev/nvme0n1`, `/dev/nvme1n1`, etc. Partitions add a `p`: `/dev/nvme0n1p1`, `/dev/nvme0n1p2`, etc.
- **USB or SATA drives** (most external SSDs in a USB enclosure, and all normal USB flash drives): named `/dev/sda`, `/dev/sdb`, etc. Partitions: `/dev/sda1`, `/dev/sda2`, etc.
- Just like Windows disk numbers, **the letter can change between boots** (`sda` might become `sdb` next time, depending on what's plugged in and detected first). **Never trust a name from memory — always check again with `lsblk` right before you run a command.**
- The one command to know, in any Linux live environment (including the Omarchy installer):
  ```bash
  lsblk -o NAME,SIZE,MODEL,TRAN,FSTYPE,MOUNTPOINT
  ```
  This prints every disk with its **size**, **model name**, **connection type** (`TRAN` column: `usb`, `nvme`, `sata`), filesystem, and mount point — everything you need to tell disks apart.
- For a name that never changes between boots, use:
  ```bash
  ls -l /dev/disk/by-id/
  ```
  Each USB or NVMe drive shows up here with its model and serial number built into the name (for example `usb-Kingston_DataTraveler_...`). This is the most reliable way to double-check you have the right physical drive.

## 3. Confirm a disk before touching it

Before running any command that can erase data (`clean` in `diskpart`, or choosing a target disk in an installer), check **at least two** of these four things:

| #   | Check                   | How                                                                                                                                                                                            |
| --- | ----------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1   | **Size**                | The fastest check. A 500 GB internal drive, a 1 TB external SSD, and a 16 GB USB stick almost never share the same size — use size as your first filter every time.                            |
| 2   | **Model name**          | `detail disk` in `diskpart`, or `lsblk -o NAME,MODEL`, `/dev/disk/by-id/` on Linux.                                                                                                            |
| 3   | **Connection type**     | `nvme` = built into the laptop (internal). `usb` = plugged in (your external SSD or your install USB). This one check alone stops you from ever wiping the internal drive by mistake.          |
| 4   | **Unplug and re-check** | Unplug the device you think you found, run `list disk` / `lsblk` again, and confirm that entry disappears. Plug it back in and check again — don't assume it gets the same number/letter back. |

## 4. GPT vs. MBR

- A modern UEFI Linux install (Omarchy included) needs the disk to use **GPT**, not the older MBR layout.
- Windows: `diskpart` → `list disk` → check for `*` under the `Gpt` column.
- Linux: `lsblk -o NAME,PTTYPE`, or `sudo fdisk -l /dev/sdX` (the top line says `Disklabel type: gpt` or `dos` for MBR).

## Worked example: Gigabyte A16, with a USB installer connected

At minimum, you'll have two storage devices connected during any install: the laptop's own internal drive, and your USB install stick. Here is what `lsblk -o NAME,SIZE,MODEL,TRAN` typically shows in the Omarchy live environment (sizes and model names are examples — yours will differ):

```
NAME        SIZE  MODEL                TRAN
nvme0n1   476.9G  <internal SSD model> nvme
sdb        14.9G  Ultra_USB_3.0        usb
```

- **`nvme0n1`** — the laptop's **internal drive** (`TRAN` = `nvme`).
- **`sdb`** (~15 GB, roughly "16 GB") — the **install USB stick itself** (in this example, a SanDisk drive) — never install _onto_ this one.

If you're also connecting an extra target drive (for example, a separate external drive you intend to install onto, kept apart from the internal drive), it will show up as another `usb`-transport device alongside the install USB — for example `sda`. Since it's a different physical device than the install USB, distinguish the two the same way as any other pair of disks: by **size** first (a target drive is usually a very different size from a small install USB), then by model name if needed.

In practice, size alone usually settles it — the internal drive, any external drive, and the install USB are rarely the same size. Cross-check size against the `TRAN` column (`nvme` vs `usb`) before selecting any disk in an installer or in `diskpart`.

## References

- Microsoft Learn — `diskpart` command reference: https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/diskpart
- Microsoft Learn — `list disk` / `detail disk`: https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/list-disk
- Arch Wiki — Device file naming conventions: https://wiki.archlinux.org/title/Device_file
- `lsblk(8)` man page: https://man7.org/linux/man-pages/man8/lsblk.8.html
