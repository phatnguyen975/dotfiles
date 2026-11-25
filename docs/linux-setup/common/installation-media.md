# Create Installation Media

Use a dedicated USB flash drive that is large enough for the downloaded image. For Omarchy 4.5.0, a 16 GB or larger flash drive is a practical choice; the image writer will erase its contents.

## Download the ISO

Download the stable image from your distribution's official website, along with its published checksum and signature when available. Check that the architecture matches your computer.

For Omarchy 4.5.0 (x86-64):

- [Official ISO](https://iso.omarchy.org/omarchy-4.5.0-x86.iso)
- [SHA-256 File](https://iso.omarchy.org/omarchy-4.5.0-x86.iso.sha256)
- [Detached Signature](https://iso.omarchy.org/omarchy-4.5.0-x86.iso.sig)

For newer releases, obtain all three matching files from [Omarchy's official site](https://omarchy.org/) and confirm the current [stable release](https://github.com/omacom/omarchy/releases/latest). Do not mix files from different versions or architectures.

## Verify the Download

On Windows, open PowerShell in the download directory:

```powershell
Get-FileHash .\omarchy-4.5.0-x86.iso -Algorithm SHA256
Get-Content .\omarchy-4.5.0-x86.iso.sha256
```

Compare the entire 64-character hexadecimal hash (case does not matter). On Linux or WSL, with both files in the same directory, use:

```bash
sha256sum -c omarchy-4.5.0-x86.iso.sha256
```

The result must be `OK`, or the Windows hashes must match. If they do not, discard the affected image and download again.

A matching checksum detects corruption but does not independently authenticate the publisher. For stronger assurance, use GnuPG on Linux, WSL or Windows with GnuPG installed, and follow the [official ISO repository's verification instructions](https://github.com/omacom/omarchy-iso#readme).

```bash
gpg --keyserver hkps://keys.openpgp.org --recv-keys 40DFB630FF42BCFFB047046CF0134EE680CAC571
gpg --fingerprint 40DFB630FF42BCFFB047046CF0134EE680CAC571
gpg --verify omarchy-4.5.0-x86.iso.sig omarchy-4.5.0-x86.iso
```

Independently compare the full fingerprint with the official repository. Require a valid signature from the published key; a GPG warning about personal trust is different from a bad signature or wrong key.

## Write the USB

Use a writer supported by your distribution. For Omarchy, the official manual recommends Rufus on Windows, balenaEtcher on macOS, and caligula on Linux.

### Rufus on Windows

1. Download [Rufus](https://rufus.ie/) and connect only the installer USB, not the external target or backup drive.
2. Under **Device**, identify the correct flash drive using [disk identification](disk-identification.md).
3. Under **Boot selection**, select the verified ISO. Keep the image-compatible settings offered by Rufus; if editable for an ISO-mode write, use GPT and UEFI (non-CSM) for this guide.
4. Click **Start**. For Omarchy, raw DD Image mode is a reasonable choice if Rufus offers it; it writes the existing image layout rather than imposing a new partition scheme. For other distributions, follow their documented writer mode.
5. Confirm the erase warning only after checking the target again. Wait for completion and safely eject the drive.

### balenaEtcher

1. Download [balenaEtcher](https://etcher.balena.io/) for your platform.
2. Select the verified ISO with **Flash from file**, then select the installer USB with **Select target**.
3. Confirm the target and flash the image. Wait for writing and validation to finish.
4. Eject the USB safely; decline any Windows prompts to initialize or format unfamiliar partitions.

### Other Media Writers

On Linux, follow the official [caligula documentation](https://github.com/ifd3f/caligula) or your distribution's preferred tool. Ventoy can boot multiple images, but compatibility depends on the ISO and firmware; it is not the baseline Omarchy installation path in this guide.

Do not pre-wipe a flash drive just to write an ISO. If a writer fails, first verify the image, device, port and writer settings.

## Reset Installation Media (Optional)

Use this fallback on Windows only if the writer cannot handle the USB's existing partition layout. It is not required before a normal ISO write and will not fix a failing or hardware-write-protected drive.

**Warning:** The following reset removes every partition on the selected disk. Back up the installer USB, disconnect other unnecessary removable storage, and never use this procedure on a Windows disk, Linux target or backup drive.

Open Command Prompt as administrator and run:

```text
diskpart
list disk
```

Replace `<N>` with the current disk number of the installer USB, then run these commands inside DiskPart:

```text
select disk <N>
detail disk
list partition
```

Follow [Confirm Before Every Write](disk-identification.md#confirm-before-every-write). Continue only if the selected physical disk is the installer USB and all its contents may be lost.

Run the following command separately:

```text
clean
```

Check the result:

```text
list disk
list partition
exit
```

The selected disk should have no partitions and its space should be available for repartitioning. If cleaning fails, stop and investigate the error rather than forcing a write.

Return to [Write the USB](#write-the-usb). Do not initialize or format the USB first unless the chosen writer specifically requires it; the writer normally creates or copies the required layout.

## Verify the Media

Follow [Firmware and Boot](firmware-and-boot.md) to select the USB in UEFI mode. Confirm that the installer opens, then proceed only with the target selection specified by your installation guide.

Keep the installer USB available until the installed system has been verified. To reuse it as ordinary storage afterward, follow [Recovery and Cleanup](../recovery/README.md).

## References

- [Omarchy: Getting Started](https://omarchy.org/manual/getting-started/)
- [Omarchy ISO: Downloads and Signing](https://github.com/omacom/omarchy-iso)
- [Microsoft: DiskPart Clean](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/clean)
- [Rufus FAQ](https://github.com/pbatard/rufus/wiki/FAQ)
- [balenaEtcher](https://etcher.balena.io/)
- [Ventoy](https://www.ventoy.net/)
