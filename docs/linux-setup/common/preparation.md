# Prepare the Computer

Complete this checklist while Windows still works. Do not start installation until you have a working recovery path and have identified the target drive.

## Check Compatibility

1. Open **Settings > System > About** and confirm an x64-based processor.
2. Press `Win + R`, run `msinfo32`, and record **BIOS Mode** (UEFI is required for this guide), Secure Boot State, system model and BIOS version.
3. Open `diskmgmt.msc`; right-click the disk label, open **Properties > Volumes**, and check that the Windows system disk uses GPT.
4. Compare your hardware with the distribution's documented requirements, including CPU, graphics, RAM, storage and networking. Leave enough storage for applications, updates and personal files, not just the initial OS.

For Omarchy, use the x86-64 image on Intel/AMD PCs. A practical planning allowance is 100–200 GiB for a development desktop, plus your own data and possible hibernation needs; this is a recommendation, not an official minimum.

Stop if the machine uses Legacy mode, a dynamic disk, Storage Spaces, RAID or a layout you cannot identify. Do not convert storage or firmware modes as an incidental installation step.

## Back Up and Prepare Recovery

- Copy important Windows files and all data on the intended Linux target to independent storage. Verify a sample of files can be restored; cloud synchronization alone is not a complete system backup.
- If you need to recover the exact Windows installation, create and verify a full-system image using a recovery tool you trust. Retain any OEM recovery media, license details and vendor storage/network drivers.
- Create a separate Windows recovery or installation USB using [Microsoft's official tool](https://www.microsoft.com/software-download/windows11). Test that it reaches recovery/setup without starting installation.
- Keep backup disks disconnected during partitioning and installation. Use AC power, a working physical keyboard, and an available network connection for first-boot updates.
- Record firmware settings and Windows partition layout using photos or notes stored off the target disk.

## Check Windows Encryption

Windows Device Encryption and BitLocker can be enabled automatically. In an administrator Command Prompt, inspect the current state:

```cmd
manage-bde -status
```

For every protected volume that matters, save its recovery key somewhere separate from the computer. Match the key ID and verify that you can access the saved key before changing firmware or boot settings.

- Full-disk installation: decryption is not required just to erase the intended drive, but recover all necessary data and keys first.
- Same-disk Omarchy dual boot: follow [the dual-boot guide](../install/dual-boot.md); upstream documents an incompatibility with BitLocker. Suspension is not the same as decryption.
- External SSD: normally retain Windows encryption. Firmware or boot changes can trigger recovery even if no Windows partition is edited.

If Windows will remain and a firmware change is needed, review [Microsoft's BitLocker suspension guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-client/windows-security/suspend-bitlocker-protection-non-Microsoft-updates) first. Resume protection after the required changes and Windows boot checks; never leave it suspended indefinitely.

Do not disable organizational security controls or clear TPM keys. If encryption or firmware settings are managed, stop and consult the administrator.

## Prepare Windows for Coexistence

For dual boot or external SSD installations, disable Windows Fast Startup when available. Open **Control Panel > Power Options > Choose what the power buttons do > Change settings that are currently unavailable**, clear **Turn on fast startup**, then save.

Fully shut down Windows before starting Linux; do not hibernate either system while the other may access a shared filesystem. Firmware Fast Boot is a different setting, covered in [Firmware and Boot](firmware-and-boot.md).

## Ready to Continue

- [ ] Compatibility and storage layout checked.
- [ ] Backups and recovery media verified.
- [ ] Recovery keys available and encryption state recorded.
- [ ] Windows edition and current activation recorded if Windows may be erased.
- [ ] Unneeded disks disconnected and power connected.

Return to your installation guide and continue with [disk identification](disk-identification.md).

## References

- [Microsoft: Find Your BitLocker Recovery Key](https://support.microsoft.com/en-us/windows/security/encryption/find-your-bitlocker-recovery-key)
- [Microsoft: BitLocker Recovery Known Issues](https://learn.microsoft.com/en-us/troubleshoot/windows-client/windows-security/bitlocker-recovery-known-issues)
- [Microsoft: Windows Recovery Options](https://support.microsoft.com/en-us/windows/experience/backup-recovery/recovery-options-in-windows)
- [Omarchy: Getting Started](https://omarchy.org/manual/getting-started/)
- [ArchWiki: Dual Boot With Windows](https://wiki.archlinux.org/title/Dual_boot_with_Windows)
