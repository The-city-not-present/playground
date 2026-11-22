# Step 06 — After recovery: OpenWRTInvasion → OpenWrt v2

## Why
Once the router boots (stock firmware from step 02/03/04, or via serial in step 05), we still need
the **correct OpenWrt v2** image. The path is: restore stock → run **OpenWRTInvasion** to get a
shell → flash OpenWrt v2 with `mtd`.

## Requires
- A booting router (stock at `192.168.31.1`).
- Internet on the host (to run OpenWRTInvasion and download the image).

## Procedure
1. Run OpenWRTInvasion (https://github.com/acecilia/OpenWRTInvasion) against the stock router →
   telnet/SSH root shell.
2. Flash OpenWrt v2 (`openwrt-23.05.6-…-v2-squashfs-sysupgrade.bin`, already in `assets/images/`,
   sha256 `d1bbbc98…`):
   ```sh
   # on the router, after copying the .bin to /tmp:
   mtd -e OS1 -r write /tmp/openwrt-23.05.6-…-v2-squashfs-sysupgrade.bin OS1
   ```
   (or `sysupgrade -n …` if already on OpenWrt)
3. Reboot, reach OpenWrt at `192.168.1.1` (empty root password) or link-local
   `fe80::cabf:4cff:fe9b:2c80%enp7s0`.
4. Verify: `iw dev` (phy0 + phy1), `dmesg | grep -i mt76` (no probe fail), `cat /sys/class/net/wan/carrier`.

## Result
- **Success:** OpenWrt v2 running with working 2.4G + 5G WiFi; WAN still likely dead (hardware).
- **Future idea:** flash **Breed** bootloader for a robust recovery in the future.
