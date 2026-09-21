# Windows Partition Shrink & Boot Menu Behavior (Dual Boot Method)

Expands on Steps 3 and 8 of [README.md](../README.md): how to free up space on the same disk as Windows, and what actually happens at the boot menu once both OSes share that disk.

## 1. Shrinking the Windows partition (detailed)

1. Open **Disk Management**: press **Win**, type `disk management`, open **Create and format hard disk partitions**.
2. Find your main Windows partition (usually labeled `C:`), right-click it, and choose **Shrink Volume...**.
3. Windows scans the drive and shows the maximum amount it can shrink by, in MB. Enter the amount you want to free up for Omarchy in the **"Enter the amount of space to shrink in MB"** field. This number becomes the size of your future Omarchy install, **including its own boot partition** — so if you want a 50 GB Omarchy install, enter roughly `51200` (50 × 1024) or a bit more for headroom.
4. Click **Shrink**. When it finishes, you'll see a new block labeled **"Unallocated"** next to your `C:` partition in the Disk Management graphical view — this is the free space the Omarchy installer will use.
5. Do **not** create a new partition or assign a drive letter to this unallocated space — leave it as raw unallocated space. The Omarchy installer expects free/unallocated space, not an existing empty partition.

**Note on BitLocker:** The free-space install method isn't compatible with BitLocker, because BitLocker encrypts the entire drive rather than just one partition. If the Omarchy installer reports a BitLocker-related error, boot back into Windows first and turn it off: **Settings → Privacy & Security → Device encryption**, toggle it off, and wait for the drive to finish decrypting (this can take a while depending on drive size) before retrying the install.

**Why the shrink amount matters:** Unlike a full-disk install, this space is a hard ceiling — Omarchy's Btrfs root, its boot partition, and (if you add one) a shared data partition all have to fit inside whatever you free up here. If you're not sure how much you'll need, err on the side of more headroom now; resizing partitions again later is possible but adds risk and complexity compared to getting the number right up front.

## 2. What the boot menu shows after installing Omarchy alongside Windows

This is the part that surprises people coming from other dual-boot bootloaders (like GRUB, which typically auto-detects Windows during install): **Omarchy's installer does not automatically add Windows to the Limine boot menu**, even though both are on the same physical disk. Per Omarchy's own manual, after installation Limine becomes the machine's default bootloader, but its menu only lists Omarchy (plus its own Btrfs/Snapper snapshot entries) until you explicitly add Windows.

**To add Windows to the menu, run this once after your first successful boot into Omarchy:**

```bash
sudo limine-scan
```

This scans the machine's UEFI boot entries, finds Windows Boot Manager, and adds it to `/boot/limine.conf`. Follow whatever prompts it shows to confirm which entries to add. After this, rebooting shows a Limine menu listing both **Omarchy** and **Windows** — arrow keys to choose, Enter to boot into either.

**If you skip `limine-scan`:** Windows isn't gone — its own boot files are untouched on its own partition — but it won't appear in Limine's menu. You'd still be able to reach it only by using your machine's one-time boot-menu hotkey (see the BIOS/boot-menu guide) to select the separate "Windows Boot Manager" firmware entry directly, bypassing Limine entirely. This works, but means pressing the hotkey and picking Windows manually every single time you want it, rather than seeing it as a normal option inside Limine's own menu. For a smooth day-to-day dual-boot experience, running `limine-scan` once is strongly recommended rather than optional.

## 3. Boot order after `limine-scan`

Once both entries exist in Limine's menu, boot order becomes simple, since everything is on one disk (there's no "unplugging" scenario like an external-drive install):

- **Limine is the default bootloader** — powering on with no key pressed lands you at Limine's menu, where you pick Omarchy or Windows each time.
- If you'd rather Windows boot automatically with no menu most of the time, and only see the Limine menu occasionally, you can reorder the BIOS boot priority to put the Windows Boot Manager entry first instead of Limine — though this means using the one-time boot-menu hotkey whenever you want Omarchy, since Limine's own menu (with the Windows option `limine-scan` added) would no longer be what loads by default.

## References

- Omarchy — Dual Boot Install (official manual: shrinking Windows, free-space install, `limine-scan`, BitLocker incompatibility): https://omarchy.org/manual/dual-boot-install/
- Arch Wiki — Limine: https://wiki.archlinux.org/title/Limine
