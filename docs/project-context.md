# Project context memory

## Goal
Restore access to a Xiaomi Router 4A **Gigabit** Edition (R4A, ramips/mt7621) that was
half-flashed to OpenWrt and left in an unknown state.
Router label (via OCR): model R4A, MAC `24:CF:24:89:0E:D5`.

> **CRITICAL (2026-11-21): the board is a V2, not v1.** The 5 GHz chip is `14c3:7663`
> (**MT7663**). OpenWrt's image Makefile confirms: v1 bundles `kmod-mt76x2` (= MT7612 5G),
> while **v2 bundles `kmod-mt7615e kmod-mt7663-firmware-ap`** (= MT7663 5G). The earlier
> v1 firmware (25.12.2) was therefore the *wrong variant* — that is why 5G had "no driver"
> (MT7663 unbound) and WiFi was broken. Correct image prefix:
> `xiaomi_mi-router-4a-gigabit-v2`.

## Current state (2026-11-21) — router in U-Boot TFTP recovery (blinking pink LED)
The user attempted OpenWrt **failsafe** (hold reset ~10 s at power-on) but hit an IP conflict,
so nothing answered on 192.168.1.1. The router is now in the stock **U-Boot TFTP recovery**
mode, NOT failsafe and NOT normal OpenWrt. Verified live:
- enp7s0 (Ethernet to router) link UP: carrier=1, 100 Mbps, but no IPv4/IPv6 answer:
  - 192.168.1.1 → no reply (so NOT failsafe).
  - `fe80::cabf:4cff:fe9b:2c80` and `fdf0:e5a3:3ca6::1` → no reply (so NOT normal OpenWrt).
- LED = **blinking pink, non-stop** (30+ min) = U-Boot recovery waiting for a **DHCP** server
  (it TFTPs `test.bin` only after it gets a DHCP lease — see update 3).
- Host WiFi wlp6s0 still up (192.168.1.155/24 gw 192.168.1.1, main router). enp7s0 = no IP.

### IP-conflict gotcha (the user's concern was correct)
- OpenWrt **failsafe** LAN = **192.168.1.1** → collides with the main router + WiFi 192.168.1.x.
  Two interfaces on 192.168.1.0/24 = routing ambiguity (that's why ping gave
  "Destination Host Unreachable"). To use failsafe you MUST first `nmcli radio wifi off`
  (or disconnect the main-router WiFi) so Ethernet is the only 192.168.1.x interface.
- Stock **U-Boot TFTP recovery** = **192.168.31.1** (router) / **192.168.31.100** (host) →
  NO conflict with the main router. This is the path to take now (no need to drop WiFi).

### 2026-11-21 update — TFTP did NOT fire (no RRQ received)
Host set enp7s0 = 192.168.31.100/24, TFTP server listening on :69, router power-cycled
with reset held ~10 s → LED sequence unchanged (orange 5 s → orange blink → orange →
~dozens of s → pink blink forever) and **no TFTP RRQ** ever arrived. So the router is NOT
sending TFTP to 192.168.31.100 (either not in TFTP recovery, using a different server IP,
or only using a specific LAN port). Next diagnostic: `tcpdump` on enp7s0 during boot to see
exactly what (if anything) the router transmits, and try the other LAN port (lan1).

### 2026-11-21 update 2 — the router is a DHCP client (not TFTP)
`tcpdump -i enp7s0 -n -e` during boot shows the router broadcasting **DHCP DISCOVER**
(`0.0.0.0.68 → 255.255.255.255.67`) every ~2 s, from MAC **`82:73:78:2e:b6:69`** — a
locally-administered (fallback/random) MAC, NOT its normal `c8:bf:4c:9b:2c:80`. So the
router is running a DHCP client (U-Boot recovery doing DHCP, or OpenWrt with an interface in
`proto dhcp`) and waiting for an IP that never comes. Fix: serve DHCP (+TFTP) with dnsmasq —
see `reflash/dnsmasq-recovery.conf` (run `sudo dnsmasq --conf-file=... --no-daemon`).
Watch the log: DHCPACK → then either a TFTP RRQ (U-Boot → boots initramfs) or the router
comes up at 192.168.31.1 (OpenWrt → reach it over SSH/HTTP).

### 2026-11-21 update 3 — CONFIRMED U-Boot; recovery SUCCEEDED (DHCP → TFTP `test.bin`)
Answering DHCP with dnsmasq completed the recovery. The router is **U-Boot** — NOT an OpenWrt
fallback, NOT failsafe — and it only does TFTP *after* it gets a DHCP lease:

