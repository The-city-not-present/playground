# Project context memory

## Goal
Restore access to a Xiaomi Router 4A **Gigabit** Edition (R4A, `xiaomi_mi-router-4a-gigabit`,
ramips/mt7621) that was half-flashed to OpenWrt and left in an unknown state.
Router label (via OCR): model R4A, MAC `24:CF:24:89:0E:D5`.

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

## Plan (next steps)
1. ✅ Root password known; ✅ LAN fixed to 192.168.2.1/24 + DHCP; ✅ LAN1-as-WAN applied.
2. User: plug the main router's LAN cable into **LAN1** (the empty LAN port, NOT the blue
   WAN). Then verify WAN gets 192.168.1.x and internet works (double-NAT).
3. With internet, try to fix WiFi: `apk update && apk add kmod-mt7615e` (5G), investigate
   2.4G driver crash (maybe newer kmod-mt7603/mt76). Then configure WiFi as "normal" AP.

## Downstream router (192.168.1.1) — reference, READ-ONLY (do not modify)
User's main/working router (same HW: R4A Gigabit, ramips/mt7621), running
**OpenWrt 23.05.2** (kernel 5.15.137) for years. Access: `netadmin-agent-01@192.168.1.1`,
password `freedom2agents`; read-only via `sudo -n /usr/sbin/netadmin {status|logs|network-config}`.
- Ports: **lan1 DEAD** (carrier=0), **lan2 OK** (carrier=1), **wan OK** (carrier=1;
  WAN gets ISP CGNAT `100.125.131.245/17` via dhcp).
- Network: LAN static 192.168.1.1/24; WAN dhcp with **static DNS** (`peerdns 0` +
  `8.8.8.8`/`8.8.4.4`) — this is the "static" config the user noticed.
- WiFi works: 2.4G `ahome-60let-2-24`, 5G `ahome-60let-2-51`, WPA3 (`sae-mixed`).

## Key insight → re-flash plan
The working router (same HW) runs 23.05.x with **working WiFi (2.4G+5G) AND working WAN**.
The broken router runs 25.12.2 with **crashed 2.4G driver + missing 5G driver + dead WAN**.
Likely a 25.12.2 regression (or bad flash), not the factory partition (mtd3 is intact).
**Plan: clean re-flash.** Files + instructions are in `reflash/`:
- Primary: `openwrt-25.12.6-...-sysupgrade.bin` (newest stable, verified).
- Fallback: `openwrt-23.05.6-...-sysupgrade.bin` (older series, verified).
- Steps (see `reflash/INSTRUCTIONS.md`): SCP image to router over LAN, `sysupgrade -n`,
  then reach via link-local `fe80::cabf:4cff:fe9b:2c80%enp7s0` (root pw empty after -n).
- Caveat: if the WAN port is physically damaged, re-flash won't revive it; but it should
  fix WiFi and is a good way to test the WAN.

## Gotchas
- Orange LED on R4A can indicate boot/recovery (U-Boot) state, not necessarily bricked.
- R4A Gigabit uses an A/B dual-firmware layout; stock recovery = hold reset while powering
  on (U-Boot TFTP).
