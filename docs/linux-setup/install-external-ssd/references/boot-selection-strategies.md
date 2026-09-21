# Boot-Selection Strategies (External SSD Method)

When Linux lives on an external SSD and Windows stays untouched on the internal drive, you need a repeatable way to choose which one boots. This file expands on Step 7 of [README.md](../README.md).

## Why this is different from a normal dual-boot setup

In a same-disk dual boot (Method 2), one bootloader (Limine) is installed to the shared disk's EFI System Partition and presents a menu listing both OSes every time — you always see a choice, on every boot, regardless of anything else.

With Method 3, Limine is installed to the **external SSD's own EFI System Partition**, separate from the internal Windows disk's own EFI System Partition and Windows Boot Manager. By default, only "Omarchy" (plus its own Snapper snapshot entries) shows up in the Limine menu — Windows is not listed, because Limine only knows about the disk it was installed onto. This gives you two layers of choice, and you can use either or both:

- **Layer 1 — which bootloader does the firmware hand control to?** (Strategies 1–3 below: plug-in-before-power-on, boot-menu hotkey, or boot order)
- **Layer 2 — once Limine has control, does it also offer Windows as a menu option?** (Strategy 4 below: `limine-scan`)

## What happens when the external SSD is NOT connected

**The machine boots straight into Windows — no menu, no prompt.** This is true no matter which strategy below you've set up, and it's the whole reason Method 3 is low-risk. Here's why: Limine only exists on the external SSD's own EFI partition. When that drive is physically disconnected, the firmware simply has no Limine entry to consider at all — it isn't "hidden" or "skipped," it doesn't exist. The firmware falls through to the next entry in its list, which is the internal disk's **Windows Boot Manager**. And Windows Boot Manager, with only one Windows installation present, doesn't show a chooser screen by default — it loads Windows directly.

So: SSD connected → you get a choice, controlled by whichever strategy you set up below. SSD disconnected → Windows loads automatically, exactly as if Method 3 had never happened.

**If the SSD is connected but you choose Windows anyway** (via the firmware's one-time boot menu, or via Windows listed inside Limine's own menu after Strategy 4) — Windows boots completely normally either way. Selecting the Windows Boot Manager entry directly bypasses Limine entirely; selecting "Windows" from inside Limine's menu just chainloads to that same Windows Boot Manager. Once Windows has finished loading, it's running entirely off the internal disk and no longer depends on the external SSD at all — **it's safe to unplug the SSD at that point.** The only thing to be careful about is if you were actively using the [shared data partition](../../references/shared-data-partition.md) from Windows (files open, a copy in progress) — in that case, use Windows' "Safely Remove Hardware" first, same as with any external drive, before unplugging.

## Strategy 1 — Plug in before power-on, let boot order/firmware pick it up

**How it behaves:** most UEFI firmware (including on the Gigabyte A16) enumerates all connected bootable EFI entries fresh at every power-on. If the external SSD is connected when you turn the machine on, its EFI entry (Limine) becomes selectable — either automatically first (if boot order already prioritizes it) or via the one-time boot menu.

- **Pros:** Once boot order is set to prefer the external SSD, this is fully hands-off when the SSD is connected, and automatically falls back to Windows the instant it's unplugged — no BIOS visits needed for routine use.
- **Cons:** Requires setting boot order once (a BIOS visit), and if you forget the SSD is plugged in, the machine may boot into Linux when you expected Windows (or vice versa, depending on how you order it).

## Strategy 2 — One-time boot-menu hotkey (recommended default)

**How it behaves:** leave the saved boot order exactly as it was with Windows as default. Every time you specifically want the external SSD, connect it, power on, and press **F12** (Gigabyte A16) to bring up the one-time boot menu, then pick the SSD's EFI entry.

- **Pros:** Zero risk of accidentally changing your default boot behavior; Windows always boots by default with nothing extra connected or pressed. Easiest to reason about.
- **Cons:** Requires remembering to press the hotkey and pick correctly every single time you want Linux — one extra manual step per boot.

## Strategy 3 — Reorder boot priority to prefer the external SSD

**How it behaves:** in BIOS boot order settings, move the external SSD's EFI entry above the internal Windows entry, and leave it that way permanently.

- **Pros:** No hotkey needed on the boots where you want Linux — just have the SSD connected and power on. Still safe when the SSD is disconnected, since firmware automatically skips a missing boot entry and falls through to the next one (Windows).
- **Cons:** If you _do_ leave the SSD connected but actually wanted to boot Windows that time, you'd need the boot menu anyway to override the order — so this strategy mainly helps if "SSD connected" and "want to boot Linux" are almost always true together for you.