1. **DHCP DISCOVER** `0.0.0.0.68 → 255.255.255.255.67` from MAC `82:73:78:2e:b6:69`
   (locally-administered fallback MAC; host/laptop = `1c:75:08:61:17:51`). dnsmasq logged
   **`vendor class: U-Boot`** — that is the definitive proof it's the bootloader, not Linux.
   It requested options `1:netmask, 3:router, 6:dns-server, 12:hostname, 17:root-path`.
   It broadcasts for a **~28 s one-shot window per boot** (intervals 0.25s→0.5s→1s→2s), then
   goes silent while the LED keeps blinking pink. → dnsmasq must be running *before* the
   power-cycle (the earlier TFTP-only attempt saw no RRQ for exactly this reason).
2. dnsmasq `DHCPOFFER/ACK` handed it **192.168.31.1** (host = 192.168.31.100; `next server`/
   `server name` = 192.168.31.100, `bootfile` = `test.bin`).
3. Router ARPed `who-has 192.168.31.100`, then sent **`TFTP RRQ "test.bin"`**
   (`octet`, `timeout 5`, `blksize 1468`) from `192.168.31.1:1981` → `192.168.31.100:69`.
4. dnsmasq logged `dnsmasq-tftp: sent .../tftp-root/test.bin to 192.168.31.1`; tcpdump showed
   the full 1472-byte DATA / 4-byte ACK transfer completing (final partial block).

**Key takeaway:** a TFTP server alone is NOT enough. The R4A U-Boot recovery is a **DHCP
client** that learns its IP + TFTP-server + bootfile from the DHCP reply, *then* pulls
`test.bin`. One command does both:
`sudo dnsmasq --conf-file=reflash/dnsmasq-recovery.conf --no-daemon`.

**Where it ended (session hit the 1M-token context limit):** the initramfs
(`openwrt-25.12.6-...-initramfs-kernel.bin`, 7.4 MB) was served and the router went quiet
(booting it from RAM). The session died before confirming the initramfs came up. Next step:
give it ~1–2 min, then reach the initramfs OpenWrt and `sysupgrade -n` the squashfs image
(see `reflash/INSTRUCTIONS.md`):
- initramfs OpenWrt default LAN = **192.168.1.1** (empty root pw) — collides with the main
  router, so drop WiFi (`nmcli radio wifi off`) or use link-local IPv6
  `ssh root@fe80::cabf:4cff:fe9b:2c80%enp7s0`.
- Gotcha seen at that moment: enp7s0 had **no IPv6/link-local on the host**, so
  `ping6 fe80::cabf:4cff:fe9b:2c80` = 100% loss and ULA was unreachable — bring up the host's
  IPv6 (or use 192.168.1.x) before probing.

### TFTP recovery assets (already prepared)
- `reflash/tftpserver.py` — minimal read-only TFTP server, binds UDP :69 (needs root).
- `reflash/tftp-root/` — the initramfs uImage copied to `test.bin`, `miwifi.bin`,
  `initramfs.bin`, and the full `.bin` name (so any U-Boot filename request is served).

### 2026-11-21 update 4 — 25.12.6(v1) initramfs did NOT boot; switched to 23.05.6 v2
- The 25.12.6 v1 initramfs (`test.bin`, served 17:41) never came up: router stayed in
  U-Boot recovery (still blinking pink, no new DHCP lease after 17:41, no ARP answer on
  192.168.1.1). Image itself verified intact (uImage header + data CRC OK) — so the boot
  failed, not the transfer/image.
- Switched `reflash/tftp-root/*` to the **23.05.6 v2 initramfs** (kernel 5.15.189, the
  proven series + correct v2 variant), sha256 `61920cdf…` verified. v2 squashfs sysupgrade
  (`d1bbbc98…`) also downloaded + verified.

### 2026-11-21 update 5 — ROOT CAUSE FOUND: TFTP stalls on ARP (initramfs never downloads)
Captured recovery cycle (`reflash/recovery-tftp.txt`) shows the TFTP transfer NEVER starts:
- Router sends `TFTP RRQ "test.bin"` from `192.168.31.1:2053` → host `:69`.
- dnsmasq must send the first DATA block to `192.168.31.1`, so the kernel ARPs
  `who-has 192.168.31.1` — but the router's **U-Boot does NOT answer ARP** after the RRQ.
