# Linux on Windows — Install Guide

A step-by-step guide to installing Linux on a Windows machine, covering the three most common approaches. Every generic step works for any modern 64-bit UEFI machine and any distro ISO; wherever a concrete example helps, it uses the same worked example throughout the whole repo: **Omarchy 4.0.4** (official ISO from omarchy.org) on a **Gigabyte A16** gaming laptop, with the install USB built from a **SanDisk** flash drive.

## Which method should I use?

|                           | [Method 1 — Full Disk](install-full-disk/README.md) | [Method 2 — Dual Boot](install-dual-boot/README.md) | [Method 3 — External SSD](install-external-ssd/README.md)        |
| ------------------------- | --------------------------------------------------- | --------------------------------------------------- | ---------------------------------------------------------------- |
| **Windows afterward**     | Erased completely                                   | Kept, shares the internal disk                      | Kept, completely untouched                                       |
| **Extra hardware needed** | None                                                | None                                                | An external SSD                                                  |
| **Risk level**            | High — no partial undo                              | Medium — resizes the disk Windows runs on           | Low — internal disk is never written to                          |
| **Setup complexity**      | Simplest (no partition math, no dual-boot menu)     | Moderate (partition shrink + `limine-scan` step)    | Moderate (boot-selection strategy to choose)                     |
| **Undo later**            | Reinstall Windows from scratch                      | Delete Linux partitions, extend Windows back        | Unplug the SSD, or wipe/reuse it                                 |
| **Best for**              | A machine that will be Linux-only going forward     | One machine, want both OSes always available        | Trying Linux without committing, or carrying it between machines |

If you're not sure, **Method 3** is the safest starting point — it's the only one of the three that can't damage your existing Windows install, since the installer never even sees the internal disk as a valid target unless you point it there yourself.

## Repository structure

```
linux-on-windows-install-guide/
├── references/              # Shared steps used by all 3 methods (read as needed — each file stands on its own, no need to read them in any particular order)
├── install-full-disk/       # Method 1 — full step-by-step guide + method-specific notes
├── install-dual-boot/       # Method 2 — full step-by-step guide + method-specific notes
└── install-external-ssd/    # Method 3 — full step-by-step guide + method-specific notes
```

Each method's `README.md` is a complete, start-to-finish guide for that method — it links out to the relevant files in `references/` at each step, and to its own `references/` subfolder for anything specific to that one method. You don't need to read anything in `references/` on its own first; just start with whichever method's `README.md` matches what you're doing, and follow the links as they come up.

## What's in `references/`

- [prerequisites.md](references/prerequisites.md) — backup checklist, UEFI/Secure Boot check, downloading and verifying the distro ISO
- [disk-and-usb-identification.md](references/disk-and-usb-identification.md) — **read this before running any command that can erase a disk.** How Windows and Linux name disks, and how to confirm you have the right one
- [usb-preparation.md](references/usb-preparation.md) — building a bootable install USB with Rufus, balenaEtcher, or Ventoy; using `diskpart` to reset a USB first if needed
- [bios-uefi-and-boot-menu.md](references/bios-uefi-and-boot-menu.md) — entering BIOS setup and the one-time boot menu (Dell, Lenovo, Asus, HP, Acer, MSI, Gigabyte — including the Gigabyte A16), and which settings to change and why
- [shared-data-partition.md](references/shared-data-partition.md) — setting up a partition both Windows and Linux can read/write normally, no permission issues
- [post-install.md](references/post-install.md) — first-boot checks, updating, and Limine's automatic snapshot/rollback feature
- [rollback-and-cleanup.md](references/rollback-and-cleanup.md) — reformatting a USB or external SSD back to normal storage, and restoring Windows after either a full-disk or dual-boot install

## A note on accuracy

Every non-obvious command or setting in this repo is explained (what it does, why that option), and every file ends with a **References** section linking to the actual sources used — mostly official documentation (Omarchy's own manual, Microsoft Learn, Arch Wiki, vendor support sites) rather than guesses. Software moves fast, though — Omarchy in particular ships frequent updates — so treat version numbers and exact screens as accurate as of when each file was last checked, and cross-reference the linked official docs if something on your screen doesn't match.