## Strategy 4 — Add Windows into the Limine menu itself (`limine-scan`)

This is a different kind of strategy from the three above: instead of choosing between two separate boot managers at the _firmware_ level, you make **Limine itself** offer both operating systems in **one menu**, the same experience as a traditional same-disk dual boot. This is what people usually mean when they say "it shows an option to pick Linux or Windows" after booting from the external SSD.

**How it works:** Omarchy ships a helper command, `limine-scan` (a wrapper around `limine-entry-tool --scan`), documented in Omarchy's own [Dual Boot Install manual](https://omarchy.org/manual/dual-boot-install/). It reads the machine's UEFI boot entries (via `efibootmgr`) system-wide — not just entries on the disk Limine is installed to — finds "Windows Boot Manager," and writes an entry for it into `/boot/limine.conf` on the external SSD. Community reports confirm this also works when Windows lives on a **different physical disk** than Limine (exactly our external-SSD case), which is what makes it usable here.

**Steps:**

1. Boot into Omarchy from the external SSD.
2. Open a terminal (Omarchy's default terminal is bound to **Super + Return**).
3. Run:
   ```bash
   sudo limine-scan
   ```
   Type your account password when prompted (needed for `sudo`), then press Enter.
4. Confirm it worked by opening the generated config file:
   ```bash
   cat /boot/limine.conf
   ```
   You should see a new entry block whose `comment:` or title mentions **Windows Boot Manager**, in addition to the existing Omarchy entry.
5. Confirm the entry points at the right file. Limine matches the file path exactly as written, so it's worth a quick check that the path in the new entry matches the real file on the Windows EFI partition:
   ```bash
   lsblk -o NAME,SIZE,FSTYPE,PARTUUID       # find the Windows ESP — usually the small (~100–300 MB) partition with fstype=vfat on the internal disk
   sudo mkdir -p /mnt/winesp
   sudo mount /dev/nvme0n1p1 /mnt/winesp    # replace with the actual Windows ESP partition
   ls /mnt/winesp/EFI/Microsoft/Boot/       # note the exact file name and its capitalization
   sudo umount /mnt/winesp
   ```
   Compare this against the `image_path:` line in the new entry inside `/boot/limine.conf`. If they don't match exactly (including capital/lowercase letters), edit `/boot/limine.conf` so the path matches what `ls` showed.
6. Reboot (with the external SSD still connected). The Limine menu should now list both **Omarchy** and **Windows** — select **Windows** to confirm it boots correctly, then reboot again and select **Omarchy** to confirm that still works too.

**Writing the entry by hand, if you prefer not to rely on the scan:** since Windows sits on a **different disk** than Limine's own config partition, address it with `uuid(...)` (the Windows ESP's own partition UUID) rather than `boot():` — `boot():` only resolves to the partition Limine's own config lives on. Get the UUID with `lsblk -o NAME,PARTUUID` on the Windows ESP partition, then add a block like this to `/boot/limine.conf`:

```
/Windows
    comment: Windows Boot Manager
    protocol: efi_chainload
    image_path: uuid(XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX):/EFI/Microsoft/Boot/bootmgfw.efi
```

Replace the UUID with the one you found, save the file, and reboot to test.

**Combining Strategy 4 with the others:** Strategy 4 only controls what Limine shows _once it has control_ — you still need one of Strategies 1–3 to decide when the firmware hands control to Limine in the first place. The most "single unified menu" feeling setup is **Strategy 3 + Strategy 4 together**: set the external SSD as the preferred boot device in BIOS order, and run `limine-scan` — then, whenever the SSD is connected, the machine boots straight to a Limine menu offering both Omarchy and Windows, with no hotkey needed; when the SSD is disconnected, it falls straight through to Windows as normal.

## Recommendation

For occasional use, **Strategy 2 (boot-menu hotkey)** alone is simplest and lowest-risk. If you want Linux to feel like a "real" dual-boot option available at every boot without touching firmware settings each time, add **Strategy 4** on top of **Strategy 1 or 3**.

## References

- Omarchy — Dual Boot Install manual (documents `limine-scan`): https://omarchy.org/manual/dual-boot-install/
- Arch Wiki — Limine, Windows entry (UEFI), `uuid()` vs `boot()` addressing: https://wiki.archlinux.org/title/Limine
- UEFI Specification (boot entry enumeration behavior, general reference): https://uefi.org/specifications
- [bios-uefi-and-boot-menu.md](../../references/bios-uefi-and-boot-menu.md) — key map and BIOS settings for the Gigabyte A16 and other vendors
