# Re-flash — Xiaomi Mi Router 4A Gigabit Edition

## Context
- Device: Xiaomi Mi Router 4A Gigabit (ramips/mt7621, `xiaomi,mi-router-4a-gigabit-v2` — **v2**).
- Currently running: OpenWrt **25.12.2 v1** (the **wrong variant** — see below) with problems:
  - 5 GHz chip is `14c3:7663` (**MT7663**), which only the **v2** image drives
    (`kmod-mt7615e` + `kmod-mt7663-firmware-ap`). The v1 build ships `kmod-mt76x2`
    (MT7612) → 5 GHz "no driver". **This is the root cause of the broken WiFi.**
  - 2.4 GHz `mt7603e` also crashed at boot (wrong-variant side effect).
  - WAN (blue) port never links (possibly physical damage).
- Goal: clean re-flash with the correct **v2** image to fix WiFi (and test WAN).

## Files in this folder
| File | Role |
|---|---|
| `openwrt-23.05.6-ramips-mt7621-xiaomi_mi-router-4a-gigabit-v2-squashfs-sysupgrade.bin` | **PRIMARY** (correct v2 + proven 23.05 series) |
| `openwrt-23.05.6-ramips-mt7621-xiaomi_mi-router-4a-gigabit-v2-initramfs-kernel.bin` | **RECOVERY** (served via TFTP as `test.bin`) |
| `sha256sums-*.txt` | official checksums (already verified) |

Checksums (sha256):
- 23.05.6 v2 sysupgrade:  `d1bbbc980e772fa22a099975ce2ade58693f0cddcb80be6e87c80abf5f22b37f`
- 23.05.6 v2 initramfs:  `61920cdf67a3ef2e67abbef574b4ab87a03e07d755eb2383998abd867e21c031`

> The v1 images (`...-4a-gigabit-squashfs-sysupgrade.bin`, `...-4a-gigabit-initramfs-kernel.bin`)
> and the 25.12.6 images are the **wrong variant / wrong series for this router — do NOT flash.**

## Access & procedure (in-place, only if the router is reachable over SSH)
> **Current status: the router is in U-Boot TFTP recovery and is NOT reachable over SSH.**
> Go to **"Recovery if the router becomes unreachable after flash"** below first; come back
> here once the initramfs (or a normally-booted OpenWrt) is up.

Flash the correct **23.05.6 v2** sysupgrade image (do **not** use the 25.12.6 or v1 images —
they are the wrong series/variant for this board).

1. **Copy the image to the router** (reach it over link-local IPv6 — stable across re-flash):
   ```
   scp openwrt-23.05.6-ramips-mt7621-xiaomi_mi-router-4a-gigabit-v2-squashfs-sysupgrade.bin "root@[fe80::cabf:4cff:fe9b:2c80%enp7s0]:/tmp/"
   ```

2. **Verify checksum on the router:**
   ```
   ssh root@fe80::cabf:4cff:fe9b:2c80%enp7s0 "sha256sum /tmp/openwrt-23.05.6-ramips-mt7621-xiaomi_mi-router-4a-gigabit-v2-squashfs-sysupgrade.bin"
   ```
   Compare the printed hash with the value in "Files in this folder" above.

3. **Flash (clean wipe, `-n` = do NOT keep settings):**
   ```
   ssh root@fe80::cabf:4cff:fe9b:2c80%enp7s0 "sysupgrade -n /tmp/openwrt-23.05.6-ramips-mt7621-xiaomi_mi-router-4a-gigabit-v2-squashfs-sysupgrade.bin"
   ```
   Wait ~2 minutes for reboot. The SSH session will drop — that's expected.

4. **Reach the router after reboot** (LAN resets to `192.168.1.1`, root password is now **empty**):
   - Stable link-local address (derived from the LAN MAC, survives re-flash):
     ```
     ssh root@fe80::cabf:4cff:fe9b:2c80%enp7s0
     ```
     (no password — fresh OpenWrt allows empty-password root login on LAN)
   - `http://192.168.1.1` works too (the main router is on 192.168.9.x since 2026-11-22,
     so there is no conflict) — but the link-local SSH above is still the most reliable.

5. **Verify the fix:**
   ```
   iw dev                    # expect phy0 (2.4G) + phy1 (5G)
   dmesg | grep -iE 'mt7603|mt7615|mt76|ieee80211|probe'   # expect NO "probe failed"
   cat /sys/class/net/wan/carrier   # 0 = WAN port still physically dead
   ```

