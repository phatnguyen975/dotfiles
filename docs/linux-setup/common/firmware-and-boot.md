# Configure Firmware and Boot Devices

UEFI setup changes persistent firmware configuration. The one-time boot menu selects a device for the current startup and is preferable for installation and initial testing.

## Enter UEFI Setup

Use Windows **Settings > System > Recovery > Advanced startup > Restart now**, then **Troubleshoot > Advanced options > UEFI Firmware Settings > Restart**, if available. Alternatively, use the startup key documented for your exact model.

Examples from vendor guidance (not guaranteed for every model):

| Vendor          | Firmware Setup | Boot Menu |
| --------------- | -------------- | --------- |
| Dell            | F2             | F12       |
| Lenovo ThinkPad | F1             | F12       |
| ASUS laptops    | F2             | Esc       |

On a Gigabyte Gaming A16, look up the exact SKU at [Gigabyte Support](https://www.gigabyte.com/Support) and use its manual or startup-screen hints to identify the setup and boot-menu keys. Do not assume all A16 revisions have identical firmware.

## Review Settings

Record original settings before changing anything. If Windows remains, complete the encryption precautions in [Preparation](preparation.md) before making any changes.

| Setting                          | Guidance                                                                                             |
| -------------------------------- | ---------------------------------------------------------------------------------------------------- |
| UEFI/CSM                         | Use UEFI; keep Legacy/CSM disabled on an existing UEFI Windows system                                |
| Firmware Fast Boot               | Disable temporarily if it prevents media detection or startup keys                                   |
| Secure Boot                      | Keep enabled for distributions that support it; Omarchy requires a compatible firmware configuration |
| TPM                              | Leave enabled unless a documented requirement specific to your hardware prevents installation        |
| Storage mode (RST/VMD/RAID/AHCI) | Leave unchanged; switching can make Windows unbootable                                               |
| USB boot                         | Enable only if needed and permitted by the firmware                                                  |

### Omarchy Example

The [official manual](https://omarchy.org/manual/getting-started/) instructs users to turn off Secure Boot and/or TPM for installation. On a personally owned PC, change only Secure Boot if required to start the official image; do not clear TPM or disable it speculatively.

Disabling Secure Boot reduces boot-chain protection for the entire computer, including Windows. If your security policy requires Secure Boot, select a compatible distribution instead of proceeding with this configuration.

If the ISO still will not start, consult Omarchy and the hardware vendor before changing further security settings. Do not reset firmware to defaults as a troubleshooting shortcut.

## Boot the Installer

1. Connect the verified installer USB; connect the target SSD only when required by the chosen guide.
2. Restart and enter the one-time boot menu using the documented key.
3. Select the UEFI entry for the installer USB, not Windows Boot Manager or the target disk.
4. If a Linux live shell is available, confirm UEFI mode:

```bash
test -d /sys/firmware/efi && echo 'UEFI mode'
```

If the command produces no output, stop and check boot mode. Return to your installation guide once the installer has loaded.

## Select an Installed System

Firmware boot entries launch EFI applications, which may then display another menu (Limine, GRUB or another boot manager). Changing the boot order does not itself add Windows to a Linux bootloader's menu.

Use the one-time menu for initial tests. After verifying both systems, adjust the permanent boot order only if desired; missing external devices may cause fallback, delays or prompts depending on firmware.

If a USB is absent, try a direct port, check the writer output and check vendor documentation. If an internal drive is absent, do not switch RST/VMD/AHCI blindly; seek a supported storage-driver or migration procedure.

## References

- [Omarchy: Getting Started](https://omarchy.org/manual/getting-started/)
- [ArchWiki: UEFI](https://wiki.archlinux.org/title/Unified_Extensible_Firmware_Interface)
- [ArchWiki: Dual Boot With Windows](https://wiki.archlinux.org/title/Dual_boot_with_Windows)
- [Microsoft: BitLocker FAQ](https://learn.microsoft.com/en-us/windows/security/operating-system-security/data-protection/bitlocker/bitlocker-overview-and-requirements-faq)
- [Gigabyte Support](https://www.gigabyte.com/Support)
- [Dell: Enter BIOS or UEFI Setup](https://www.dell.com/support/kbdoc/en-us/000126121/access-uefi-bios-system-setup-from-windows-on-your-dell-system)
- [Lenovo: Select a Boot Device](https://pcsupport.lenovo.com/us/en/solutions/HT104668)
- [ASUS: BIOS and Boot Menu Keys](https://www.asus.com/vn/blog/cach-vao-bios-asus/)
