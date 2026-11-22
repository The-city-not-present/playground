# Step 02 — Serve STOCK Xiaomi firmware (OpenWRTInvasion source) — PRIMARY

## Why
The stock U-Boot recovery is a **flash** mode: it only acts on an image it recognises as an
official Xiaomi stock firmware (`miwifi_r4a_*.bin`, with Xiaomi's firmware header). The OpenWrt
initramfs lacks that header, which is most likely why it was ignored. Serving the stock image
should make U-Boot **flash it and reboot into stock**, after which we re-exploit with
OpenWRTInvasion and flash OpenWrt v2 properly.

## Requires
- A stock firmware image in `assets/images/`:
  - `miwifi_r4a_firmware_72d65_2.28.62.bin` (China 2.28.62) — MD5 `a3db7f937d279cf38c2a3bec09772d65`, SHA256 `07d3cead22e3c4fbe98eec29de5d5bea8dad12ade931179972ee56d2ac249060`
  - `miwifi_r4a_all_03233_3.0.24_INT.bin` (global 3.0.24) — MD5 `9c4a60addaad76dc13b6df6b4ac03233`, SHA256 `609b5b59b7b00365451fa358b5a79e0e4078b8a9a7aeb6a994a641287a093548`
  Both are the **vulnerable** versions OpenWRTInvasion targets.
- Baseline from step 00.

## Procedure
```sh
# 1. Put the stock image into the TFTP root under the conventional name
cp assets/images/miwifi_r4a_firmware_72d65_2.28.62.bin assets/tftp-root/miwifi.bin

# 2. Point dnsmasq at it (edit assets/dnsmasq-recovery.conf):
#    dhcp-boot=miwifi.bin,192.168.31.100,192.168.31.100

# 3. Same ARP pre-seed + keep-alive + dnsmasq + tcpdump as step 01.

# 4. Power-cycle holding reset ~10 s.
```

## Expected outcome
U-Boot downloads `miwifi.bin`, then **flashes** it: watch for a link flap / reboot in `dmesg` and
the router coming up as stock Xiaomi at `192.168.31.1` (LED should stop blinking pink).

## Result
- **Success:** router boots into stock → go to step 06 (OpenWRTInvasion → OpenWrt v2).
- **Still ignores it:** U-Boot downloaded but didn't flash → go to step 04 (filename/blocksize) and,
  if still stuck, step 05 (UART) to read the actual error.
