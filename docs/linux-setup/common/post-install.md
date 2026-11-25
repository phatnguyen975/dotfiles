# Post-Installation Checks

Run these checks in the installed Linux system, not in the live installer. Complete the method-specific boot tests before considering the installation finished.

## Verify the Storage Layout

Open a terminal and inspect the installed system:

```bash
cat /etc/os-release
lsblk -o NAME,PATH,TYPE,SIZE,MODEL,SERIAL,TRAN,FSTYPE,UUID,PARTUUID,MOUNTPOINTS
findmnt --target /
findmnt -t vfat
```

Trace the root filesystem through any encrypted mapping to its physical drive. Identify the mounted EFI System Partition (ESP), which may be at `/boot`, `/efi` or `/boot/efi` depending on the distribution.

On UEFI systems, if `efibootmgr` is installed, inspect the firmware entries without modifying them:

```bash
sudo efibootmgr -v
```

Match the active boot entry (`BootCurrent`) and its partition identifier, when shown, to the ESP recorded by `lsblk`. For an external SSD, confirm both Linux root and Linux boot files are on the external disk; a mounted ESP alone does not establish where firmware actually loaded the bootloader from.

If the ESP is not mounted or the entry cannot be mapped, do not guess its location. Consult the distribution's bootloader documentation before changing disks or deleting any partitions.

## Check Hardware and Services

- [ ] Wi-Fi or Ethernet connects and DNS works.
- [ ] Display resolution, scaling and any external monitor work.
- [ ] Keyboard, touchpad, audio, microphone and Bluetooth work as needed.
- [ ] Integrated and discrete graphics are detected if applicable.
- [ ] Shutdown and restart work, followed by another successful login.
- [ ] Suspend and resume work if you intend to use them; do not disconnect a suspended external system.

For troubleshooting on systems that use systemd and NetworkManager, collect read-only diagnostics:

```bash
lspci -nnk
nmcli device status
systemctl --failed
journalctl -b -p err --no-pager
```

Some distributions omit these tools or use different service managers. An error in the journal is a diagnostic clue, not proof that the installation is broken.

For hybrid-graphics laptops, use the exact PCI identifiers and manufacturer model when looking up drivers. Avoid installing an arbitrary NVIDIA or Wi-Fi driver before identifying the hardware and the distribution's supported package.

## Update the System

Use the distribution's supported update process and reboot if required. Avoid mixing repositories or doing partial upgrades.

**Omarchy:** open the Omarchy menu with `Super + Space`, then select **Update > Omarchy**, or use:

```bash
omarchy update
```

This runs the distribution's update logic, including migrations and snapshots. Do not substitute a direct `pacman -Syu` or `yay -Syu` for the Omarchy update procedure.

Check the installed package version with `pacman -Q omarchy` and compare with the [stable release](https://github.com/omacom/omarchy/releases/latest); package revision suffixes are normal. Reboot and repeat the boot and hardware checks after any update that requires a restart.

## Protect Your Installation

Create a regular backup of personal files and important configuration on storage independent of the Linux system disk. Keep recovery media and encryption credentials available in a safe location.

Omarchy automatically takes system snapshots during its update process. These snapshots can help recover a broken root filesystem, but do not include your home directory and do not replace a backup; see [Recovery and Cleanup](../recovery/README.md).

For installations retaining Windows, check Windows encryption and recovery settings again after all firmware changes. Re-enable any temporarily suspended BitLocker protection according to [Microsoft's guidance](https://learn.microsoft.com/en-us/troubleshoot/windows-client/windows-security/suspend-bitlocker-protection-non-Microsoft-updates); this is different from re-enabling encryption after decryption for an Omarchy same-disk installation.

## Completion Checklist

- [ ] Root and boot partitions match the intended storage layout.
- [ ] All operating systems that should remain have been booted successfully.
- [ ] Linux is updated and hardware checks are satisfactory.
- [ ] Encryption status and firmware settings are recorded.
- [ ] Backup and recovery procedures are available.

Continue with [Omarchy Desktop Usage](../omarchy/desktop.md) if applicable, or your own distribution's desktop guide.

## References

- [Linux Manual: lsblk](https://man7.org/linux/man-pages/man8/lsblk.8.html)
- [Linux Manual: findmnt](https://man7.org/linux/man-pages/man8/findmnt.8.html)
- [ArchWiki: UEFI](https://wiki.archlinux.org/title/Unified_Extensible_Firmware_Interface)
- [Omarchy: Updates](https://omarchy.org/manual/updates/)
- [Omarchy: System Snapshots](https://omarchy.org/manual/system-snapshots/)
