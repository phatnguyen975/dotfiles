# USB Preparation

How to build a bootable installer USB, using the Omarchy 4.0.4 ISO as the worked example (the same steps apply to any distro ISO — just swap the file).

## 1. Capacity and speed requirements

- The Omarchy 4.0.4 ISO is under 6 GB. A generic distro ISO is usually 2–6 GB depending on what it bundles.
- **Minimum USB size: 8 GB.** Recommended: **16 GB or larger**, so you have headroom for future/larger ISOs without needing a second stick.
- **USB 3.0 (blue connector) strongly recommended** over USB 2.0 — noticeably faster to write the ISO and faster to read during the live boot/install itself.
- **Worked example:** a SanDisk USB 3.0 flash drive (e.g. SanDisk Ultra / Extreme, 16 GB+) needs no special drivers on Windows, Linux, or in the Omarchy live environment — it's detected as a standard USB mass-storage device.

## 2. (Optional) Wipe the USB with `diskpart` first

Rufus and balenaEtcher both handle wiping the drive themselves when writing an ISO, so this step is **not strictly required** to make a bootable USB. Do it when:

- the drive currently has a weird/unrecognized partition layout and Windows won't let Rufus/Etcher see it cleanly, or
- you just want to start from a known-clean state.

**Before running this, confirm the disk number carefully with `list disk` — check its size and model against what you know the USB stick to be. `clean` is irreversible, and running it against the wrong disk destroys that disk's data.**

```
diskpart
list disk
select disk N
clean
convert gpt
create partition primary
format fs=fat32 quick label="EMPTY"
assign
exit
```

**Why FAT32 here:** this step is just resetting the USB back to a normal, empty drive (Rufus/Etcher will reformat it again anyway when writing the ISO). FAT32 is the safest default for "any device, any OS" compatibility — Windows, macOS, Linux, cameras, car stereos, game consoles all read FAT32 natively, more so than exFAT or NTFS. Its one limitation (no single file over 4 GB) doesn't matter here since the drive is empty at this point.

What each command does (type each line exactly, pressing Enter after each one):

- `diskpart` — opens the diskpart tool inside Command Prompt (run Command Prompt as Administrator first, or diskpart will refuse to run).
- `list disk` — lists all disks so you can identify the correct number.
- `select disk N` — replace `N` with the actual number from `list disk` (e.g. `select disk 2`). This makes that disk the active target for every command after it. **This is the step where a wrong number causes irreversible damage — verify twice against size/model before pressing Enter.**
- `clean` — removes the entire partition table and all data references from the disk (not a secure wipe, but enough to reset it to "unallocated").
- `convert gpt` — sets the partition style to GPT (required for UEFI boot).
- `create partition primary` — creates one partition spanning the whole disk.
- `format fs=fat32 quick label="EMPTY"` — quick-formats it as FAT32 (readable everywhere) with the label `EMPTY`; `quick` skips a full surface scan, which is fine for flash media.
- `assign` — gives the partition a drive letter so Windows Explorer can see it.
- `exit` — closes diskpart.

## 3. Tool comparison

| Tool             | Platform                             | Best for                                                                                                                                                                               |
| ---------------- | ------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Rufus**        | Windows only                         | Most control (partition scheme, DD vs ISO mode); best default choice on Windows for Arch-based hybrid ISOs like Omarchy's                                                              |
| **balenaEtcher** | Windows, macOS, Linux                | Simplest GUI, always writes in raw/DD mode — officially suggested by Omarchy's own manual for Mac/Windows                                                                              |
| **Ventoy**       | Windows, Linux (install once to USB) | Multi-ISO USB — install Ventoy once, then just drag-and-drop `.iso` files onto the drive and pick one from a boot-time menu each time. Best if you keep several installer ISOs around. |

### Rufus — step by step

1. Download Rufus from the official site: https://rufus.ie (current stable: **Rufus 4.15**, portable `.exe`, no install needed).
2. Plug in the USB. Open Rufus.
3. **Device**: select your USB by size/name — worked example: the SanDisk 16 GB drive.
4. **Boot selection**: click **SELECT** and choose `omarchy-4.0.4.iso`.
5. **Partition scheme**: **GPT** (required for UEFI — the Gigabyte A16, like essentially every modern laptop, boots UEFI).
6. **Target system**: **UEFI (non CSM)** — this field usually auto-locks to the correct value once GPT is selected.
7. Leave **File system** on its default. This dropdown chooses the file system for a normal ("ISO Image mode") flash; once you pick **DD Image mode** in the next step, Rufus writes the ISO's own bytes directly to the drive instead, so this setting stops mattering — the ISO already contains its own internal layout.
8. Click **START**. Rufus will detect that Omarchy's ISO is an **ISOHybrid image** and ask whether to write in **ISO Image mode** or **DD Image mode** — choose **Write in DD Image mode**. Arch-based hybrid ISOs (Omarchy included) are built to be `dd`-written directly to the device, and DD mode reproduces that most faithfully.
9. Confirm the "all data on this device will be destroyed" warning (re-verify the device selected!) and let it finish.

### balenaEtcher — step by step

1. Download from https://etcher.balena.io.
2. **Flash from file** → select `omarchy-4.0.4.iso`.
3. **Select target** → choose the SanDisk USB by size/name.
4. **Flash!** → confirm. Etcher writes in raw mode automatically (no mode choice needed — this is why the Omarchy manual recommends it as the simplest option).

### Ventoy — step by step

1. Download Ventoy from https://ventoy.net.
2. Run `Ventoy2Disk.exe`, select the SanDisk USB, click **Install** (this is a one-time setup that partitions/wipes the drive — do it once, not before every ISO).
3. After install, the USB shows up in Windows Explorer as a normal drive. Just **copy `omarchy-4.0.4.iso` onto it** like any file — no re-flashing needed.
4. To add another distro later, copy its ISO onto the same USB alongside the Omarchy one.
5. Boot from the USB (power on, then press your machine's one-time boot-menu key — commonly F12, F11, F9, or Esc depending on the manufacturer) → Ventoy shows a menu listing every ISO on the drive → select `omarchy-4.0.4.iso` to boot it.

## 4. Verifying the USB boots correctly

Before relying on it for the real install, do a dry run: boot from the USB (power on, then press your machine's one-time boot-menu key to pick it), and confirm you reach either:

- the Omarchy/Arch live boot menu (Rufus/Etcher path), or
- the Ventoy ISO-selection menu → then the Omarchy boot menu (Ventoy path).

If it doesn't boot, re-flash rather than troubleshooting a half-written USB — re-flashing takes a few minutes and rules out write corruption as the cause.

## References

- Rufus official site (download, ISOHybrid/DD-mode explanation): https://rufus.ie
- balenaEtcher official site: https://etcher.balena.io
- Ventoy official site: https://www.ventoy.net
- Omarchy — Getting Started (recommends balenaEtcher/caligula): https://omarchy.org/manual/getting-started/
- Microsoft Learn — `diskpart` command reference: https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/diskpart