- So no DATA is ever sent; the router just sits blinking pink.

This means the initramfs was **never actually downloaded on any attempt** (the earlier
"transfer completed" note in update 3 was wrong). Root cause = dnsmasq can't resolve
`192.168.31.1 → MAC` and its ARP probes go unanswered. Fix = pre-seed the neighbour entry so
dnsmasq sends the TFTP DATA without needing ARP:
```
sudo ip neigh flush dev enp7s0
sudo ip neigh replace 192.168.31.1 lladdr 82:73:78:2e:b6:69 nud permanent dev enp7s0
```
(U-Boot recovery MAC `82:73:78:2e:b6:69` is stable across boots.)

> The previous session disconnected right after recording this finding, so the fix commands
> above were never delivered to the user. **Next step (unfinished):** apply the ARP pre-seed,
> re-trigger recovery (dnsmasq running, hold reset + power on), and confirm with tcpdump that
> TFTP DATA now flows and the initramfs comes up (192.168.1.1 / link-local
> `fe80::cabf:4cff:fe9b:2c80%enp7s0`).

### 2026-11-22 update 6 — TFTP STILL stalls: ARP pre-seed was never applied
Re-ran recovery 06:07–06:08 (dnsmasq + tcpdump captured in `dnsmasq-20261122-055217.log`
and `reflash/recovery-tftp-20261122-055552.txt`). DHCP handshake completed and dnsmasq
logged `sent ... test.bin to 192.168.31.1`, BUT the tcpdump shows the SAME ARP stall:
after `TFTP RRQ "test.bin"` the host ARPs `who-has 192.168.31.1` with no reply and NO TFTP
DATA ever goes out. `ip neigh show dev enp7s0` = `192.168.31.1 FAILED`. Root cause
unchanged: the `ip neigh replace ... nud permanent` pre-seed from update 5 was **never
applied** (absent from last-commands.md). Also found: **two dnsmasq instances** (PID 415143
from 2026-11-21, PID 456964 from 05:52) + tcpdump are still running — must kill all stale
ones and run exactly one dnsmasq. And enp7s0 has **no IPv6** (link-local missing), needed
later to reach the initramfs via `fe80::cabf:4cff:fe9b:2c80%enp7s0`.

**Next step (the only missing piece):** kill stale dnsmasq/tcpdump, flush + re-assert
enp7s0 = 192.168.31.100/24, pre-seed the ARP entry
(`ip neigh replace 192.168.31.1 lladdr 82:73:78:2e:b6:69 nud permanent dev enp7s0`), run ONE
dnsmasq, re-trigger recovery, and confirm TFTP DATA flows on tcpdump. Then boot initramfs →
`sysupgrade -n` the v2 squashfs. Files verified: `test.bin` = v2 initramfs (61920cdf…),
v2 squashfs d1bbbc98….

### 2026-11-22 update 7 — pre-seed applied but TFTP STILL stalls (entry not PERMANENT)
User ran steps 1+2 (cleanup + `ip neigh replace … nud permanent` + one dnsmasq + tcpdump +
power-cycle). Result (tcpdump 06:27:59): DHCP DISCOVER/OFFER worked (OFFER unicast to the
recovery MAC, no host ARP during DHCP), router ARPed `who-has 192.168.31.100` (host answered),
then `TFTP RRQ "test.bin"`, then the host sent **unicast** ARP probes `who-has 192.168.31.1 →
82:73:78:2e:b6:69` (×3, ~1 s apart) with **no reply** — and **NO TFTP DATA flowed**. So the
initramfs still never downloads. **Do NOT go to the flash step — the initramfs is not up.**

