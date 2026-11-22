# Step 01 — Serve the OpenWrt v2 initramfs (`test.bin`)

## Why
This is the standard OpenWrt recovery path. It was already tried in `reflash-attempt-20261121`,
where it **downloaded fully but did not boot or flash**. Re-running it once gives a clean,
documented baseline and confirms the bootloader behaviour is unchanged before we switch to the
stock image.

## Requires
- `assets/tftp-root/test.bin` (already present — the OpenWrt 23.05.6 v2 initramfs-kernel.bin,
  sha256 `61920cdf…`).
- Baseline from step 00.

## Procedure
```sh
# permanent ARP pre-seed (del + add, NOT replace)
agent-proxy ip neigh-del --device enp7s0 --address 192.168.31.1
agent-proxy ip neigh-add --device enp7s0 --address 192.168.31.1 --lladdr 82:73:78:2e:b6:69
agent-proxy ip neigh --dev enp7s0   # MUST print ... PERMANENT

# keep-alive loop (link flap on power-cycle flushes neighbours):
while true; do agent-proxy ip neigh-replace --device enp7s0 --address 192.168.31.1 \
  --lladdr 82:73:78:2e:b6:69 --nud permanent; sleep 1; done &

# one DHCP+TFTP server (dhcp-boot=test.bin in the conf)
sudo dnsmasq --conf-file=/home/andrej/work/xiaomi-openwrt-restore/reflash-attempt-20261122/assets/dnsmasq-recovery.conf --no-daemon &

# capture the exchange
agent-proxy tcpdump capture --interface enp7s0 --expression 'arp or udp port 67 or udp port 68 or udp port 69'

# power-cycle the router holding reset ~10 s until the LED blinks, then release.
```

## Expected outcome
DHCP DISCOVER → OFFER/ACK → `TFTP RRQ "test.bin"` → full 5.78 MB transfer with DATA + ACKs
(no `who-has 192.168.31.1` stall). Then U-Boot goes silent and the LED keeps blinking pink.

## Result
- **Downloads fully, still no boot/flash** (expected) → confirms behaviour unchanged → go to step 02.
- **No TFTP DATA** → the ARP pre-seed isn't PERMANENT; re-check `ip neigh show` and the keep-alive loop.
- **Unexpectedly boots** → great, skip to step 06 and flash the v2 squashfs.