6. **Re-apply basic config** (LAN back to 192.168.2.x so it doesn't clash with the main router):
   ```
   uci set network.lan.ipaddr='192.168.2.1'
   uci set network.lan.netmask='255.255.255.0'
   uci commit network
   /etc/init.d/network restart
   passwd          # set a root password
   ```
   Then configure WiFi (LuCI → Network → Wireless, or `wifi config` + edit SSID/key).

## Recovery if the router becomes unreachable after flash
The R4A Gigabit has a stock U-Boot TFTP recovery (also the state the router falls into when
the firmware is missing/corrupt — the LED **blinks** (pink) continuously).

**Observed behaviour (2026-11-21, confirmed live):** in this state the router is the stock
**U-Boot** recovery (dnsmasq logs `vendor class: U-Boot`). It first broadcasts **DHCP DISCOVER**
(from a fallback MAC `82:73:78:2e:b6:69`) for a **~28 s one-shot window** per boot, gets its IP
+ TFTP-server + bootfile from the DHCP reply, and **only then** sends a **TFTP RRQ for `test.bin`**.
It does NOT send a TFTP RRQ on its own — so a TFTP server alone is not enough; the recovery needs a
**DHCP + TFTP** server (dnsmasq does both):

1. Put the Ethernet on the recovery subnet (a *different* subnet from the main router's
   192.168.9.x, so no IP conflict — WiFi can stay up):
   ```
   sudo ip addr flush dev enp7s0
   sudo ip addr add 192.168.31.100/24 dev enp7s0
   sudo ip link set enp7s0 up
   ```
   (Host = 192.168.31.100; the router gets **192.168.31.1** from DHCP.)
2. Stop the standalone TFTP server if it's still running, then run dnsmasq (DHCP + TFTP):
   ```
   sudo dnsmasq --conf-file=/home/andrej/work/xiaomi-openwrt-restore/reflash/dnsmasq-recovery.conf --no-daemon
   ```
   `reflash/tftp-root/` already contains the initramfs uImage copied to `test.bin`,
   `miwifi.bin`, `initramfs.bin` and the full filename; dnsmasq serves whichever is requested.
3. **Pre-seed the ARP entry (CRITICAL — without this the TFTP transfer stalls).** The router's
   U-Boot does **not** answer ARP for `192.168.31.1` after it sends the TFTP RRQ, so dnsmasq
   can't resolve that IP to a MAC and never sends the first DATA block. Give the kernel the
   MAC up front with a **permanent** neighbour entry. Use `del` + `add` — **NOT** `replace`
   (a `replace ... nud permanent` was observed to degrade to STALE→FAILED, re-ARPing and
   stalling again). **Verify it prints `PERMANENT` before power-cycling:**
   ```
   sudo ip neigh del 192.168.31.1 dev enp7s0 2>/dev/null || true
   sudo ip neigh add 192.168.31.1 lladdr 82:73:78:2e:b6:69 nud permanent dev enp7s0
   ip neigh show dev enp7s0   # MUST print: 192.168.31.1 lladdr 82:73:78:2e:b6:69 PERMANENT
   ```
   (The U-Boot recovery MAC `82:73:78:2e:b6:69` is stable across boots. Do NOT run
   `ip addr flush` / `ip link set down/up` after the `add` — they clear neighbours.)
4. Power off the router, hold **reset**, power on, keep holding ~10 s until the LED starts
   blinking, then release. (Make sure dnsmasq is already running *before* the power-cycle —
   the DHCP DISCOVER window is only ~28 s.) Watch the dnsmasq log:
   - `vendor class: U-Boot` → it's the bootloader (not OpenWrt).
   - `DHCPDISCOVER/REQUEST(enp7s0) 82:73:78:2e:b6:69` → `DHCPACK(enp7s0) 192.168.31.1 ...` → the
     router got its IP.
   - `dnsmasq-tftp: sent .../tftp-root/test.bin to 192.168.31.1` → U-Boot pulled the initramfs
     and is now booting it from RAM. (`test.bin` is the filename it requests. Note: before the
     ARP pre-seed in step 3, the transfer silently stalled — dnsmasq kept ARPing for
     `192.168.31.1` and no DATA was ever sent.)
5. Once the initramfs OpenWrt is up, reach it and flash the squashfs sysupgrade image
   (see "Procedure" above). The initramfs default LAN is **192.168.1.1** (empty root password),
   or use link-local IPv6 `ssh root@fe80::cabf:4cff:fe9b:2c80%enp7s0` (needs the host to have
   IPv6 on `enp7s0`).

Note: OpenWrt **failsafe** (different from U-Boot recovery) uses 192.168.1.1. Since the main
router moved to 192.168.9.x (2026-11-22), there is no conflict — you no longer need to drop
WiFi to reach failsafe at 192.168.1.1.

## Important caveat
- Re-flashing **will very likely fix the WiFi** (driver crash + missing 5G driver).
- Re-flashing **may or may not fix the WAN** port — if it's a physically damaged jack,
  no software will revive it. This re-flash is the definitive test.