`ip neigh show dev enp7s0` now = `192.168.31.1 FAILED`, NOT `PERMANENT`. The pre-seed did not
hold. The **unicast** (not broadcast) probe proves the kernel *had* the MAC cached but in STALE
state (learned from the router's ARP request + RRQ), not PERMANENT — so it re-probed and went
FAILED. Root cause: U-Boot *sends* ARP requests (to find the TFTP server) but does NOT *answer*
ARP for its own 192.168.31.1 — so the host must never ARP for it.

**Next step (bulletproof re-run):** use `del`+`add` (NOT `replace`), and VERIFY the entry is
PERMANENT *before* power-cycling:
```
sudo ip neigh del 192.168.31.1 dev enp7s0 2>/dev/null || true
sudo ip neigh add 192.168.31.1 lladdr 82:73:78:2e:b6:69 nud permanent dev enp7s0
ip neigh show dev enp7s0     # MUST print: 192.168.31.1 lladdr 82:73:78:2e:b6:69 PERMANENT
```
Do NOT run `ip addr flush` / `ip link set down/up` AFTER the `add` (they clear neighbours).
Keep dnsmasq + tcpdump running, then power-cycle holding reset ~10 s. Success = TFTP DATA flows
after the RRQ (no more ARP probes). Also noted: NM shows enp7s0 "disconnected" (manual IP, no
active profile) and wlp6s0 "connected" — no IP conflict on 192.168.31.x; but NM could
auto-activate the wired profile and flush the manual IP (watch for it).

### 2026-11-22 update 8 — recovery tooling complete: the proxy covers the whole TFTP flow
The single blocker from update 7 (a *permanent* ARP pre-seed + recovery-subnet static IP) is now
implemented in `nmcli-proxy/agent-proxy` v2.1.0, so the whole U-Boot TFTP recovery can be driven by
the unprivileged agent without manual sudo. New privileged verbs:

- `ip addr-add --device <if> --address <IP/PREFIX>`  (was: `ip addr add ...`)
- `ip addr-flush --device <if>`                     (was: `ip addr flush dev ...`)
- `ip neigh-add --device <if> --address <IP> --lladdr <MAC> [--nud permanent]`
- `ip neigh-replace ...` / `ip neigh-del ...`
- `dnsmasq start --authoritative --no-dns ...`      (matches dnsmasq-recovery.conf)
- `tcpdump stop`                                    (pkill -x tcpdump)

Also fixed a real bug: `pkill_path()` resolved the `pkill -> pgrep` symlink, so `dnsmasq stop`
(and the new `tcpdump stop`) actually ran `pgrep -TERM` (invalid option, exit 2) instead of
signalling. `pkill` now keeps its name (the multi-call binary dispatches on argv[0]).

Recovery runbook (all via agent-proxy; install first with `sudo ./nmcli-proxy/install.sh --user <agent>`):
1. `agent-proxy dnsmasq stop` && `agent-proxy tcpdump stop`
2. `agent-proxy ip addr-flush --device enp7s0`
   `agent-proxy ip addr-add --device enp7s0 --address 192.168.31.100/24`
   `agent-proxy ip link-set --device enp7s0 up`
3. `agent-proxy ip neigh-del --device enp7s0 --address 192.168.31.1`
   `agent-proxy ip neigh-add --device enp7s0 --address 192.168.31.1 --lladdr 82:73:78:2e:b6:69`
   VERIFY `agent-proxy ip neigh --dev enp7s0` prints `... PERMANENT` *before* power-cycling.
4. `agent-proxy dnsmasq start --interface enp7s0 --range 192.168.31.1,192.168.31.1,1h \
       --gateway 192.168.31.100 --boot test.bin \
       --tftp-root /home/andrej/work/xiaomi-openwrt-restore/reflash/tftp-root \
       --authoritative --no-dns --no-daemon`
   `agent-proxy tcpdump capture --interface enp7s0 \
       --expression 'arp or udp port 67 or udp port 68 or udp port 69'`
5. Power-cycle holding reset ~10 s; success = TFTP DATA flows (no `who-has 192.168.31.1` stall).
6. initramfs at 192.168.1.1 / fe80::cabf:4cff:fe9b:2c80%enp7s0 -> `sysupgrade -n` the v2 squashfs.

## Current state (live, verified 2026-03-26)
- Host: `lenovo-Ideapad-Z560`, Linux Mint 22 (Wilma), NetworkManager.
- Agent runs as non-privileged user `agent-instance-01` (uid 1002).
- `nmcli-proxy` installed at `/usr/local/bin/nmcli-proxy` (wrapper around `nmcli`).
  - Read-only subcommands work (`list`, `devices`, `show`).
  - `doctor` now reports **OK**, but it checks the *wrong* user: it defaults to
    `os.getlogin()` (= `andrej`) while the effective sudo user is `agent-instance-01`.
    `sudo -n true` **still fails** ("a password is required"), so privileged nmcli
    (`set-static`, `set-dhcp`, …) is still unavailable to the agent. The sudoers rule for
    `agent-instance-01` is NOT installed.
- Network now:
  - `wlp6s0` (WiFi `ahome-60let-2-24`) = 192.168.1.155/24, gw 192.168.1.1 (working OpenWrt,
    MAC `50:64:2b:e8:6c:bc`). Internet OK.
  - `enp7s0` (Ethernet, RJ45 to the broken router) = **link UP** (carrier=1, 100 Mbps),
    NM profile "Wired connection 1", now `192.168.2.206/24` via DHCP from the router.

## Major discovery — the router is alive and reachable over IPv6
The broken R4A is running **OpenWrt** and fully reachable via Ethernet/IPv6 (no IPv4 needed):
- Router link-local: `fe80::cabf:4cff:fe9b:2c80` (Ethernet MAC `c8:bf:4c:9b:2c:80`;
  differs from the label MAC `24:cf:24:89:0e:d5`, which is the WAN/label MAC — normal).
- Router ULA address: **`fdf0:e5a3:3ca6::1`** (ping OK, ttl=64). ULA prefix
  `fdf0:e5a3:3ca6::/48` (OpenWrt auto-generated ULA).
- Services: **LuCI** HTTP 200 on port 80/443 (LuCI 26.082.75780), **dropbear SSH** on 22,
  Telnet (23) closed. Firmware = **OpenWrt 25.12.2** (r32802-f505120278, kernel 6.12.74).
  Package manager = **apk** (apk-tools 3.0.5) — `opkg` does NOT exist on this build
  (that's expected, not corruption).

## System health — VERIFIED not corrupted (2026-03-26)
- Filesystem: normal squashfs (`/rom`, ro) + jffs2 (`/overlay`, rw), overlay 5% used.
  No taints (`DISTRIB_TAINTS=''`). Correct board: `xiaomi,mi-router-4a-gigabit`.
- All core services running: rpcd, netifd, dnsmasq, odhcpd, dropbear, uhttpd.
- `sudo` absent on router = normal (OpenWrt has only root). `opkg` absent = normal
  (this build uses **apk**).

## Root cause & FIX APPLIED
README's "tried to assign 192.268.2.x" left the `lan` interface with `option ipaddr
'192.168.2.1'` but **no netmask**, so it came up as `192.168.2.1/32` → dnsmasq logged
`unable to set dhcp-range ... on interface 'br-lan'` → no DHCPv4 for the host.
**Fixed**: `uci set network.lan.netmask='255.255.255.0'` + commit + network reload.
Now `br-lan = 192.168.2.1/24`, route `192.168.2.0/24` present, dnsmasq serves
`192.168.2.100–192.168.2.249` (12h). Verified live.

## Credentials
- Router root password: **`freedom2agents`** (PROVISIONAL, set by the user 2026-03-26).
  Treat as temporary; user will likely rotate it. Not to be committed to git history
  (keep it only here / in local notes).

## Hardware/driver issues found (2026-03-26)
1. **WAN port (blue) is physically DEAD** — PHY (mt7530-0:04) is alive on MDIO
   (phy_id 0x03a29412) but never reports link, across many cable/partner tests, while
   LAN ports link every time. Hardware fault; not fixable in software.
2. **WiFi is broken (driver level)**:
   - 2.4G (MT7603, 14c3:7603): driver `mt7603e` probe **fails at boot** — WARNING in
     cfg80211 `core.c:964` then `probe ... failed with error -22` (EINVAL), after
     "Invalid MAC address" (uses random MAC). phy0 never registers.
   - 5G (MT7663, 14c3:7663): **no driver** — `kmod-mt7615e` not installed; device
     unbound. (Installed drivers: mt7603e, mt76x2e/MT7612 — wrong for 14c3:7663.)
   - Factory partition (mtd3) is INTACT (valid MACs + RF cal), so this is a
     firmware/driver issue, not hardware. Fix needs internet (`apk add kmod-mt7615e`,
     possibly updated kmod-mt7603/mt76).
3. **LED shows orange** — cosmetic; user prefers no custom overrides (leave as-is).

## Workaround applied: LAN1-as-WAN (a LAN port used as WAN)
Because the real WAN is dead and WiFi is broken, repurposed **LAN1 as the WAN**:
- `network.wan.device='lan1'` (proto dhcp), `network.wan6.device='lan1'`.
- `br-lan` now bridges **lan2 only** (laptop stays wired on lan2).
- Kept LAN = 192.168.2.1/24 + DHCP. Router does NAT LAN→WAN once LAN1 has a cable.

## Plan (next steps) — TFTP recovery (with ARP pre-seed), then clean re-flash
1. User (root): set the Ethernet to the recovery subnet (no WiFi conflict):
   `sudo ip addr flush dev enp7s0; sudo ip addr add 192.168.31.100/24 dev enp7s0; sudo ip link set enp7s0 up`
2. User (root): start the **DHCP+TFTP** server (dnsmasq does both — a TFTP server alone is
   NOT enough; the U-Boot must first get a DHCP lease):
   `sudo dnsmasq --conf-file=/home/andrej/work/xiaomi-openwrt-restore/reflash/dnsmasq-recovery.conf --no-daemon`
3. User (root): **pre-seed the ARP entry** so dnsmasq can send the TFTP DATA without ARP
   (U-Boot does NOT answer ARP for 192.168.31.1 after its RRQ):
   `sudo ip neigh replace 192.168.31.1 lladdr 82:73:78:2e:b6:69 nud permanent dev enp7s0`
4. Power-cycle the router holding **reset ~10 s** (LED blinking = recovery). Watch the
   dnsmasq log for `DHCPACK 192.168.31.1` then `dnsmasq-tftp: sent ... test.bin`.
5. initramfs OpenWrt boots (RAM only, no flash write yet). Reach it via link-local IPv6
   `fe80::cabf:4cff:fe9b:2c80%enp7s0` (or 192.168.1.1 with WiFi down), then SCP +
   `sysupgrade -n` the **23.05.6 v2 squashfs** image (see `reflash/INSTRUCTIONS.md`).

## Downstream router (192.168.1.1) — reference, READ-ONLY (do not modify)
User's main/working router (same HW: R4A Gigabit, ramips/mt7621), running
**OpenWrt 23.05.2** (kernel 5.15.137) for years. Access: `netadmin-agent-01@192.168.1.1`,
password `freedom2agents`; read-only via `sudo -n /usr/sbin/netadmin {status|logs|network-config}`.
- Ports: **lan1 DEAD** (carrier=0), **lan2 OK** (carrier=1), **wan OK** (carrier=1;
  WAN gets ISP CGNAT `100.125.131.245/17` via dhcp).
- Network: LAN static 192.168.1.1/24; WAN dhcp with **static DNS** (`peerdns 0` +
  `8.8.8.8`/`8.8.4.4`) — this is the "static" config the user noticed.
- WiFi works: 2.4G `ahome-60let-2-24`, 5G `ahome-60let-2-51`, WPA3 (`sae-mixed`).

## Key insight → re-flash plan (UPDATED: use V2 images)
The working router (same HW, but see v2 note) runs 23.05.x with **working WiFi (2.4G+5G) AND
working WAN**. The broken router ran **25.12.2 v1** (wrong variant!) → 5G driver missing
(MT7663 needs v2 build) + dead WAN. Root cause = wrong-variant firmware, not the factory
partition (mtd3 is intact).
**Plan: clean re-flash with the V2 images.** Files in `reflash/`:
- Primary: `openwrt-23.05.6-...-xiaomi_mi-router-4a-gigabit-v2-squashfs-sysupgrade.bin`
  (23.05.x = proven series; v2 = correct variant). Verified sha256 `d1bbbc98…`.
- Recovery initramfs (served via TFTP): `...-v2-initramfs-kernel.bin` (verified `61920cdf…`).
- Steps (see `reflash/INSTRUCTIONS.md`): TFTP-boot the v2 initramfs, then `sysupgrade -n`
  the v2 squashfs. Reach initramfs at 192.168.1.1 (empty pw) or link-local
  `fe80::cabf:4cff:fe9b:2c80%enp7s0` (LAN MAC `c8:bf:4c:9b:2c:80` from factory, stable).
- Caveat: WAN may still be physically dead; re-flash is the definitive test for WiFi.

## Gotchas
- Orange LED on R4A can indicate boot/recovery (U-Boot) state, not necessarily bricked.
- **Blinking pink LED, non-stop** = U-Boot TFTP recovery waiting for a file (not bricked,
  not failsafe). Give it a TFTP server at 192.168.31.100.
- R4A Gigabit uses an A/B dual-firmware layout; stock recovery = hold reset while powering
  on (U-Boot TFTP).
- Failsafe = 192.168.1.1 (conflicts with main router); U-Boot recovery = 192.168.31.1 (safe).
