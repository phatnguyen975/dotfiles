# Omarchy Installer

This guide covers the stable Omarchy 4.5.0 x86-64 ISO. Use it only after following the preparation steps for your chosen [installation method](../README.md).

## Run the Interactive Installer

1. Boot the verified Omarchy USB in UEFI mode. Use the keyboard-driven installer and select your keyboard layout; follow any network prompts displayed by the ISO.
2. Select the physical target drive identified in your method guide. Choose the full-disk option for a dedicated drive or **Free space install** to retain existing partitions.
3. Answer the remaining account and machine configuration prompts as displayed. Choose a username and a password you can reliably enter with the selected keyboard layout.
4. Return to the **Before You Confirm** checklist in your chosen method guide. Review the proposed disk formatting operation and encryption configuration before confirming. The interactive installer enables disk encryption by default, including for free-space installations.
5. Keep power connected while installation runs. Reboot when the installer reports success and remove the installer USB when instructed.

For the normal guided layout, Omarchy uses a dedicated FAT32 EFI partition and a Btrfs system filesystem, with LUKS encryption for the main system when enabled. The EFI partition itself is not encrypted.

The exact screen sequence and fields may differ between releases. Refer to the current official [Getting Started](https://omarchy.org/manual/getting-started/) and [Dual Boot Install](https://omarchy.org/manual/dual-boot-install/) pages for actual installer screenshots rather than assuming a fixed prompt order.

Do not select the whole-drive mode as a fallback if free-space mode is unavailable. Do not choose unattended installation or deferred owner setup for this interactive workflow.

## First Boot

Enter the disk-unlock password if encryption is enabled. A built-in or wired keyboard is preferable at this stage because Bluetooth input may not be available before the desktop starts.

Sign in and check that the desktop loads. Return to the selected method's verification section before installing extra software or changing the bootloader.

## Configure Boot Selection

This section is optional for installations that retain Windows. First verify that the separate Windows firmware entry still boots correctly.

From the installed Omarchy terminal, run the command documented by the upstream dual-boot guide:

```bash
limine-scan
```

Follow the prompts to include the correct Windows Boot Manager entry. If scanning fails or the command is missing, use the firmware menu for now and consult the official guide; do not manually overwrite EFI files or invent a configuration path.

The current default Limine menu is hidden and starts Omarchy after a short timeout. Press a key as Limine starts to expose its entries, then select Windows or Omarchy with the arrow keys and Enter.

If **Setup > Direct Boot** has been enabled, firmware may bypass Limine altogether. Select Limine in the one-time firmware menu or use the same Direct Boot setting to return to normal Limine booting; the official snapshot guide documents this behavior.

Test both menu entries, then choose a preferred firmware boot order if desired. For an external SSD, verify Windows also boots without the SSD attached.

## References

- [Omarchy: Getting Started](https://omarchy.org/manual/getting-started/)
- [Omarchy: Dual Boot Install](https://omarchy.org/manual/dual-boot-install/)
- [Omarchy: System Snapshots and Direct Boot](https://omarchy.org/manual/system-snapshots/)
- [Omarchy ISO Repository](https://github.com/omacom/omarchy-iso)
- [Omarchy ISO Configurator Source](https://github.com/omacom/omarchy-iso/blob/quattro/configs/airootfs/root/configurator) (development branch; implementation context, not a frozen 4.5.0 artifact)
