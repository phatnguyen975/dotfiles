# Reinstalling Windows 11

Expands on the "If you ever want Windows back" section of [README.md](../README.md). Since Method 1 erases Windows completely, getting it back means a fresh Windows 11 install, not an undo — this file covers that install itself. For just clearing the disk beforehand, see **Scenario C** of the shared [rollback-and-cleanup.md](../../references/rollback-and-cleanup.md); this file covers everything from there through to a working Windows desktop.

## 1. What you need before starting

- **A Windows 11 license.** If this machine originally came with Windows 11 already activated (most pre-built laptops, the Gigabyte A16 included, ship this way), Windows ties that license digitally to the hardware itself — reinstalling the same edition on the same machine and connecting it to the internet during setup re-activates it automatically, with no product key needed. If you're not sure, you can skip the product key screen during setup (see Step 4) and check activation afterward in **Settings → System → Activation**.
- **Hardware requirements met:** a 64-bit CPU, 4 GB+ RAM, 64 GB+ storage, and — the two that matter most here — **TPM 2.0** and **Secure Boot capability**. A modern gaming laptop like the Gigabyte A16 meets all of these; the catch is that **Secure Boot is currently turned off** in BIOS (a requirement for Omarchy — see the shared [bios-uefi-and-boot-menu.md](../../references/bios-uefi-and-boot-menu.md)), and Windows 11 Setup checks for it. Re-enable it before installing (Step 3).

## 2. Create the Windows 11 install USB

**Option A — Microsoft's Media Creation Tool (simplest, official):**

1. On another working Windows or Mac machine, go to Microsoft's official Windows 11 download page and download `MediaCreationTool.exe`.
2. Run it, accept the license terms, and choose **"Create installation media (USB flash drive, DVD, or ISO file) for another PC"**.
3. Select your language and edition (usually fine on the default, auto-detected settings), then choose **USB flash drive** as the media type.
4. Select your USB drive from the list and continue — the tool downloads the current Windows 11 release (25H2 as of this writing) and writes it to the USB automatically. This takes a while depending on your internet connection.

**Option B — Rufus, from a downloaded Windows 11 ISO:**

1. Download the Windows 11 ISO directly from Microsoft's official download page (choose "Download Windows 11 Disk Image (ISO)" instead of the Media Creation Tool).
2. Open Rufus, select your USB under **Device**, then **SELECT** the downloaded Windows 11 ISO.
3. Under **Image option**, choose **Standard Windows 11 Installation** if your hardware meets the requirements (Secure Boot re-enabled per Step 3 below), or **Extended Windows 11 Installation (no TPM/Secure Boot/RAM checks)** only if you have a specific reason to skip those checks.
4. Partition scheme **GPT**, Target system **UEFI (non CSM)** — same settings used for the Omarchy USB in [usb-preparation.md](../../references/usb-preparation.md).
5. Click **START** and let it finish.

## 3. Re-enable BIOS settings for Windows

Enter BIOS setup (on the Gigabyte A16: power on, press **F2** repeatedly — see the shared [bios-uefi-and-boot-menu.md](../../references/bios-uefi-and-boot-menu.md) for other vendors) and turn **Secure Boot back on**. Leave TPM as-is (it should already be enabled, since Omarchy only required Secure Boot to be off — see the Prerequisites note in that same file). Save and exit.

## 4. Boot the installer and run Windows Setup

1. Press **F12** repeatedly on the next boot to bring up the one-time boot menu, and select the Windows install USB.
2. **Language and keyboard layout** — select yours, click **Next**.
3. Click **Install now**.
4. **Product key screen** — click **"I don't have a product key"** if this machine already has a digital license tied to its hardware (see Step 1); Windows will still activate automatically once you're online after setup, matched to the same edition it had before.
5. **Select the edition** if prompted (matches what this machine was licensed for before — commonly **Windows 11 Home** or **Windows 11 Pro**).
6. Accept the license terms.
7. **Installation type** — choose **Custom: Install Windows only (advanced)**.
8. **Partition screen** — this lists whatever partitions currently exist on the disk (the Linux ones from Omarchy, if you haven't already wiped the disk via Scenario C). Select each Linux partition and click **Delete** until the disk shows as one block of **Unallocated Space**. Then click **Next** — Windows automatically creates its own partitions (EFI, Microsoft Reserved, and the main `C:` partition) inside that unallocated space and begins installing.
9. Installation runs and reboots itself a few times automatically — this is normal, don't intervene.

## 5. First-boot setup (OOBE)

After installation finishes, Windows walks through initial setup:

1. **Region** and **keyboard layout** — confirm or change.
2. **Network connection** — connect to Wi-Fi; an internet connection is required to continue on Windows 11 Home, and is what triggers automatic re-activation of your digital license.
3. **Account setup** — sign in with a Microsoft account, or set up a local account if you prefer (look for a "sign-in options" or similar link on the Microsoft-account screen; Microsoft has increasingly steered this flow toward requiring an account, so the exact wording/steps can vary by build — the option to use a local account has consistently remained available, just sometimes less prominent).
4. **Privacy settings** — review and set according to your preference.
5. Windows finishes setup and lands on the desktop.

## 6. Post-install

1. **Windows Update** — open **Settings → Windows Update → Check for updates**, install everything available, reboot as needed, and repeat until it reports up to date.
2. **Drivers** — Windows Update typically pulls in most drivers automatically (including optional/recommended ones under **Windows Update → Advanced options → Optional updates**). For anything missing (uncommon on a well-supported laptop, but possible for GPU or Wi-Fi specifics), get the latest drivers directly from Gigabyte's support page for your exact model.
3. **Confirm activation** — **Settings → System → Activation** should show "Windows is activated" if your digital license was recognized automatically (Step 4.4).

## References

- Microsoft — Download Windows 11 (Media Creation Tool, ISO): https://www.microsoft.com/software-download/windows11
- Microsoft Learn — Windows 11 activation and digital licenses: https://learn.microsoft.com/en-us/windows/deployment/volume-activation/activate-windows-11
- Rufus official site (Windows 11 image options, requirement-bypass mode): https://rufus.ie
