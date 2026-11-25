# Identify Disks and Partitions

Disk numbers and Linux device names can change across boots or when hardware is connected. Never select a target based on a name, capacity or connection type alone.

## Inspect Disks in Windows

Open PowerShell as administrator and run these read-only commands:

```powershell
Get-Disk | Format-Table Number,FriendlyName,SerialNumber,BusType,Size,PartitionStyle
Get-Partition | Format-Table DiskNumber,PartitionNumber,DriveLetter,Type,Size
Get-Partition -DriveLetter C | Get-Disk
```

Open Disk Management (`diskmgmt.msc`) and compare the graphical layout with the output. Save a record of which partitions belong to Windows, including EFI System Partition (ESP), Microsoft Reserved (MSR), recovery and data partitions.

To identify removable media, compare the list before and after connecting each device separately. Disk numbers are local to Windows, not Linux device names.

### DiskPart (Alternative)

Open Command Prompt as administrator, start DiskPart and list the available disks and volumes:

```text
diskpart
list disk
list volume
```

Use the current disk number from the output, replacing `<N>` with that number. Run the following commands inside DiskPart:

```text
select disk <N>
detail disk
list partition
```

Compare the model, capacity, location information (when available) and partition layout with your storage record. `list volume` lists volumes across all disks, whereas `list partition` lists partitions on the selected disk; the GPT column in `list disk` indicates whether a disk uses GPT.

These inspection commands do not modify disk contents; `select disk` only changes the active selection. DiskPart does not reliably expose every hardware identifier, so use PowerShell or the device connection check above if identification remains uncertain.

```text
exit
```

## Inspect Disks in Linux

From a terminal in the live environment, if available, or a separately booted Linux live system, run:

```bash
lsblk -o NAME,PATH,TYPE,SIZE,MODEL,SERIAL,TRAN,PTTYPE,FSTYPE,PARTLABEL,MOUNTPOINTS
lsblk -f
```

These commands display storage without modifying it. If the installer offers no shell, use its displayed model and capacity together with your recorded information; stop if you cannot uniquely identify the target.

| Example Name      | Meaning                                     |
| ----------------- | ------------------------------------------- |
| `/dev/nvme0n1`    | Entire NVMe namespace                       |
| `/dev/nvme0n1p1`  | Partition 1 on that namespace               |
| `/dev/sda`        | Entire disk, often SATA or USB              |
| `/dev/sda1`       | Partition 1 on that disk                    |
| `/dev/mapper/...` | Mapped device, possibly unlocked encryption |

These are examples only. A USB enclosure may hide the SSD's serial number, and USB4/Thunderbolt storage may not report `usb` as its transport.

## Record the Storage Roles

| Role                  | Example Capacity | Example Linux Name |
| --------------------- | ---------------- | ------------------ |
| Windows internal SSD  | 512 GB           | `/dev/nvme0n1`     |
| Installer flash drive | 16 GB            | `/dev/sdb`         |
| External Linux target | 1 TB             | `/dev/sda`         |

For each actual device, record its model, serial if available, capacity and current partition layout. Decimal GB and binary GiB values differ, so a marketed 512 GB drive may appear near 477 GiB.

GPT is the expected partition table in this guide. The ESP is normally FAT-formatted and contains boot files; it is not ordinary shared storage.

## Confirm Before Every Write

Before flashing an image, shrinking a volume, formatting a partition or approving installation:

1. Match the selected physical device against your record using at least two independent identifiers; use the serial when available.
2. Confirm whether the operation targets an entire disk or only one partition.
3. Confirm which existing partitions will be retained and which will be created or erased.
4. Stop if the target is ambiguous, missing or different from the expected layout.

Do not run example device paths as commands. Recheck after every reboot or change to attached devices.

## References

- [Microsoft: DiskPart](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/diskpart)
- [Microsoft: Get-Disk](https://learn.microsoft.com/en-us/powershell/module/storage/get-disk)
- [Microsoft: Disk Management](https://learn.microsoft.com/en-us/windows-server/storage/disk-management/overview-of-disk-management)
- [Linux Manual: lsblk](https://man7.org/linux/man-pages/man8/lsblk.8.html)
- [ArchWiki: Device File](https://wiki.archlinux.org/title/Device_file)
