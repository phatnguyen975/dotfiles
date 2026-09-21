# Prerequisites

Do this before touching any disk, USB, or BIOS setting.

## 1. Confirm your machine can boot the target distro

- **UEFI firmware, 64-bit.** Every machine sold in the last ~10 years supports UEFI. Modern distro ISOs (including Omarchy) are UEFI-only — there is no Legacy/BIOS fallback, so you don't need to hunt for a 32-bit or Legacy option.
- **Secure Boot / TPM.** Some distros (and some tools like BitLocker-protected Windows installs) interact with Secure Boot and the TPM. For Omarchy specifically, the [official manual](https://omarchy.org/manual/getting-started/) states you must turn off Secure Boot and/or TPM in the BIOS before installing, because Limine (Omarchy's bootloader) isn't signed for Microsoft's Secure Boot chain — in practice, disabling Secure Boot alone is normally enough. This setting lives in BIOS/UEFI setup, usually under a **Security** or **Boot** tab. Other distros vary — some ship a signed bootloader and work fine with Secure Boot left on, so check that distro's own docs if you're installing something other than Omarchy.
- **64-bit x86 CPU** (Intel/AMD). ARM laptops aren't covered by this guideline.

## 2. Back up your data

Regardless of method, treat the install as destructive to whatever disk you point it at:

- Full-disk installs erase the entire target disk.
- Even a "free space" / dual-boot install can go wrong if you misread a disk/partition number.
- An external-SSD install is the lowest-risk of the three (your internal Windows disk is never touched by the installer), but back up anything already on the external SSD anyway.

Use whatever backup method you already trust (cloud sync, external drive, disk image). Don't skip this step because a method "should" be safe — human error in disk selection is the single most common cause of data loss in these guides.

## 3. Gather machine information (Windows side, before you boot anything else)

From inside Windows:

- **Settings → System → About** — confirms CPU architecture (should say "64-bit operating system, x64-based processor").
- **`msinfo32`** (Win+R → type `msinfo32`) — shows **BIOS Mode** (should say `UEFI`, not `Legacy`) and Secure Boot state.
- **Disk Management** (Win+R → `diskmgmt.msc`) — lists every disk currently connected, their size, and partition style (GPT/MBR). Do this _before_ plugging in your USB (and any other target drive), then again _after_, so you can see exactly which new disk number appeared — this is your first line of defense against selecting the wrong disk later. Always double-check a disk's size and model before running any command that erases it; a wrong selection here is irreversible.

**Worked example (Gigabyte A16):** run `msinfo32` and confirm BIOS Mode = UEFI. Note the internal NVMe SSD's size as shown in Disk Management (e.g. "Disk 0 — 476.94 GB") — you'll use this to positively identify the internal drive later, versus the install USB and any other drive you connect.

## 4. Download and verify the distro ISO

Always download from the distro's official site, and verify the checksum before writing it to a USB — corruption in transit is common enough with multi-GB ISOs that skipping this step is a false economy.

**Worked example (Omarchy 4.0.4, official ISO):**

1. Go to [omarchy.org](https://omarchy.org/) and use the **ISO** download link, or grab the file directly:
   ```
   https://iso.omarchy.org/omarchy-4.0.4.iso
   ```
2. Every published Omarchy ISO has a matching `.sha256` file at the same URL. Download both, then verify (from Linux/macOS, or WSL on Windows):
   ```bash
   sha256sum -c omarchy-4.0.4.iso.sha256
   ```
   or manually compare against the checksum published on the [Omarchy GitHub releases page](https://github.com/basecamp/omarchy/releases).
3. On Windows without WSL, you can verify with PowerShell:
   ```powershell
   Get-FileHash .\omarchy-4.0.4.iso -Algorithm SHA256
   ```
   and compare the output to the published SHA256 string.

> Omarchy ships frequent point releases. Check the [GitHub releases page](https://github.com/basecamp/omarchy/releases) or [omarchy.org](https://omarchy.org/) for the current version before downloading — the steps in this guideline stay the same across versions, only the filename/version number changes. Version used throughout this guideline is **Omarchy 4.0.4**.

## References

- Omarchy — Getting Started (official manual): https://omarchy.org/manual/getting-started/
- Omarchy ISO releases (GitHub): https://github.com/basecamp/omarchy/releases
- Omarchy ISO build repo (checksum/signature process): https://github.com/johnsideserf/omarchy-iso
