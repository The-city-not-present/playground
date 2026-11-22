# Roadmap / Plan — restore the Xiaomi Router 4A Gigabit (v2)

## Objective
Boot the correct **23.05.6 v2** initramfs over TFTP, clean-flash the v2 squashfs
(`sysupgrade -n`), and verify WiFi (MT7663 5G + MT7603 2.4G) and WAN.

## Why this plan (context)
- The broken router is a **v2** board (5G = `14c3:7663` MT7663). It was half-flashed with the
  **v1** 25.12.2 image (wrong variant) → 5G "no driver" + 2.4G `mt7603e` probe crash. Fix = flash
  the v2 23.05.6 image (`d1bbbc98…` sysupgrade, `61920cdf…` initramfs).
- The router is in stock **U-Boot TFTP recovery** (blinking pink LED). That recovery is a **DHCP
  client** that learns IP+TFTP-server+bootfile from a DHCP reply, *then* TFTPs `test.bin`.
  dnsmasq serves both DHCP and TFTP.
- The single blocker is an **ARP stall**: U-Boot does not answer ARP for `192.168.31.1` after its
  RRQ, so dnsmasq never sends the first DATA block. Fix = pre-seed a **permanent** neighbour entry.

## Status (2026-11-22, end of session)
- **Transfer WORKS.** The ARP stall is fixed (a 1 s `ip neigh replace ... permanent` keep-alive
  loop defeats the link-down neighbour flush). The full 5.78 MB v2 initramfs downloads and is
  ACKed, at both 1468-byte (dnsmasq) and 512-byte (tftpserver.py) blocksizes.
- **Blocker moved.** The stock U-Boot downloads `test.bin` but does **not boot** it (no reboot, no
  traffic, stays blinking pink) and does **not flash** it. Not an image issue (CRC verified; v1/v2
  differ by only 2365 bytes).
- **Next:** serial console (UART 3.3 V, 115200) to see why U-Boot won't boot, or stock
  `miwifi.bin` restore via TFTP (this device has **no USB port**).

## Runbook (interruption-resilient — all over Ethernet `enp7s0`, no WiFi dependency)

### Phase 0 — clean host Ethernet baseline
```sh
agent-proxy dnsmasq stop
agent-proxy tcpdump stop
agent-proxy ip addr-flush --device enp7s0
agent-proxy ip addr-add   --device enp7s0 --address 192.168.31.100/24
agent-proxy ip link-set   --device enp7s0 up
agent-proxy ip addr --dev enp7s0          # expect 192.168.31.100/24
```
- Watch NM: "Wired connection 1" is `manual 192.168.1.1/24` and autoconnects; if it re-activates
  and flushes the recovery IP, either deactivate the profile or bring the IP back with the above.
- Confirm with the user: router powered on, RJ45 from enp7s0 → router **LAN** port, LED blinking
  pink.

### Phase 1 — TFTP-boot the v2 initramfs
```sh
# permanent ARP pre-seed (del + add, NOT replace; replace degrades to STALE->FAILED)
agent-proxy ip neigh-del --device enp7s0 --address 192.168.31.1
agent-proxy ip neigh-add --device enp7s0 --address 192.168.31.1 --lladdr 82:73:78:2e:b6:69
agent-proxy ip neigh --dev enp7s0   # MUST print ... PERMANENT (before power-cycling)

# one DHCP+TFTP server
agent-proxy dnsmasq start --interface enp7s0 --range 192.168.31.1,192.168.31.1,1h \
    --gateway 192.168.31.100 --boot test.bin \
    --tftp-root /home/andrej/work/xiaomi-openwrt-restore/reflash/tftp-root \
    --authoritative --no-dns --no-daemon

agent-proxy tcpdump capture --interface enp7s0 \
    --expression 'arp or udp port 67 or udp port 68 or udp port 69'
```
- Power-cycle holding **reset ~10 s** until the LED blinks, then release.
- **Success = TFTP DATA flows after the RRQ** (no `who-has 192.168.31.1` stall); dnsmasq logs
  `sent ... test.bin to 192.168.31.1`.

### Phase 2 — reach initramfs & clean-flash the v2 squashfs (Ethernet, not WiFi)
```sh
# wait ~1-2 min, then (empty root pw):
ssh root@fe80::cabf:4cff:fe9b:2c80%enp7s0        # link-local IPv6 (host needs IPv6 on enp7s0)
# or: set enp7s0 back to 192.168.1.10/24 and use 192.168.1.1 (no conflict now)

scp openwrt-23.05.6-...-v2-squashfs-sysupgrade.bin root@[fe80::cabf:4cff:fe9b:2c80%enp7s0]:/tmp/
ssh root@fe80::cabf:4cff:fe9b:2c80%enp7s0 "sha256sum /tmp/*.bin"   # expect d1bbbc98…
ssh root@fe80::cabf:4cff:fe9b:2c80%enp7s0 "sysupgrade -n /tmp/*.bin"   # SSH drops — expected
```

### Phase 3 — verify & configure
```sh
iw dev                              # expect phy0 (2.4G) + phy1 (5G)
dmesg | grep -iE 'mt7603|mt7615|mt76|probe'   # expect NO "probe failed"
cat /sys/class/net/wan/carrier      # 0 = WAN port still physically dead
uci set network.lan.ipaddr='192.168.2.1'      # LAN off 192.168.1.x to avoid main-router clash
uci set network.lan.netmask='255.255.255.0'
uci commit network && /etc/init.d/network restart
passwd                              # set a root password
# then configure WiFi (LuCI or uci)
```

## Open questions / risks
- Is the router currently powered on and in U-Boot recovery (blinking pink)? — ask the user.
- WAN (blue) port is likely physically dead — the reflash is the definitive test.
- If WiFi still fails after the v2 flash, try `apk add kmod-mt7615e` etc. (needs internet).

## Committed vs ideas
- **Committed:** TFTP recovery → `sysupgrade -n` v2 squashfs → verify WiFi/WAN → basic LAN config.
- **Ideas (post-recovery):** decide final LAN addressing (192.168.2.x vs 192.168.9.x); document
  the v2-vs-v1 gotcha; consider enabling attended sysupgrade for future upgrades.
