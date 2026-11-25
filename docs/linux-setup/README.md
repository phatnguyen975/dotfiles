# Linux Installation Guide

Install Linux on a PC currently running Windows, using one of three storage layouts. Omarchy is the worked example; disk preparation, firmware, verification and recovery principles also apply to other distributions with UEFI-compatible installers.

## Choose an Installation Method

| Method                                               | Windows             | Storage                 | Main Risk                          |
| ---------------------------------------------------- | ------------------- | ----------------------- | ---------------------------------- |
| [Full-Disk Installation](install/full-disk.md)       | Removed from target | Internal drive          | All target data is erased          |
| [Same-Disk Dual Boot](install/dual-boot.md)          | Retained            | Shared internal drive   | Resizing and boot configuration    |
| [External SSD Installation](install/external-ssd.md) | Retained            | Separate external drive | Wrong disk or misplaced boot files |

Choose full-disk installation if you no longer need Windows on the target disk. Choose dual boot if you need both systems without buying another drive, or an external SSD if you prefer separate storage and can verify independent booting.

An external SSD reduces partitioning risks to Windows, but is not risk-free. If you only want to explore a desktop, a virtual machine is a less invasive alternative to all three methods.

## Start Here

1. Open your chosen installation guide and follow its steps in order.
2. Complete the linked preparation tasks before approving any disk changes.
3. Perform the method-specific boot checks, followed by the [common post-installation checks](common/post-install.md).
4. For Omarchy, continue with [desktop usage](omarchy/desktop.md) and optional [Vietnamese input](omarchy/vietnamese-input.md).
5. Keep the [recovery guide](recovery/README.md) accessible on a separate device.

## Scope and Version

- **Scope:** personally owned x86-64 PCs, Windows 11, UEFI firmware, and GPT system disks. Legacy BIOS, MBR conversion, ARM PCs, Apple Silicon, dynamic disks, RAID arrays and managed machines require separate procedures.
- **Example distribution:** `Omarchy 4.5.0 (Quattro RS)`, latest stable release confirmed on November 25, 2026. Use the x86 ISO, not the ARM ISO or a release candidate.
- **Other distributions:** use their official requirements and installer documentation for the actual partitioning, encryption, bootloader and update steps. Omarchy-specific instructions are explicitly identified.
- **Verification:** documentation and commands were reviewed against published sources; no physical installation or boot test was performed for this guide. Firmware and storage layouts differ, so stop if the actual screen or partition plan does not match your selected method.

## Document Map

```text
linux-setup/
├── README.md
├── install/
│   ├── full-disk.md
│   ├── dual-boot.md
│   └── external-ssd.md
├── common/
│   ├── preparation.md
│   ├── disk-identification.md
│   ├── installation-media.md
│   ├── firmware-and-boot.md
│   ├── post-install.md
│   └── shared-storage.md
├── omarchy/
│   ├── installer.md
│   ├── desktop.md
│   └── vietnamese-input.md
└── recovery/
    ├── README.md
    └── windows-reinstall.md
```

The `install/` guides own the three workflows. The `common/` files explain reusable procedures, `omarchy/` contains distribution-specific instructions, and `recovery/` covers reversing or repairing installations.

## References

- [Omarchy Official Downloads](https://omarchy.org/)
- [Omarchy Stable Releases](https://github.com/omacom/omarchy/releases/latest)
- [Omarchy 4.5 Release Announcement](https://omarchy.org/news/2026/11/omarchy-4-5/)
- [ArchWiki: Dual Boot With Windows](https://wiki.archlinux.org/title/Dual_boot_with_Windows)
