# Project context memory

## What this project is
Recover and cleanly re-flash a **Xiaomi Mi Router 4A Gigabit Edition (R4A)** that is stuck in the
stock bootloader's TFTP recovery. The board is the **v2** variant (5 GHz = MT7663). All live work
happens on the Linux host `lenovo-Ideapad-Z560` (Linux Mint 22); privileged networking is done
through the scoped-sudo `agent-proxy` helper (see `docs/development.md`).

## Current state — VERIFIED LIVE 2026-11-22
- **Step 00 (clean baseline) — COMPLETE (2026-11-22).** Host `enp7s0` = `192.168.31.100/24`, link UP
  with carrier; no `dnsmasq`/`tcpdump`/`tftpserver.py` running and UDP :69 is free (the stale
  root-owned `tftpserver.py` needed `sudo pkill -f tftpserver.py` — the agent's scoped sudo can't do
  this itself). Router confirmed in **U-Boot TFTP recovery** (LED blinking pink). → step 01 done.

- **Step 01 (serve OpenWrt v2 initramfs) — COMPLETE, expected result confirmed (2026-11-22).** Served
  `test.bin` (OpenWrt 23.05.6 v2 initramfs, sha256 `61920cdf…`) from a `/tmp` tftp-root via
  `agent-proxy dnsmasq start` (scoped sudo can't run `sudo dnsmasq --conf-file=…`, and `--tftp-root`
  is restricted to `/tmp`). Full DHCP→TFTP exchange confirmed: dnsmasq logged
  `sent test.bin to 192.168.31.1` twice = **the full 5.78 MB transferred and was ACKed**, but U-Boot
  **did not boot/flash it** (router stays in idle recovery, blinking pink). Unchanged from 20261121 →
  proceed to **step 02** (serve stock `miwifi_r4a_*.bin`).

- The broken router is **NOT reachable** and is **NOT running OpenWrt**. It sits in **stock U-Boot
  TFTP recovery** (LED blinks pink continuously). The Ethernet link is UP (cable connected) but the
  router answers nothing — `192.168.1.1` and `192.168.31.1` are both 100 % loss, and there is no
  IPv6 on `enp7s0`.
- We CAN make U-Boot **download** an image over DHCP+TFTP: it requests the DHCP `bootfile`
  (`test.bin` in our runs), and with a permanent ARP pre-seed kept alive every 1 s the full
  5.78 MB file transfers and is fully ACKed (verified at 1468-byte and 512-byte blocksizes).
- **But U-Boot neither boots nor flashes the downloaded OpenWrt initramfs.** It returns to idle
  recovery (blinking pink), no reboot, no further traffic. The image itself is intact (its internal
  uImage CRC verified OK). The reason is **unknown** — we have no serial console to read U-Boot's
  messages.
- **Most likely explanation:** the stock U-Boot recovery is a *flash* mode that only recognises a
  proper **stock Xiaomi firmware image** (`miwifi_r4a_*.bin`, which carries Xiaomi's firmware
  header), not a raw OpenWrt initramfs kernel. That is the next thing to try — see `docs/roadmap.md`
  and `reflash-attempt-20261122/`.

## Key facts (stable)
- Board: R4A **v2** (ramips/mt7621). 5 GHz chip = `14c3:7663` **MT7663** → needs OpenWrt's **`-v2`**
  image (bundles `kmod-mt7615e` + `kmod-mt7663-firmware-ap`). The v1 image ships `kmod-mt76x2`
  (MT7612) and leaves MT7663 unbound — that was the original "5 GHz no driver" bug.
- Stock U-Boot recovery MAC: `82:73:78:2e:b6:69` (locally administered, stable across boots).
- Recovery subnet: router = `192.168.31.1`, host = `192.168.31.100`. U-Boot does **not** answer ARP
  for itself after the TFTP RRQ → a `permanent` neighbour entry + a 1 s keep-alive loop is required,
  otherwise the transfer stalls at the first DATA block.
- U-Boot's TFTP filename is **DHCP-driven** (it requests whatever `bootfile` option we set).
- Stock Xiaomi default LAN = `192.168.31.1`. OpenWrt failsafe/initramfs default = `192.168.1.1`.
- The main/working router was renumbered to `192.168.9.x` on 2026-11-22 so it no longer clashes
  with OpenWrt's `192.168.1.1`.

## History (chronological)
1. **~2024** — bought the R4A Gigabit second-hand; stock Chinese firmware; internet, WiFi and WAN
   all worked perfectly (so the hardware was healthy when purchased).
2. **~2024–2025** — ran **OpenWRTInvasion** and flashed OpenWrt. In hindsight this was the **wrong
   (v1) variant**. Tried to move LAN to `192.168.2.x` to avoid clashing with the main router, lost
   access, and gave up (LED stayed permanently orange).
3. **2026-11-20/21** — resumed with agentic tooling (unprivileged `agent-instance-01` + `agent-proxy`).
   Regained access over IPv6 (ULA `fdf0:e5a3:3ca6::1`), fixed the `192.168.2.1` missing-netmask bug
   (it had no netmask, so `br-lan` came up as `/32` and DHCP broke). Diagnosis: **v1 firmware on a
   v2 board** → 5 GHz "no driver" (MT7663 unbound), 2.4 GHz `mt7603e` probe crash, WAN port
   physically dead (PHY alive on MDIO but never links), LED permanently orange.
4. **2026-11-21/22** — decided to clean re-flash. See `reflash-attempt-20261121/` (now an untouched
   archive). The router ended up in U-Boot TFTP recovery; after fixing the ARP stall the OpenWrt
   initramfs downloads fully but U-Boot won't boot/flash it. Reason unknown.

## Credentials (historical — only relevant once OpenWrt is reachable again)
- Broken router root password was `freedom2agents` (provisional, set during the 2026-11-20/21 work).
  Any clean re-flash resets it to empty.
- Main/working router (READ-ONLY reference, do not modify): `netadmin-agent-01@192.168.9.1`,
  password `freedom2agents`; OpenWrt 23.05.2. Full transcript in `working-router/`.

## Gotchas
- **`reflash-attempt-20261121/tftp-root/miwifi.bin` is NOT a stock image** — it is a byte-for-byte
  copy of the OpenWrt v2 initramfs renamed to `miwifi.bin`. Do not mistake it for stock firmware.
- Orange LED ≠ bricked. **Blinking pink LED = U-Boot TFTP recovery** (waiting for DHCP+TFTP).
  To enter recovery from power-off: hold **reset** while powering on → solid orange (~7 s) → blinking
  orange (~4 s) → solid orange again → **blinking pink** after ~15 s total. Timing varies (observed
  2 s–30 s), so keep holding reset until it turns pink.
- Stale `dnsmasq`/`tftpserver.py` instances (and a leftover listener on UDP :69) have caused
  confusion before — stop them before each run.
- dnsmasq's TFTP **DATA blocks use ephemeral ports** (not :69), so a tcpdump filter of
  `udp port 69` only shows the RRQ — it looks like the transfer "stalled". Use `udp or arp`
  (or `host 192.168.31.1`) to see DATA/ACKs; dnsmasq logs `sent <file> to <ip>` only after a full
  successful transfer.
- `ip neigh replace ... nud permanent` degrades to STALE→FAILED under link flap; use
  `ip neigh del` + `ip neigh add ... nud permanent` and re-assert it on a 1 s loop.
