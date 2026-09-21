# BIOS/UEFI Entry, Boot Menu, and the Settings to Change

This file has two general parts (entering BIOS/boot menu, and generic UEFI settings) that apply no matter which distro you install, plus one section that's specific to Omarchy's requirements — clearly marked below.

## 1. Entering BIOS setup vs. the one-time boot menu

- **BIOS/UEFI setup** — the full firmware configuration screen. You go here to change persistent settings: Secure Boot, Fast Boot, boot order, storage controller mode.
- **One-time boot menu** — a quick list of bootable devices for _this boot only_, without changing any saved setting. This is usually the faster way to boot from a USB (or any other connected drive) once, without permanently reordering your boot priority.

Both are triggered by pressing a key repeatedly right after powering on, before the OS starts loading (you typically have a window of 1–3 seconds after the manufacturer logo appears).

## 2. Common keys by manufacturer

| Brand                                | BIOS/UEFI setup | One-time boot menu                                    | Notes                                                    |
| ------------------------------------ | --------------- | ----------------------------------------------------- | -------------------------------------------------------- |
| **Dell**                             | F2              | F12                                                   | Consistent across Inspiron, XPS, Latitude, Precision     |
| **Lenovo (ThinkPad)**                | Enter, then F1  | Enter, then F12 (or F12 directly)                     | Some models show "Press Enter to interrupt" first        |
| **Lenovo (IdeaPad / Legion / Yoga)** | F2              | F12, or the small **Novo button** near the power port | Novo button works even from a fully powered-off state    |
| **Asus**                             | Del or F2       | Esc or F8                                             | Laptops usually Esc; desktop motherboards usually F8     |
| **HP**                               | Esc, then F10   | Esc, then F9                                          | Tap Esc first to get HP's startup menu, then pick        |
| **Acer**                             | F2              | F12                                                   | F12 boot menu sometimes needs enabling inside BIOS first |
| **MSI**                              | Del             | F11                                                   | Common on MSI gaming laptops and motherboards            |
| **Gigabyte / AORUS (laptops)**       | F2              | F12                                                   | See Gigabyte A16 worked example below                    |
| **Gigabyte (desktop motherboards)**  | Del             | F12                                                   | Different from the laptop line above                     |

These are the most commonly reported keys per vendor and are correct for the large majority of models, but firmware varies by generation — if a key doesn't work, try the others listed for that vendor, and check the one-line hint text that flashes on screen at boot.

## 3. Worked example: Gigabyte Gaming A16

- **Enter BIOS setup:** press **F2** repeatedly right after powering on.
- **One-time boot menu:** press **F12** repeatedly right after powering on.
- These match the standard behavior reported across Gigabyte's AORUS/Gaming laptop line. USB boot works natively with no separate enable setting — just the boot menu key above. Because Gigabyte publishes a model-specific manual per exact SKU (e.g. "GIGABYTE GAMING A16 PRO ..."), **confirm against your exact model's manual** before relying on this if F2/F12 don't respond:
  1. Go to https://www.gigabyte.com, search your exact model name/SKU (printed on the bottom of the laptop or in Windows **Settings → System → About**).
  2. Open the model's **Support** page → **Manual** section → download the user manual PDF, which lists the exact key for that specific board revision.

## 4. Settings to check

These settings live inside BIOS/UEFI setup (not the boot menu). Some apply to installing _any_ modern Linux distro; others are specific to Omarchy's setup (Limine bootloader). Each item below says which is which.

### General — applies to installing any modern 64-bit UEFI Linux distro

- **USB boot itself needs no separate "enable" setting on virtually all modern laptops.** Booting from a USB drive is a mandatory part of the UEFI standard, so it works out of the box through the boot menu/boot order — there's normally nothing to turn on. But on Dell's business laptop lines (Latitude, Precision, and some OptiPlex/managed systems), there's a separate BIOS setting — **System Configuration → USB Configuration → Enable USB Boot Support** — that some corporate/IT-managed machines ship with **disabled**. If the USB doesn't show up in the F12 boot menu at all on a Dell business laptop, check and enable this setting first; this is documented directly by Dell for its Latitude line.
- **CSM / Legacy Boot → keep disabled (UEFI-only).** Modern distro install images, Omarchy included, are UEFI-only and use GPT partitioning. Leaving CSM/Legacy on can make the firmware try (and fail) to boot the USB the old way. Usually under a **Boot** tab.
- **Fast Boot → Disabled while installing.** Fast Boot can skip steps the firmware needs to detect a USB drive, or make the boot-menu hotkey not register in time. Turn it off during the install; turn it back on afterward if you want faster day-to-day boot times.
- **Storage controller mode (Intel RST/VMD, or AMD RAID) → AHCI / standard NVMe, if this option exists.** If the internal NVMe SSD is running in RAID/VMD mode, a Linux live environment may not see it at all. Most gaming laptops, the A16 included, ship in standard AHCI/NVMe mode with no RAID by default, so this is usually already fine — but check it (often under **Peripherals** or **Chipset**) if your internal disk doesn't show up in `lsblk`.

### Distro-specific — this is what Omarchy needs; check your own distro's docs if installing something else

- **Secure Boot → Disabled.** This is required for Omarchy specifically, because its bootloader (Limine) is not signed for Microsoft's Secure Boot chain, and Secure Boot will refuse to load it. This is **not true for every distro** — some (for example Fedora, Ubuntu, openSUSE) ship a Microsoft-signed "shim" bootloader and boot fine with Secure Boot left **on**. Don't assume you must disable Secure Boot for a distro other than Omarchy — check that distro's own installation documentation first. Usually under a **Security** or **Boot** tab.
- **TPM.** Omarchy's own manual says to turn off Secure Boot **and/or** TPM before installing. In practice, **Secure Boot is the setting that actually blocks Omarchy's boot** — TPM itself doesn't stop a Linux ISO from booting. Leaving TPM **enabled** is normally fine, and keeps BitLocker or other TPM-dependent Windows features working when you boot back into Windows. Only disable TPM too if Omarchy's boot still fails after disabling Secure Boot alone.

### Boot order

**Boot order** (sometimes called "boot priority") is the saved list, inside BIOS/UEFI setup, of which bootable device the firmware tries first, second, third, and so on, every time the machine powers on with no key pressed. It's usually found under a **Boot** tab, shown as a re-orderable list of detected devices/EFI entries. Two things worth knowing about it:

- Reordering it is optional — you can always bypass the saved order for a single boot by using the one-time boot menu key instead, which doesn't change anything saved.
- If a device in the list is disconnected (a USB unplugged, an external drive removed), the firmware simply skips that entry and moves to the next one in the list — it does not get stuck or prompt an error.

How you actually want to use boot order day-to-day — whether to reorder it permanently, or just rely on the one-time menu each time — depends on your specific install setup, so it's covered in your chosen install method's own guide rather than here.

## References

- Gigabyte — laptop support/manual lookup: https://www.gigabyte.com
- Omarchy — Getting Started (Secure Boot/TPM requirement): https://omarchy.org/manual/getting-started/
- Dell — Enable USB Boot Support (System Configuration → USB Configuration), documented for the Latitude line: https://www.dell.com/support
- Common vendor BIOS/boot-menu key references (cross-checked against multiple vendor support pages): Dell, HP, Lenovo, Asus, Acer, MSI, Gigabyte official support sites
