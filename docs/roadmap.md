# Roadmap — options to recover the R4A Gigabit (v2)

## Objective
Get the stuck router booting again, then clean-flash the correct OpenWrt **v2** image
(`xiaomi_mi-router-4a-gigabit-v2`, 23.05.6).

## Current state (2026-11-22)
Stock U-Boot TFTP recovery. It downloads `test.bin` (OpenWrt initramfs) fully but does not boot or
flash it — reason unknown (no serial console). Image intact (CRC OK).

## The image options (what to serve to U-Boot), in order of likelihood
| # | Image / action | Why | Status |
|---|---|---|---|
| 1 | OpenWrt **v2** initramfs as `test.bin` | standard OpenWrt recovery path | **tried (20261121) — does not boot** |
| 2 | **Stock** Xiaomi firmware `miwifi_r4a_*.bin` (2.28.62 / 3.0.24) | U-Boot recovery is built to **flash** a stock image | **← next, most promising** |
| 3 | Stock firmware from `ilblogdicristiangallo/miwifitool-debrick-xiaomi` | alternate source of the same stock image | unvetted source; try if #2 unavailable |
| 4 | OpenWrt **v2** squashfs `sysupgrade` via TFTP | completeness | very unlikely (wrong format for U-Boot recovery) |
| 5 | UART serial console | read U-Boot's messages / interact directly | diagnostic; requires adapter |
| 6 | (after any shell) OpenWRTInvasion → OpenWrt v2, or **Breed** bootloader | the actual re-flash once we can run code | future |

The detailed, copy-paste steps live in `reflash-attempt-20261122/` — start at its `README.md`.
Each step file documents: **Why** (reasoning), **Requires** (inputs/prereqs), **Procedure**,
**Expected outcome**, and **Result** (how to judge success).

## Summary plan
1. `reflash-attempt-20261122/steps/00-baseline.md` — clean host state, confirm router in recovery.
2. `…/01-openwrt-initramfs.md` — re-confirm the known-fail behaviour (clean baseline).
3. `…/02-stock-openwrtinvasion.md` — **PRIMARY**: serve stock firmware; U-Boot should flash it.
4. `…/03-stock-ilblogdicristiangallo.md` — ALTERNATE source if the #3 file is unavailable.
5. `…/04-filename-blocksize.md` — vary filename/blocksize if flashing still doesn't trigger.
6. `…/05-uart-serial.md` — **last resort**: serial console to see why U-Boot ignores the image.
7. `…/06-after-recovery.md` — once stock/OpenWrt is up: OpenWRTInvasion → OpenWrt v2 (or Breed).

## Committed vs ideas
- **Committed now:** document + prepare the recovery steps; serve a stock `miwifi_r4a_*.bin`.
- **Ideas:** buy a UART adapter as the definitive fallback; flash Breed for future-proof recovery
  once we have a shell; re-test the WAN port (likely a hardware fault) after the re-flash.
