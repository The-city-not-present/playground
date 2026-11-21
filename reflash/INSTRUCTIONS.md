# Re-flash — Xiaomi Mi Router 4A Gigabit Edition

## Context
- Device: Xiaomi Mi Router 4A Gigabit (ramips/mt7621, `xiaomi,mi-router-4a-gigabit`, v1).
- Currently running: OpenWrt **25.12.2** with problems:
  - 2.4 GHz WiFi driver `mt7603e` crashes at boot (`probe ... failed with error -22`).
  - 5 GHz driver (`mt7615e`, chip 14c3:7663) is **not installed**.
  - WAN (blue) port never links (possibly physical damage).
- Goal: clean re-flash to test whether a newer build fixes the WiFi/WAN issues.

## Files in this folder
| File | Role |
|---|---|
| `openwrt-25.12.6-ramips-mt7621-xiaomi_mi-router-4a-gigabit-squashfs-sysupgrade.bin` | **PRIMARY** (newest stable) |
| `openwrt-23.05.6-ramips-mt7621-xiaomi_mi-router-4a-gigabit-squashfs-sysupgrade.bin` | **FALLBACK** (older 23.05) |
| `sha256sums-*.txt` | official checksums (already verified) |

Checksums (sha256):
- 25.12.6: `56009dfc5a32fbe9b044d8b5839cccb42ee623361c3852b2e57a75ceaa4c0459`
- 23.05.6: `bcdad4055c9bc4588faab8f94ccffe50c9640b0c5dfa6bb458e5407d15196f07`

## Access now (before flash)
- SSH: `ssh root@fdf0:e5a3:3ca6::1` (password `freedom2agents`).
- Laptop is on the router's LAN: Ethernet `enp7s0` = `192.168.2.206`, router = `192.168.2.1`.

## Procedure — try 25.12.6 first

1. **Copy the image to the router:**
   ```
   scp openwrt-25.12.6-ramips-mt7621-xiaomi_mi-router-4a-gigabit-squashfs-sysupgrade.bin "root@[fdf0:e5a3:3ca6::1]:/tmp/"
   ```

2. **Verify checksum on the router:**
   ```
   ssh root@fdf0:e5a3:3ca6::1 "sha256sum /tmp/openwrt-25.12.6-ramips-mt7621-xiaomi_mi-router-4a-gigabit-squashfs-sysupgrade.bin"
   ```
   Compare the printed hash with the value above.

3. **Flash (clean wipe, `-n` = do NOT keep settings):**
   ```
   ssh root@fdf0:e5a3:3ca6::1 "sysupgrade -n /tmp/openwrt-25.12.6-ramips-mt7621-xiaomi_mi-router-4a-gigabit-squashfs-sysupgrade.bin"
   ```
   Wait ~2 minutes for reboot. The SSH session will drop — that's expected.

4. **Reach the router after reboot** (LAN resets to `192.168.1.1`, root password is now **empty**):
   - Stable link-local address (derived from the LAN MAC, survives re-flash):
     ```
     ssh root@fe80::cabf:4cff:fe9b:2c80%enp7s0
     ```
     (no password — fresh OpenWrt allows empty-password root login on LAN)
   - `http://192.168.1.1` works too, BUT it collides with the main router's IP —
     prefer the link-local SSH above to avoid ambiguity.

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

## If 25.12.6 still has WiFi problems → downgrade to 23.05.6
Repeat the same steps using `openwrt-23.05.6-...-sysupgrade.bin`.
(23.05.x is the series your working main router runs — proven on identical hardware.)

## Recovery if the router becomes unreachable after flash
- The R4A Gigabit has U-Boot TFTP recovery: hold the **reset** button while powering on,
  then serve the initramfs image over TFTP:
  `openwrt-25.12.6-ramips-mt7621-xiaomi_mi-router-4a-gigabit-initramfs-kernel.bin`
  (downloadable from the same OpenWrt target directory).

## Important caveat
- Re-flashing **will very likely fix the WiFi** (driver crash + missing 5G driver).
- Re-flashing **may or may not fix the WAN** port — if it's a physically damaged jack,
  no software will revive it. This re-flash is the definitive test.
