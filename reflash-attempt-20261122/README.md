# Re-flash attempt — 2026-11-22 (active)

This folder is the **active** recovery attempt. The previous attempt
(`../reflash-attempt-20261121/`) is an untouched archive.

## Current state
See `../../docs/project-context.md`. Short version: the router is in **U-Boot TFTP recovery**
(blinking pink LED). It downloads `test.bin` (OpenWrt initramfs) fully but does not boot or flash it.

## How to run
Read the numbered steps in `steps/` in order. Each step is self-contained and documents:
- **Why** (reasoning — why try it at all)
- **Requires** (inputs/prerequisites)
- **Procedure** (commands)
- **Expected outcome**
- **Result** (how to judge success/failure, and what to do next)

## Step order
| # | File | What | Expected |
|---|---|---|---|
| 00 | `steps/00-baseline.md` | clean host, confirm recovery state | ready to serve |
| 01 | `steps/01-openwrt-initramfs.md` | serve OpenWrt v2 initramfs (`test.bin`) | downloads, does NOT boot (re-confirm) |
| 02 | `steps/02-stock-openwrtinvasion.md` | **PRIMARY** — serve stock `miwifi_r4a_*.bin` | U-Boot flashes it → stock boots |
| 03 | `steps/03-stock-ilblogdicristiangallo.md` | ALTERNATE stock image source | same as 02 if 02's file unavailable |
| 04 | `steps/04-filename-blocksize.md` | vary filename/blocksize | only if 02/03 don't trigger flash |
| 05 | `steps/05-uart-serial.md` | serial console (diagnostic) | see why U-Boot ignores images |
| 06 | `steps/06-after-recovery.md` | once reachable: OpenWRTInvasion → OpenWrt v2 | final working OpenWrt |

## Assets
- `assets/tftp-root/` — what the TFTP server serves (put the file to serve here under the right name).
- `assets/images/` — downloaded images + hashes.
- `assets/dnsmasq-recovery.conf` — DHCP+TFTP config (edit `dhcp-boot=` per step).
- `assets/tftpserver.py` — standalone 512-byte-block TFTP server (alternative to dnsmasq TFTP).
